"""
Store Level Performance BigQuery client for Daily Dashboard
Handles store-level data fetching and query execution
"""

from typing import Dict, List, Any
import pandas as pd
from bigquery_base import BaseBigQueryClient


class StoreBigQueryClient(BaseBigQueryClient):
    """BigQuery client specifically for store-level performance queries"""
    
    def __init__(self, service_account_path: str):
        """Initialize Store BigQuery client"""
        super().__init__(service_account_path, "Store")
    
    def get_store_level_data_for_operator(self, operator_name: str, store_ids: list) -> pd.DataFrame:
        """Get store-level data for a specific operator - only runs when operator is selected"""
        if not store_ids:
            return pd.DataFrame()
            
        # Get max date from the financial table
        max_date_query = """
        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        """
        max_date_result = self.execute_query(max_date_query)
        if max_date_result.empty:
            return pd.DataFrame()
        
        max_date = max_date_result['max_date'].iloc[0]
        if hasattr(max_date, 'strftime'):
            max_date_str = max_date.strftime("%Y-%m-%d")
        else:
            max_date_str = str(max_date)
        
        # Calculate date ranges
        date_ranges = self._calculate_date_ranges(max_date_str)
        
        # Build store filter for the specific operator's stores
        valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != "nan"]
        if not valid_store_ids:
            return pd.DataFrame()
            
        store_ids_str = "', '".join(valid_store_ids)
        store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        query = f"""
        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{date_ranges['current_start_date']}' AND '{date_ranges['current_end_date']}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            {store_filter}
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{date_ranges['prev_start_date']}' AND '{date_ranges['prev_end_date']}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            {store_filter}
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{date_ranges['current_month_start_date']}' AND '{date_ranges['current_month_end_date']}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            {store_filter}
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{date_ranges['prev_month_start_date']}' AND '{date_ranges['prev_month_end_date']}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            {store_filter}
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '{date_ranges['current_end_date']}'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('{store_ids_str}')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        """
        
        return self.execute_query(query, f"Store_Level_Data_{operator_name}")
    
    def get_ue_operator_wise_data_all_time(self, store_ids: list = None) -> pd.DataFrame:
        """Get all available UberEats operator-wise data without date filters"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        query = """
        WITH all_data AS (
          SELECT 
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as total_sales,
            SUM(CAST(ORDERS AS INT64)) as total_orders,
            AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
            COUNT(DISTINCT CAMPAIGN_NAME) as total_campaigns
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID, STORE_NAME
        )
        SELECT 
          STORE_ID,
          STORE_NAME,
          total_sales,
          total_orders,
          avg_roas,
          total_campaigns,
          0 as prev_sales,
          0 as prev_orders,
          0 as month_sales,
          0 as month_orders,
          0 as prev_month_sales,
          0 as prev_month_orders,
          0 as wow_sales_delta_percent,
          0 as mom_sales_delta_percent
        FROM all_data
        ORDER BY total_sales DESC
        """.format(
            project_id=self.project_id,
            store_filter=store_filter
        )
        try:
            return self.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_operator_wise_data_all_time: {e}")
            return pd.DataFrame()
    
    def get_ue_operator_wise_data(self, start_date: str, end_date: str, store_ids: list = None) -> pd.DataFrame:
        """Get operator-wise sales, orders, and ROAS data for UberEats with WoW and MoM calculations - using old data dates"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        # Use old UberEats data dates (May 2025)
        start_date = "2025-05-17"
        end_date = "2025-05-18"
        prev_start_date = "2025-05-15"
        prev_end_date = "2025-05-16"
        
        query = """
        WITH current_period AS (
          SELECT 
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as total_sales,
            SUM(CAST(ORDERS AS INT64)) as total_orders,
            AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
            COUNT(DISTINCT CAMPAIGN_ID) as total_campaigns
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{start_date}' AND '{end_date}'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID, STORE_NAME
        ),
        previous_period AS (
          SELECT 
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(ORDERS AS INT64)) as prev_orders,
            AVG(CAST(ROAS AS FLOAT64)) as prev_roas
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as month_sales,
            SUM(CAST(ORDERS AS INT64)) as month_orders
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(ORDERS AS INT64)) as prev_month_orders
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH)
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID, STORE_NAME
        )
        SELECT 
          cp.STORE_ID,
          cp.STORE_NAME,
          cp.total_sales,
          cp.total_orders,
          cp.avg_roas,
          cp.total_campaigns,
          COALESCE(pp.prev_sales, 0) as prev_sales,
          COALESCE(pp.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(pp.prev_sales, 0) > 0 THEN ((cp.total_sales - COALESCE(pp.prev_sales, 0)) / COALESCE(pp.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_period cp
        LEFT JOIN previous_period pp ON cp.STORE_ID = pp.STORE_ID
        LEFT JOIN current_month cm ON cp.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cp.STORE_ID = pm.STORE_ID
        ORDER BY cp.total_sales DESC
        """.format(
            project_id=self.project_id,
            start_date=start_date,
            end_date=end_date,
            prev_start_date=prev_start_date,
            prev_end_date=prev_end_date,
            store_filter=store_filter
        )
        return self.execute_query(query)
