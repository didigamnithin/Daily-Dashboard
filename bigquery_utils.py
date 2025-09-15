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
    
    def get_pop_data(self, start_date: str, end_date: str, platform: str = "doordash", store_ids: list = None) -> Dict:
        """Get Period over Period data"""
        # Parse the provided dates
        start_dt = datetime.strptime(start_date, "%Y-%m-%d").date()
        end_dt = datetime.strptime(end_date, "%Y-%m-%d").date()
        
        # If start and end dates are the same (single day), use today-3 logic
        if start_dt == end_dt:
            # Use today-3 for current period, today-5 for previous period (2-day periods)
            today = datetime.now().date()
            
            # Current period: today-3 to today-2 (2 days)
            current_start = today - timedelta(days=3)
            current_end = today - timedelta(days=2)
            
            # Previous period: today-5 to today-4 (2 days)
            prev_start = today - timedelta(days=5)
            prev_end = today - timedelta(days=4)
            
            start_date = current_start.strftime("%Y-%m-%d")
            end_date = current_end.strftime("%Y-%m-%d")
            prev_start_date = prev_start.strftime("%Y-%m-%d")
            prev_end_date = prev_end.strftime("%Y-%m-%d")
        else:
            # Use the provided dates and calculate previous period
            period_days = (end_dt - start_dt).days + 1
            prev_end_dt = start_dt - timedelta(days=1)
            prev_start_dt = prev_end_dt - timedelta(days=period_days - 1)
            
            prev_start_date = prev_start_dt.strftime("%Y-%m-%d")
            prev_end_date = prev_end_dt.strftime("%Y-%m-%d")
        
        if platform.lower() == "doordash":
            query = self._get_dd_pop_query(store_ids)
        else:
            query = self._get_ue_pop_query(store_ids)
        
        # Replace placeholders in query
        query = query.format(
            start_date=start_date,
            end_date=end_date,
            prev_start_date=prev_start_date,
            prev_end_date=prev_end_date
        )
        
        df = self.execute_query(query)
        if not df.empty:
            return df.iloc[0].to_dict()
        return {}
    
    def get_mom_data(self, platform: str = "doordash") -> Dict:
        """Get Month over Month data"""
        if platform.lower() == "doordash":
            query = self._get_mom_query()
        else:
            query = self._get_ue_mom_query()
        df = self.execute_query(query)
        if not df.empty:
            return df.iloc[0].to_dict()
        return {}
    
    def get_yoy_data(self, platform: str = "doordash") -> Dict:
        """Get Year over Year data"""
        query = self._get_yoy_query()
        df = self.execute_query(query)
        if not df.empty:
            return df.iloc[0].to_dict()
        return {}
    
    def get_daily_trend_data(self, days: int = 30) -> pd.DataFrame:
        """Get daily sales trend data"""
        query = """
        SELECT 
          DATE,
          SUM(CAST(SALES AS FLOAT64)) as daily_sales,
          COUNT(DISTINCT CAMPAIGN_ID) as daily_campaigns,
          SUM(CAST(ORDERS AS INT64)) as daily_orders
        FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL {days} DAY)
          AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
          AND SALES IS NOT NULL
          AND SALES != 'null'
          AND SALES != ''
        GROUP BY DATE
        ORDER BY DATE
        """.format(
            project_id=self.project_id,
            days=days
        )
        return self.execute_query(query)
    
    def get_top_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get top performing campaigns"""
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-09-08' AND '2025-09-09'
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-09-06' AND '2025-09-07'
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-09-01' AND '2025-09-09'
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '2025-08-01' AND '2025-08-09'
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
          END as pop_sales_delta_percent,
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
          0 as pop_sales_delta_percent,
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
          0 as pop_sales_delta_percent,
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
    
    def get_operator_wise_data(self, start_date: str, end_date: str, store_ids: list = None) -> pd.DataFrame:
        """Get operator-wise sales, orders, and ROAS data with PoP and MoM calculations"""
        store_filter = ""
        if store_ids:
            # Filter out empty or invalid store IDs
            valid_store_ids = [str(sid).strip() for sid in store_ids if str(sid).strip() and str(sid).strip() != 'nan']
            if valid_store_ids:
                store_ids_str = "', '".join(valid_store_ids)
                store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        # Calculate previous period dates for PoP
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
            STORE_ID,
            STORE_NAME,
            SUM(CAST(SALES AS FLOAT64)) as total_sales,
            SUM(CAST(ORDERS AS INT64)) as total_orders,
            AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
            COUNT(DISTINCT CAMPAIGN_ID) as total_campaigns
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
          FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
          END as pop_sales_delta_percent,
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
        """Get aggregated data for each operator with PoP and MoM calculations"""
        all_results = []
        
        # Calculate previous period dates for PoP
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
                
            # Properly format store IDs for SQL IN clause
            store_ids_str = "', '".join(valid_store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
            
            # Complex query with PoP and MoM calculations
            query = """
            WITH current_period AS (
              SELECT 
                SUM(CAST(SALES AS FLOAT64)) as total_sales,
                SUM(CAST(ORDERS AS INT64)) as total_orders,
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
                COUNT(DISTINCT CAMPAIGN_ID) as total_campaigns
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
              FROM `{project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
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
              END as pop_sales_delta_percent,
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
    
    def _get_dd_pop_query(self, store_ids: list = None) -> str:
        """Get DoorDash PoP query"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        return f"""
        WITH selected_period AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as current_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as current_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{{start_date}}' AND '{{end_date}}'
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
            {store_filter}
        ),
        previous_period AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{{prev_start_date}}' AND '{{prev_end_date}}'
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
        FROM selected_period, previous_period
        """
    
    def _get_ue_pop_query(self, store_ids: list = None) -> str:
        """Get UberEats PoP query"""
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
    
    def _get_mom_query(self) -> str:
        """Get Month over Month query"""
        return """
        WITH current_month AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as current_month_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as current_month_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
        ),
        previous_month AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_month_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 MONTH)
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
        """Get Year over Year query"""
        return """
        WITH current_year AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as current_year_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as current_year_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_year_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), YEAR)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
        ),
        previous_year AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_year_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_year_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_year_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 YEAR), YEAR)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 YEAR)
            AND SALES IS NOT NULL
            AND SALES != 'null'
            AND SALES != ''
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
        """Get operator-wise sales, orders, and ROAS data for UberEats with PoP and MoM calculations - using old data dates"""
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
          END as pop_sales_delta_percent,
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
        """Get aggregated data for each operator with PoP and MoM calculations (UberEats) - using old data dates"""
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
            
            # Complex query with PoP and MoM calculations for UberEats
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
              END as pop_sales_delta_percent,
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
          END as pop_sales_delta_percent,
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
