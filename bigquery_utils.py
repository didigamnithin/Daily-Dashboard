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
    
    def execute_query(self, query: str) -> pd.DataFrame:
        """Execute a BigQuery and return results as DataFrame"""
        try:
            query_job = self.client.query(query)
            results = query_job.result()
            return results.to_dataframe()
        except Exception as e:
            st.error(f"Query execution failed: {str(e)}")
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
    
    def get_wow_data(self, start_date: str, end_date: str, platform: str = "doordash", store_ids: list = None) -> Dict:
        """Get Week over Week data - 7-day period vs previous 7-day period, excluding operators with WoW < -40%"""
        # Parse the provided dates
        start_dt = datetime.strptime(start_date, "%Y-%m-%d").date()
        end_dt = datetime.strptime(end_date, "%Y-%m-%d").date()
        
        # Calculate 7-day periods
        # Current period: end_date to 7 days back
        current_start_dt = end_dt - timedelta(days=6)  # 7 days total (inclusive)
        current_end_dt = end_dt
        
        # Previous period: 7 days before current period
        prev_end_dt = current_start_dt - timedelta(days=1)
        prev_start_dt = prev_end_dt - timedelta(days=6)  # 7 days total (inclusive)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        # Use the filtered WoW query that excludes operators with WoW < -20%
        if platform.lower() == "doordash":
            query = self._get_dd_wow_query_filtered(store_ids)
        else:
            query = self._get_ue_wow_query_filtered(store_ids)
        
        # Replace placeholders in query
        query = query.format(
            start_date=current_start_date,
            end_date=current_end_date,
            prev_start_date=prev_start_date,
            prev_end_date=prev_end_date
        )
        
        df = self.execute_query(query)
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = f"{current_start_date} to {current_end_date}"
            result['previous_period_dates'] = f"{prev_start_date} to {prev_end_date}"
            return result
        return {}
    
    def get_mom_data(self, platform: str = "doordash") -> Dict:
        """Get Month over Month data - this month till date over same dates last month"""
        if platform.lower() == "doordash":
            query = self._get_mom_query()
        else:
            query = self._get_ue_mom_query()
        df = self.execute_query(query)
        if not df.empty:
            result = df.iloc[0].to_dict()
            # Add calculation dates for display
            result['current_period_dates'] = "Sep 1 to Sep 10"  # This month till date
            result['previous_period_dates'] = "Aug 1 to Aug 10"  # Same dates last month
            return result
        return {}
    
    def get_positive_operators_wow_data(self, start_date: str, end_date: str, platform: str = "doordash") -> Dict:
        """Get WoW data aggregated only from operators with positive WoW performance"""
        # Parse the provided dates
        start_dt = datetime.strptime(start_date, "%Y-%m-%d").date()
        end_dt = datetime.strptime(end_date, "%Y-%m-%d").date()
        
        # Calculate 7-day periods
        # Current period: end_date to 7 days back
        current_start_dt = end_dt - timedelta(days=6)  # 7 days total (inclusive)
        current_end_dt = end_dt
        
        # Previous period: 7 days before current period
        prev_end_dt = current_start_dt - timedelta(days=1)
        prev_start_dt = prev_end_dt - timedelta(days=6)  # 7 days total (inclusive)
        
        current_start_date = current_start_dt.strftime("%Y-%m-%d")
        current_end_date = current_end_dt.strftime("%Y-%m-%d")
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        query = """
        WITH operator_performance AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as current_sales,
            SUM(CAST(p.ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{start_date}' AND '{end_date}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
          GROUP BY a.`Business Name`
        ),
        operator_previous_performance AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
          GROUP BY a.`Business Name`
        ),
        operator_wow AS (
          SELECT 
            c.operator_name,
            c.current_sales,
            c.current_orders,
            COALESCE(p.prev_sales, 0) as prev_sales,
            COALESCE(p.prev_orders, 0) as prev_orders,
            CASE 
              WHEN COALESCE(p.prev_sales, 0) > 0 
              THEN ((c.current_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100
              ELSE 0 
            END as wow_sales_delta_percent
          FROM operator_performance c
          LEFT JOIN operator_previous_performance p ON c.operator_name = p.operator_name
        )
        SELECT 
          SUM(current_sales) as current_sales,
          SUM(prev_sales) as prev_sales,
          SUM(current_orders) as current_orders,
          SUM(prev_orders) as prev_orders,
          COUNT(*) as positive_operators_count,
          CASE 
            WHEN SUM(prev_sales) > 0 
            THEN ((SUM(current_sales) - SUM(prev_sales)) / SUM(prev_sales)) * 100
            ELSE 0 
          END as sales_delta_percent
        FROM operator_wow
        WHERE wow_sales_delta_percent > 0
        """.format(
            start_date=current_start_date,
            end_date=current_end_date,
            prev_start_date=prev_start_date,
            prev_end_date=prev_end_date
        )
        
        df = self.execute_query(query)
        if not df.empty:
            result = df.iloc[0].to_dict()
            result['current_period_dates'] = f"{current_start_date} to {current_end_date}"
            result['previous_period_dates'] = f"{prev_start_date} to {prev_end_date}"
            return result
        return {}
    
    def get_positive_operators_mom_data(self, platform: str = "doordash") -> Dict:
        """Get MoM data aggregated only from operators with positive MoM performance"""
        query = """
        WITH operator_current_month AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as current_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as current_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-10'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
          GROUP BY a.`Business Name`
        ),
        operator_previous_month AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-10'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
          GROUP BY a.`Business Name`
        ),
        operator_mom AS (
          SELECT 
            c.operator_name,
            c.current_month_sales,
            c.current_month_orders,
            COALESCE(p.prev_month_sales, 0) as prev_month_sales,
            COALESCE(p.prev_month_orders, 0) as prev_month_orders,
            CASE 
              WHEN COALESCE(p.prev_month_sales, 0) > 0 
              THEN ((c.current_month_sales - COALESCE(p.prev_month_sales, 0)) / COALESCE(p.prev_month_sales, 0)) * 100
              ELSE 0 
            END as mom_sales_delta_percent
          FROM operator_current_month c
          LEFT JOIN operator_previous_month p ON c.operator_name = p.operator_name
        )
        SELECT 
          SUM(current_month_sales) as current_month_sales,
          SUM(prev_month_sales) as prev_month_sales,
          SUM(current_month_orders) as current_month_orders,
          SUM(prev_month_orders) as prev_month_orders,
          COUNT(*) as positive_operators_count,
          CASE 
            WHEN SUM(prev_month_sales) > 0 
            THEN ((SUM(current_month_sales) - SUM(prev_month_sales)) / SUM(prev_month_sales)) * 100
            ELSE 0 
          END as mom_sales_delta_percent
        FROM operator_mom
        WHERE mom_sales_delta_percent > 0
        """
        
        df = self.execute_query(query)
        if not df.empty:
            result = df.iloc[0].to_dict()
            result['current_period_dates'] = "Sep 1 to Sep 10"
            result['previous_period_dates'] = "Aug 1 to Aug 10"
            return result
        return {}
    
    def get_yoy_data(self, platform: str = "doordash") -> Dict:
        """Get Year over Year data"""
        query = self._get_yoy_query()
        df = self.execute_query(query)
        if not df.empty:
            return df.iloc[0].to_dict()
        return {}
    
    def get_daily_trend_data(self, days: int = 30) -> pd.DataFrame:
        """Get daily sales trend data using mcd_account_information table"""
        query = """
        SELECT 
          p.DATE,
          SUM(CAST(p.SALES AS FLOAT64)) as daily_sales,
          COUNT(DISTINCT p.CAMPAIGN_ID) as daily_campaigns,
          SUM(CAST(p.ORDERS AS INT64)) as daily_orders
        FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
        JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
          ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
        WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL {days} DAY)
          AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
          AND p.SALES IS NOT NULL
          AND p.SALES != 'null'
          AND p.SALES != ''
        GROUP BY p.DATE
        ORDER BY p.DATE
        """.format(
            project_id=self.project_id,
            days=days
        )
        return self.execute_query(query)
    
    def get_top_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get top performing campaigns using mcd_account_information table"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        query = """
        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-09'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME, a.`Business Name`
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-06' AND '2025-09-07'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME, a.`Business Name`
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-09'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME, a.`Business Name`
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-09'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME, a.`Business Name`
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.`Business Name`,
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
    
    def get_operator_wise_data(self, start_date: str, end_date: str, store_ids: list = None) -> pd.DataFrame:
        """Get operator-wise sales, orders, and ROAS data with WoW and MoM calculations using mcd_account_information table"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        # Calculate previous period dates for WoW
        from datetime import datetime, timedelta
        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")
        period_days = (end_dt - start_dt).days + 1
        
        prev_end_dt = start_dt - timedelta(days=1)
        prev_start_dt = prev_end_dt - timedelta(days=period_days - 1)
        
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        query = """
        WITH current_period AS (
          SELECT 
            p.STORE_ID,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(DISTINCT p.CAMPAIGN_ID) as total_campaigns
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{start_date}' AND '{end_date}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.STORE_ID, p.STORE_NAME, a.`Business Name`
        ),
        previous_period AS (
          SELECT 
            p.STORE_ID,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as prev_roas
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.STORE_ID, p.STORE_NAME, a.`Business Name`
        ),
        current_month AS (
          SELECT 
            p.STORE_ID,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), MONTH)
            AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.STORE_ID, p.STORE_NAME, a.`Business Name`
        ),
        previous_month AS (
          SELECT 
            p.STORE_ID,
            p.STORE_NAME,
            a.`Business Name`,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH), MONTH)
            AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH)
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY p.STORE_ID, p.STORE_NAME, a.`Business Name`
        )
        SELECT 
          cp.STORE_ID,
          cp.STORE_NAME,
          cp.`Business Name`,
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
    
    def get_operator_aggregated_data(self, start_date: str, end_date: str, operator_store_mapping: dict) -> pd.DataFrame:
        """Get aggregated data for each operator with WoW and MoM calculations using mcd_account_information table"""
        all_results = []
        
        # Calculate previous period dates for WoW
        from datetime import datetime, timedelta
        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")
        period_days = (end_dt - start_dt).days + 1
        
        prev_end_dt = start_dt - timedelta(days=1)
        prev_start_dt = prev_end_dt - timedelta(days=period_days - 1)
        
        prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
        prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        for operator_name, store_ids in operator_store_mapping.items():
            if not store_ids:
                continue
            
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if not valid_store_ids:
                continue
                
            # Use a safer approach - filter by store IDs only, not by operator name
            # This avoids SQL injection issues with special characters in operator names
            store_ids_str = "', '".join(valid_store_ids)
            store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
            
            # Complex query with WoW and MoM calculations using JOIN with mcd_account_information
            query = """
            WITH current_period AS (
              SELECT 
                SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
                SUM(CAST(p.ORDERS AS INT64)) as total_orders,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
                COUNT(DISTINCT p.CAMPAIGN_ID) as total_campaigns
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
              JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
                ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
              WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{start_date}' AND '{end_date}'
                AND p.SALES IS NOT NULL
                AND p.SALES != 'null'
                AND p.SALES != ''
                {store_filter}
            ),
            previous_period AS (
              SELECT 
                SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
                SUM(CAST(p.ORDERS AS INT64)) as prev_orders,
                AVG(CAST(p.ROAS AS FLOAT64)) as prev_roas
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
              JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
                ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
              WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
                AND p.SALES IS NOT NULL
                AND p.SALES != 'null'
                AND p.SALES != ''
                {store_filter}
            ),
            current_month AS (
              SELECT 
                SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
                SUM(CAST(p.ORDERS AS INT64)) as month_orders
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
              JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
                ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
              WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), MONTH)
                AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
                AND p.SALES IS NOT NULL
                AND p.SALES != 'null'
                AND p.SALES != ''
                {store_filter}
            ),
            previous_month AS (
              SELECT 
                SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
                SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns` p
              JOIN `{project_id}.merchant_portal_upload.mcd_account_information` a
                ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
              WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH), MONTH)
                AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH)
                AND p.SALES IS NOT NULL
                AND p.SALES != 'null'
                AND p.SALES != ''
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
    
    def _get_dd_wow_query(self, store_ids: list = None) -> str:
        """Get DoorDash WoW query using mcd_account_information table"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        return f"""
        WITH selected_period AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as current_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as current_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{{start_date}}' AND '{{end_date}}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
        ),
        previous_period AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as prev_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
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
        FROM selected_period, previous_period
        """
    
    def _get_dd_wow_query_filtered(self, store_ids: list = None) -> str:
        """Get DoorDash WoW query excluding operators with WoW < -40%"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND p.STORE_ID IN ('{store_ids_str}')"
        
        return f"""
        WITH operator_performance AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as current_sales,
            SUM(CAST(p.ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{{start_date}}' AND '{{end_date}}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY a.`Business Name`
        ),
        operator_previous_performance AS (
          SELECT 
            a.`Business Name` as operator_name,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            {store_filter}
          GROUP BY a.`Business Name`
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
    
    def _get_mom_query(self) -> str:
        """Get Month over Month query - this month till date over same dates last month"""
        return """
        WITH current_month AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as current_month_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as current_month_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as current_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-10'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
        ),
        previous_month AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as prev_month_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-10'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
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
    
    def _get_yoy_query(self) -> str:
        """Get Year over Year query using mcd_account_information table"""
        return """
        WITH current_year AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as current_year_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as current_year_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as current_year_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), YEAR)
            AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
        ),
        previous_year AS (
          SELECT 
            SUM(CAST(p.SALES AS FLOAT64)) as prev_year_sales,
            COUNT(DISTINCT p.CAMPAIGN_ID) as prev_year_campaigns,
            SUM(CAST(p.ORDERS AS INT64)) as prev_year_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          JOIN `todc-marketing.merchant_portal_upload.mcd_account_information` a
            ON p.STORE_ID = CAST(a.`DoorDash Store ID` AS STRING)
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 YEAR), YEAR)
            AND PARSE_DATE('%Y-%m-%d', p.DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 YEAR)
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
        )
        SELECT 
          current_year_sales,
          prev_year_sales,
          current_year_campaigns,
          prev_year_campaigns,
          current_year_orders,
          prev_year_orders,
          CASE 
            WHEN prev_year_sales > 0 THEN ((current_year_sales - prev_year_sales) / prev_year_sales) * 100
            ELSE 0
          END as yoy_sales_delta_percent,
          CASE 
            WHEN prev_year_orders > 0 THEN ((current_year_orders - prev_year_orders) / prev_year_orders) * 100
            ELSE 0
          END as yoy_orders_delta_percent
        FROM current_year, previous_year
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
