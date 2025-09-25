"""
WoW (Week over Week) BigQuery client for Daily Dashboard
Handles WoW data fetching and query execution
"""

from typing import Dict, Any
import pandas as pd
from bigquery_base import BaseBigQueryClient


class WoWBigQueryClient(BaseBigQueryClient):
    """BigQuery client specifically for WoW (Week over Week) queries"""
    
    def __init__(self, service_account_path: str):
        """Initialize WoW BigQuery client"""
        super().__init__(service_account_path, "WoW")
    
    def get_wow_data(self, platform: str = "doordash") -> Dict[str, Any]:
        """Get Week over Week data - 7-day period vs previous 7-day period using dd_raw_financials_detailed_transactions_us"""
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
            return {}
        
        max_date = max_date_result['max_date'].iloc[0]
        if hasattr(max_date, 'strftime'):
            max_date_str = max_date.strftime("%Y-%m-%d")
        else:
            max_date_str = str(max_date)
        
        # Calculate date ranges
        date_ranges = self._calculate_date_ranges(max_date_str)
        
        # Use the WoW query with financial table - NO store filters for overall metrics
        query = self._get_financial_wow_query()
        
        # Replace placeholders in query
        query = query.replace('{{current_start_date}}', date_ranges['current_start_date'])
        query = query.replace('{{current_end_date}}', date_ranges['current_end_date'])
        query = query.replace('{{prev_start_date}}', date_ranges['prev_start_date'])
        query = query.replace('{{prev_end_date}}', date_ranges['prev_end_date'])
        
        df = self.execute_query(query, "WoW_Query")
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = f"{date_ranges['current_start_date']} to {date_ranges['current_end_date']}"
            result['previous_period_dates'] = f"{date_ranges['prev_start_date']} to {date_ranges['prev_end_date']}"
            return result
        return {}
    
    def _get_financial_wow_query(self) -> str:
        """Get WoW query using dd_raw_financials_detailed_transactions_us table - NO store filters for overall metrics"""
        return """
        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{{current_start_date}}' AND '{{current_end_date}}'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
                ELSE 0 
            END as sales_delta_percent,
            CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
                ELSE 0 
            END as orders_delta_percent
        FROM current_week c, previous_week p
        """
