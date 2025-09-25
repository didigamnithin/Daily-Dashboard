"""
Operator Level Performance BigQuery client for Daily Dashboard
Handles operator-level data fetching and query execution
"""

from typing import Dict, List, Any
import pandas as pd
from bigquery_base import BaseBigQueryClient


class OperatorBigQueryClient(BaseBigQueryClient):
    """BigQuery client specifically for operator-level performance queries"""
    
    def __init__(self, service_account_path: str):
        """Initialize Operator BigQuery client"""
        super().__init__(service_account_path, "Operator")
    
    def get_operator_aggregated_data(self, start_date: str, end_date: str, operator_store_mapping: dict) -> pd.DataFrame:
        """Get aggregated data for each operator with WoW and MoM calculations using dd_raw_financials_detailed_transactions_us"""
        all_results = []
        
        # Get max date from the financial table
        max_date_query = """
        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_ID = '5579'
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
        
        # Process each operator
        for operator_name, store_ids in operator_store_mapping.items():
            if not store_ids:
                continue
                
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if not valid_store_ids:
                continue
                
            # Use the operator query with financial table
            query = self._get_operator_financial_query(operator_name, valid_store_ids)
            
            # Replace placeholders in query using string replacement
            store_ids_str = "', '".join(valid_store_ids)
            query = query.replace('{{current_start_date}}', date_ranges['current_start_date'])
            query = query.replace('{{current_end_date}}', date_ranges['current_end_date'])
            query = query.replace('{{prev_start_date}}', date_ranges['prev_start_date'])
            query = query.replace('{{prev_end_date}}', date_ranges['prev_end_date'])
            query = query.replace('{{current_month_start_date}}', date_ranges['current_month_start_date'])
            query = query.replace('{{current_month_end_date}}', date_ranges['current_month_end_date'])
            query = query.replace('{{prev_month_start_date}}', date_ranges['prev_month_start_date'])
            query = query.replace('{{prev_month_end_date}}', date_ranges['prev_month_end_date'])
            query = query.replace('{store_ids_str}', store_ids_str)
            
            try:
                result = self.execute_query(query, f"Operator_{operator_name}")
                if not result.empty:
                    # Add operator name and store_count to the result
                    result_dict = result.iloc[0].to_dict()
                    result_dict['operator_name'] = operator_name
                    result_dict['store_count'] = len(valid_store_ids)
                    all_results.append(result_dict)
            except Exception as e:
                print(f"Error processing operator {operator_name}: {e}")
                continue
        
        if all_results:
            return pd.DataFrame(all_results).sort_values('total_sales', ascending=False)
        else:
            return pd.DataFrame()
    
    def get_operator_wise_data(self, start_date: str, end_date: str, store_ids: list = None) -> pd.DataFrame:
        """Get store-wise sales, orders, and ROAS data with WoW and MoM calculations using dd_raw_financials_detailed_transactions_us"""
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
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != "nan"]
            if valid_store_ids:
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
                {store_filter.replace('f.STORE_ID', 'p.STORE_ID')}
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
        return self.execute_query(query)
    
    def _get_operator_financial_query(self, operator_name: str, store_ids: list) -> str:
        """Get operator-level query using dd_raw_financials_detailed_transactions_us table"""
        store_ids_str = "', '".join(store_ids)
        
        return """
        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{current_start_date}}' AND '{{current_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('{store_ids_str}')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('{store_ids_str}')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{current_month_start_date}}' AND '{{current_month_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('{store_ids_str}')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{prev_month_start_date}}' AND '{{prev_month_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('{store_ids_str}')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '{{current_end_date}}'
                AND p.STORE_ID IN ('{store_ids_str}')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        """
