"""
Campaign Level Performance BigQuery client for Daily Dashboard
Handles campaign-level data fetching and query execution
"""

from typing import Dict, List, Any
import pandas as pd
from bigquery_base import BaseBigQueryClient


class CampaignBigQueryClient(BaseBigQueryClient):
    """BigQuery client specifically for campaign-level performance queries"""
    
    def __init__(self, service_account_path: str):
        """Initialize Campaign BigQuery client"""
        super().__init__(service_account_path, "Campaign")
    
    def get_top_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get top performing campaigns using dd_raw_promotion_campaigns table with WoW and MoM calculations"""
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
        
        # Build store filter
        store_filter = ""
        if store_ids:
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        query = f"""
        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_start_date']}' AND '{date_ranges['current_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_start_date']}' AND '{date_ranges['prev_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_month_start_date']}' AND '{date_ranges['current_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_month_start_date']}' AND '{date_ranges['prev_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
            COALESCE(p.prev_sales, 0) as prev_sales,
            COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
            CASE 
              WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        """
        return self.execute_query(query)
    
    def get_todc_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get TODC campaigns (IS_SELF_SERVE_CAMPAIGN = true) using dd_raw_promotion_campaigns table with WoW and MoM calculations"""
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
        
        # Build store filter
        store_filter = ""
        if store_ids:
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        query = f"""
        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_start_date']}' AND '{date_ranges['current_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_start_date']}' AND '{date_ranges['prev_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_month_start_date']}' AND '{date_ranges['current_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_month_start_date']}' AND '{date_ranges['prev_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        """
        return self.execute_query(query, "TODC_Campaigns")
    
    def get_corporate_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get Corporate campaigns (IS_SELF_SERVE_CAMPAIGN = false) using dd_raw_promotion_campaigns table with WoW and MoM calculations"""
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
        
        # Build store filter
        store_filter = ""
        if store_ids:
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        query = f"""
        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_start_date']}' AND '{date_ranges['current_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_start_date']}' AND '{date_ranges['prev_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['current_month_start_date']}' AND '{date_ranges['current_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '{date_ranges['prev_month_start_date']}' AND '{date_ranges['prev_month_end_date']}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        """
        return self.execute_query(query, "Corporate_Campaigns")
    
    def get_ue_top_campaigns_all_time(self, store_ids: list = None) -> pd.DataFrame:
        """Get all available UberEats campaign data without date filters"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        query = """
        WITH all_campaigns AS (
          SELECT 
            CAMPAIGN_NAME,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as total_sales,
            SUM(CAST(ORDERS AS INT64)) as total_orders,
            AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        )
        SELECT 
          CAMPAIGN_NAME,
          STORE_NAME,
          total_sales,
          total_orders,
          avg_roas,
          campaign_days,
          0 as prev_sales,
          0 as prev_orders,
          0 as month_sales,
          0 as month_orders,
          0 as prev_month_sales,
          0 as prev_month_orders,
          0 as wow_sales_delta_percent,
          0 as mom_sales_delta_percent
        FROM all_campaigns
        ORDER BY total_sales DESC
        LIMIT 10
        """.format(
            project_id=self.project_id,
            store_filter=store_filter
        )
        try:
            return self.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_top_campaigns_all_time: {e}")
            return pd.DataFrame()
    
    def get_ue_top_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get top performing campaigns for UberEats"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        query = """
        WITH current_period AS (
          SELECT 
            CAMPAIGN_NAME,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as total_sales,
            SUM(CAST(ORDERS AS INT64)) as total_orders,
            AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-17' AND '2025-05-18'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        ),
        previous_period AS (
          SELECT 
            CAMPAIGN_NAME,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(ORDERS AS INT64)) as prev_orders
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-15' AND '2025-05-16'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        ),
        current_month AS (
          SELECT 
            CAMPAIGN_NAME,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as month_sales,
            SUM(CAST(ORDERS AS INT64)) as month_orders
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-01' AND '2025-05-18'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        ),
        previous_month AS (
          SELECT 
            CAMPAIGN_NAME,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(ORDERS AS INT64)) as prev_month_orders
          FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-04-01' AND '2025-04-18'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        """.format(
            project_id=self.project_id,
            store_filter=store_filter
        )
        return self.execute_query(query)
