"""
BigQuery utilities for Daily Dashboard
Handles connection, data fetching, and query execution
"""

import os
import warnings
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Tuple
import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account
import streamlit as st

# Suppress BigQuery Storage warnings
warnings.filterwarnings("ignore", message="BigQuery Storage module not found")


class BigQueryClient:
    """BigQuery client wrapper for dashboard operations"""
    
    def __init__(self, service_account_path: str):
        """Initialize BigQuery client with service account credentials"""
        try:
            credentials = service_account.Credentials.from_service_account_file(
                service_account_path,
                scopes=["https://www.googleapis.com/auth/cloud-platform"]
            )
            self.client = bigquery.Client(credentials=credentials)
            self.project_id = "todc-marketing"
        except Exception as e:
            st.error(f"Failed to initialize BigQuery client: {str(e)}")
            raise
    
        # Load store IDs CSV
        self.store_ids_df = self._load_store_ids_csv()
    
    def _load_store_ids_csv(self) -> pd.DataFrame:
        """Load the STORE_IDs.csv file and return as DataFrame"""
        try:
            csv_path = "STORE_IDs.csv"
            if os.path.exists(csv_path):
                df = pd.read_csv(csv_path)
                print(f"✅ Loaded {len(df)} store records from STORE_IDs.csv")
                return df
            else:
                print(f"❌ STORE_IDs.csv not found at {csv_path}")
                return pd.DataFrame()
        except Exception as e:
            print(f"❌ Error loading STORE_IDs.csv: {e}")
            return pd.DataFrame()
    
    def get_store_ids_by_business_name(self, business_name: str) -> List[str]:
        """Get all DoorDash Store IDs for a given business name"""
        if self.store_ids_df.empty:
            return []
        
        # Filter by business name and get store IDs
        filtered_df = self.store_ids_df[self.store_ids_df['Business Name'] == business_name]
        store_ids = filtered_df['DoorDash Store ID'].astype(str).tolist()
        return store_ids
    
    def get_all_business_names(self) -> List[str]:
        """Get all unique business names from the CSV"""
        if self.store_ids_df.empty:
            return []
        return self.store_ids_df['Business Name'].unique().tolist()
    
    def _log_query(self, query: str, query_name: str = "query"):
        """Log query to queries.sql file for debugging"""
        try:
            with open("queries.sql", "a") as f:
                f.write(f"\n-- {query_name} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
                f.write(query)
                f.write("\n" + "="*80 + "\n")
        except Exception as e:
            print(f"Failed to log query: {e}")
    
    def execute_query(self, query: str, query_name: str = "query") -> pd.DataFrame:
        """Execute a BigQuery and return results as DataFrame"""
        try:
            # Log the query
            self._log_query(query, query_name)
            
            query_job = self.client.query(query)
            results = query_job.result()
            return results.to_dataframe()
        except Exception as e:
            st.error(f"Query execution failed: {str(e)}")
            # Log the failed query
            self._log_query(f"-- FAILED QUERY: {str(e)}\n{query}", f"FAILED_{query_name}")
            return pd.DataFrame()
    
    def get_max_date(self, platform: str = "doordash") -> str:
        """Get the maximum date available in the database"""
        try:
            if platform.lower() == "doordash":
                query = """
                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                """
            else:
                query = """
                SELECT MAX(DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
                WHERE DATE IS NOT NULL
                """
            
            df = self.execute_query(query)
            if not df.empty and not df['max_date'].iloc[0] is None:
                max_date_value = df['max_date'].iloc[0]
                # Handle both datetime and date objects
                if hasattr(max_date_value, 'strftime'):
                    return max_date_value.strftime("%Y-%m-%d")
                else:
                    return str(max_date_value)
            return None
        except Exception as e:
            st.error(f"Error getting max date: {e}")
            return None
    
    def get_wow_data(self, platform: str = "doordash") -> Dict:
        """Get Week over Week data - 7-day period vs previous 7-day period using dd_raw_financials_detailed_transactions_us"""
        # Get max date from the financial table
        max_date_query = """
        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_NAME = '5579'
        """
        max_date_result = self.execute_query(max_date_query)
        if max_date_result.empty:
            return {}
        
        max_date = max_date_result['max_date'].iloc[0]
        if hasattr(max_date, 'strftime'):
            max_date_str = max_date.strftime("%Y-%m-%d")
        else:
            max_date_str = str(max_date)
        
        # Calculate 7-day periods based on max_date
        # Current week = max_date - 1 down to max_date - 7
        # Previous week = max_date - 8 down to max_date - 14
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        current_start_dt = max_dt - timedelta(days=7)  # max_date - 7
        current_end_dt = max_dt - timedelta(days=1)    # max_date - 1
        
        prev_start_dt = max_dt - timedelta(days=14)    # max_date - 14
        prev_end_dt = max_dt - timedelta(days=8)       # max_date - 8
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        # Use the new WoW query with financial table - NO store filters for overall metrics
        query = self._get_financial_wow_query()
        
        # Replace placeholders in query
        query = query.replace('{{current_start_date}}', current_start_date)
        query = query.replace('{{current_end_date}}', current_end_date)
        query = query.replace('{{prev_start_date}}', prev_start_date)
        query = query.replace('{{prev_end_date}}', prev_end_date)
        
        df = self.execute_query(query, "WoW_Query")
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = f"{current_start_date} to {current_end_date}"
            result['previous_period_dates'] = f"{prev_start_date} to {prev_end_date}"
            return result
        return {}
    
    def get_mom_data(self, platform: str = "doordash") -> Dict:
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
        
        # Calculate month ranges based on max_date
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        # Previous month = Same day span in prior month
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current month: from first day of month to max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month: same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            # Handle day overflow (e.g., Jan 31 -> Feb 28/29)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                # If day doesn't exist in previous month, use last day of that month
                if max_dt.month - 1 in [4, 6, 9, 11]:  # 30-day months
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:  # February
                    # Check for leap year
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:  # 31-day months
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_month_start.strftime("%Y-%m-%d")
        current_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_end_date = prev_month_end.strftime("%Y-%m-%d")
        
        # Use the new MoM query with financial table - NO store filters for overall metrics
        query = self._get_financial_mom_query()
        
        # Replace placeholders in query
        query = query.replace('{{current_start_date}}', current_start_date)
        query = query.replace('{{current_end_date}}', current_end_date)
        query = query.replace('{{prev_start_date}}', prev_start_date)
        query = query.replace('{{prev_end_date}}', prev_end_date)
        
        df = self.execute_query(query, "MoM_Query")
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = f"{current_start_date} to {current_end_date}"
            result['previous_period_dates'] = f"{prev_start_date} to {prev_end_date}"
            return result
        return {}
    
    
    
    
    
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
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
          WHERE p.DATE BETWEEN '{current_start_date}' AND '{current_end_date}'

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
          WHERE p.DATE BETWEEN '{prev_start_date}' AND '{prev_end_date}'
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
          WHERE p.DATE BETWEEN '{current_month_start_date}' AND '{current_month_end_date}'
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
          WHERE p.DATE BETWEEN '{prev_month_start_date}' AND '{prev_month_end_date}'
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
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
          WHERE p.DATE BETWEEN '{current_start_date}' AND '{current_end_date}'
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
          WHERE p.DATE BETWEEN '{prev_start_date}' AND '{prev_end_date}'
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
          WHERE p.DATE BETWEEN '{current_month_start_date}' AND '{current_month_end_date}'
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
          WHERE p.DATE BETWEEN '{prev_month_start_date}' AND '{prev_month_end_date}'
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
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
          WHERE p.DATE BETWEEN '{current_start_date}' AND '{current_end_date}'
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
          WHERE p.DATE BETWEEN '{prev_start_date}' AND '{prev_end_date}'
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
          WHERE p.DATE BETWEEN '{current_month_start_date}' AND '{current_month_end_date}'
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
          WHERE p.DATE BETWEEN '{prev_month_start_date}' AND '{prev_month_end_date}'
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
    
    def get_ue_bottom_operators_by_sales(self, limit: int = 5) -> pd.DataFrame:
        """Get bottom performing operators by sales for UberEats"""
        query = """
        WITH operator_sales AS (
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
          GROUP BY STORE_ID, STORE_NAME
        )
        SELECT 
          STORE_ID,
          STORE_NAME,
          total_sales,
          total_orders,
          avg_roas,
          total_campaigns,
          'UberEats Store' as operator_name
        FROM operator_sales
        ORDER BY total_sales ASC
        LIMIT {limit}
        """.format(
            project_id=self.project_id,
            limit=limit
        )
        try:
            return self.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_bottom_operators_by_sales: {e}")
            return pd.DataFrame()
    
    def get_ue_bottom_stores_by_sales(self, limit: int = 5) -> pd.DataFrame:
        """Get bottom performing stores by sales for UberEats"""
        query = """
        WITH store_sales AS (
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
          GROUP BY STORE_ID, STORE_NAME
        )
        SELECT 
          STORE_ID,
          STORE_NAME,
          total_sales,
          total_orders,
          avg_roas,
          total_campaigns
        FROM store_sales
        ORDER BY total_sales ASC
        LIMIT {limit}
        """.format(
            project_id=self.project_id,
            limit=limit
        )
        try:
            return self.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_bottom_stores_by_sales: {e}")
            return pd.DataFrame()
    
    def get_ue_bottom_campaigns_by_sales(self, limit: int = 5) -> pd.DataFrame:
        """Get bottom performing campaigns by sales for UberEats"""
        query = """
        WITH campaign_sales AS (
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
          GROUP BY CAMPAIGN_NAME, STORE_NAME
        )
        SELECT 
          CAMPAIGN_NAME,
          STORE_NAME,
          total_sales,
          total_orders,
          avg_roas,
          campaign_days
        FROM campaign_sales
        ORDER BY total_sales ASC
        LIMIT {limit}
        """.format(
            project_id=self.project_id,
            limit=limit
        )
        try:
            return self.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_bottom_campaigns_by_sales: {e}")
            return pd.DataFrame()
    
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{current_start_date}' AND '{current_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{prev_start_date}' AND '{prev_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{current_month_start_date}' AND '{current_month_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{prev_month_start_date}' AND '{prev_month_end_date}'
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
            WHERE p.DATE = '{current_end_date}'
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{current_start_date}' AND '{current_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{prev_start_date}' AND '{prev_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{current_month_start_date}' AND '{current_month_end_date}'
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
            WHERE TIMESTAMP_UTC_DATE BETWEEN '{prev_month_start_date}' AND '{prev_month_end_date}'
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
            WHERE p.DATE = '{current_end_date}'
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
        
        # Calculate date ranges based on max_date
        max_dt = datetime.strptime(max_date_str, "%Y-%m-%d").date()
        
        # Current week = max_date - 1 down to max_date - 7
        current_start_dt = max_dt - timedelta(days=7)
        current_end_dt = max_dt - timedelta(days=1)
        
        # Previous week = max_date - 8 down to max_date - 14
        prev_start_dt = max_dt - timedelta(days=14)
        prev_end_dt = max_dt - timedelta(days=8)
        
        # Current month = DATE_TRUNC(max_date, MONTH) → max_date - 1
        current_month_start = max_dt.replace(day=1)
        current_month_end = max_dt - timedelta(days=1)
        
        # Previous month = Same day span in prior month
        if max_dt.month == 1:
            prev_month_start = max_dt.replace(year=max_dt.year - 1, month=12, day=1)
            prev_month_end = max_dt.replace(year=max_dt.year - 1, month=12, day=min(max_dt.day - 1, 31))
        else:
            prev_month_start = max_dt.replace(month=max_dt.month - 1, day=1)
            try:
                prev_month_end = max_dt.replace(month=max_dt.month - 1, day=max_dt.day - 1)
            except ValueError:
                if max_dt.month - 1 in [4, 6, 9, 11]:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=30)
                elif max_dt.month - 1 == 2:
                    year = max_dt.year if max_dt.month > 2 else max_dt.year - 1
                    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
                        prev_month_end = max_dt.replace(month=2, day=29)
                    else:
                        prev_month_end = max_dt.replace(month=2, day=28)
                else:
                    prev_month_end = max_dt.replace(month=max_dt.month - 1, day=31)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        current_month_start_date = current_month_start.strftime("%Y-%m-%d")
        current_month_end_date = current_month_end.strftime("%Y-%m-%d")
        prev_month_start_date = prev_month_start.strftime("%Y-%m-%d")
        prev_month_end_date = prev_month_end.strftime("%Y-%m-%d")
        
        # Process each operator
        for operator_name, store_ids in operator_store_mapping.items():
            if not store_ids:
                continue
                
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if not valid_store_ids:
                continue
                
            # Use the new operator query with financial table
            query = self._get_operator_financial_query(operator_name, valid_store_ids)
            
            # Replace placeholders in query using string replacement
            store_ids_str = "', '".join(valid_store_ids)
            query = query.replace('{{current_start_date}}', current_start_date)
            query = query.replace('{{current_end_date}}', current_end_date)
            query = query.replace('{{prev_start_date}}', prev_start_date)
            query = query.replace('{{prev_end_date}}', prev_end_date)
            query = query.replace('{{current_month_start_date}}', current_month_start_date)
            query = query.replace('{{current_month_end_date}}', current_month_end_date)
            query = query.replace('{{prev_month_start_date}}', prev_month_start_date)
            query = query.replace('{{prev_month_end_date}}', prev_month_end_date)
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
    
    
    
    def _get_ue_wow_query(self, store_ids: list = None) -> str:
        """Get UberEats WoW query"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        return f"""
        WITH selected_period_ue AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as current_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as current_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-17' AND '2025-05-18'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
        ),
        previous_period_ue AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-15' AND '2025-05-16'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
        )
        SELECT 
          current_sales,
          prev_sales,
          current_campaigns,
          prev_campaigns,
          current_orders,
          prev_orders,
          CASE 
            WHEN prev_sales > 0 THEN ((current_sales - prev_sales) / prev_sales) * 100
            ELSE 0
          END as sales_delta_percent,
          CASE 
            WHEN prev_orders > 0 THEN ((current_orders - prev_orders) / prev_orders) * 100
            ELSE 0
          END as orders_delta_percent
        FROM selected_period_ue, previous_period_ue
        """
    
    def _get_ue_wow_query_filtered(self, store_ids: list = None) -> str:
        """Get UberEats WoW query excluding operators with WoW < -40%"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        return f"""
        WITH operator_performance AS (
          SELECT 
            STORE_ID as operator_name,
            SUM(CAST(SALES AS FLOAT64)) as current_sales,
            SUM(CAST(ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{{start_date}}' AND '{{end_date}}'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID
        ),
        operator_previous_performance AS (
          SELECT 
            STORE_ID as operator_name,
            SUM(CAST(SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
          GROUP BY STORE_ID
        ),
        operator_wow AS (
          SELECT 
            COALESCE(op.operator_name, opp.operator_name) as operator_name,
            COALESCE(op.current_sales, 0) as current_sales,
            COALESCE(op.current_orders, 0) as current_orders,
            COALESCE(opp.prev_sales, 0) as prev_sales,
            COALESCE(opp.prev_orders, 0) as prev_orders,
            CASE 
              WHEN COALESCE(opp.prev_sales, 0) > 0 THEN ((COALESCE(op.current_sales, 0) - COALESCE(opp.prev_sales, 0)) / COALESCE(opp.prev_sales, 0)) * 100
              ELSE 0 
            END as wow_sales_delta_percent
          FROM operator_performance op
          FULL OUTER JOIN operator_previous_performance opp ON op.operator_name = opp.operator_name
        )
        SELECT 
          SUM(current_sales) as current_sales,
          SUM(prev_sales) as prev_sales,
          SUM(current_orders) as current_orders,
          SUM(prev_orders) as prev_orders,
          CASE 
            WHEN SUM(prev_sales) > 0 THEN ((SUM(current_sales) - SUM(prev_sales)) / SUM(prev_sales)) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
            WHEN SUM(prev_orders) > 0 THEN ((SUM(current_orders) - SUM(prev_orders)) / SUM(prev_orders)) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM operator_wow
        WHERE wow_sales_delta_percent >= -40
        """
    
    
    def _get_ue_mom_query(self) -> str:
        """Get UberEats Month over Month query"""
        return """
        WITH current_month AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as current_month_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as current_month_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_month_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-17' AND '2025-05-18'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
        ),
        previous_month AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_month_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-05-12' AND '2025-05-13'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
        )
        SELECT 
          current_month_sales,
          prev_month_sales,
          current_month_campaigns,
          prev_month_campaigns,
          current_month_orders,
          prev_month_orders,
          CASE 
            WHEN prev_month_sales > 0 THEN ((current_month_sales - prev_month_sales) / prev_month_sales) * 100
            ELSE 0
          END as mom_sales_delta_percent,
          CASE 
            WHEN prev_month_orders > 0 THEN ((current_month_orders - prev_month_orders) / prev_month_orders) * 100
            ELSE 0
          END as mom_orders_delta_percent
        FROM current_month, previous_month
        """
    
    
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
    
    def get_ue_operator_aggregated_data(self, start_date: str, end_date: str, operator_store_mapping: dict) -> pd.DataFrame:
        """Get aggregated data for each operator with WoW and MoM calculations (UberEats) - using old data dates"""
        all_results = []
        
        # Use old UberEats data dates (May 2025)
        start_date = "2025-05-17"
        end_date = "2025-05-18"
        prev_start_date = "2025-05-15"
        prev_end_date = "2025-05-16"
        
        for operator_name, store_ids in operator_store_mapping.items():
            if not store_ids:
                continue
            
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if not valid_store_ids:
                continue
                
            # Properly format store IDs for SQL IN clause
            store_ids_str = "', '".join(valid_store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
            
            # Complex query with WoW and MoM calculations for UberEats
            query = """
            WITH current_period AS (
              SELECT 
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
            ),
            previous_period AS (
              SELECT 
                SUM(CAST(SALES AS FLOAT64)) as prev_sales,
                SUM(CAST(ORDERS AS INT64)) as prev_orders,
                AVG(CAST(ROAS AS FLOAT64)) as prev_roas
              FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
              WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
                AND SALES IS NOT NULL
                AND SALES != 'null'
                AND SALES != ''
                {store_filter}
            ),
            current_month AS (
              SELECT 
                SUM(CAST(SALES AS FLOAT64)) as month_sales,
                SUM(CAST(ORDERS AS INT64)) as month_orders
              FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
              WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), MONTH)
                AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
                AND SALES IS NOT NULL
                AND SALES != 'null'
                AND SALES != ''
                {store_filter}
            ),
            previous_month AS (
              SELECT 
                SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
                SUM(CAST(ORDERS AS INT64)) as prev_month_orders
              FROM `{project_id}.merchant_portal_upload.ue_raw_promo_campaign_performance_for_non_storefront`
              WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH), MONTH)
                AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH)
                AND SALES IS NOT NULL
                AND SALES != 'null'
                AND SALES != ''
                {store_filter}
            )
            SELECT 
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
            LEFT JOIN previous_period pp ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
            """.format(
                project_id=self.project_id,
                start_date=start_date,
                end_date=end_date,
                prev_start_date=prev_start_date,
                prev_end_date=prev_end_date,
                store_filter=store_filter
            )
            
            result = self.execute_query(query)
            if not result.empty:
                # Add operator name and store_count to the result
                result_dict = result.iloc[0].to_dict()
                result_dict['operator_name'] = operator_name
                result_dict['store_count'] = len(valid_store_ids)
                all_results.append(result_dict)
        
        if all_results:
            return pd.DataFrame(all_results).sort_values('total_sales', ascending=False)
        else:
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
