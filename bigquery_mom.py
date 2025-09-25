"""
MoM (Month over Month) BigQuery client for Daily Dashboard
Handles MoM data fetching and query execution
"""

from typing import Dict, Any
import pandas as pd
from bigquery_base import BaseBigQueryClient


class MoMBigQueryClient(BaseBigQueryClient):
    """BigQuery client specifically for MoM (Month over Month) queries"""
    
    def __init__(self, service_account_path: str):
        """Initialize MoM BigQuery client"""
        super().__init__(service_account_path, "MoM")
    
    def get_mom_data(self, platform: str = "doordash") -> Dict[str, Any]:
        """Get Month over Month data using dd_raw_financials_detailed_transactions_us"""
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
            return {}
    
        max_date = max_date_result['max_date'].iloc[0]
        if hasattr(max_date, 'strftime'):
            max_date_str = max_date.strftime("%Y-%m-%d")
        else:
            max_date_str = str(max_date)
        
        # Calculate date ranges
        date_ranges = self._calculate_date_ranges(max_date_str)
        
        # Use the MoM query with financial table - NO store filters for overall metrics
        query = self._get_financial_mom_query()
        
        # Replace placeholders in query
        query = query.replace('{{current_start_date}}', date_ranges['current_month_start_date'])
        query = query.replace('{{current_end_date}}', date_ranges['current_month_end_date'])
        query = query.replace('{{prev_start_date}}', date_ranges['prev_month_start_date'])
        query = query.replace('{{prev_end_date}}', date_ranges['prev_month_end_date'])
        
        df = self.execute_query(query, "MoM_Query")
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = f"{date_ranges['current_month_start_date']} to {date_ranges['current_month_end_date']}"
            result['previous_period_dates'] = f"{date_ranges['prev_month_start_date']} to {date_ranges['prev_month_end_date']}"
            return result
        return {}
    
    def _get_financial_mom_query(self) -> str:
        """Get MoM query using dd_raw_financials_detailed_transactions_us table - NO store filters for overall metrics"""
        return """
        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{current_start_date}}' AND '{{current_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        """
