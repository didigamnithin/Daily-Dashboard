"""
BigQuery utilities for Daily Dashboard
Handles connection, data fetching, and query execution
"""

import os
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Tuple
import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account
import streamlit as st


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
        # Calculate previous period dates
        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")
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
        query = self._get_mom_query()
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
        query = f"""
        SELECT 
          DATE,
          SUM(CAST(SALES AS FLOAT64)) as daily_sales,
          COUNT(DISTINCT CAMPAIGN_ID) as daily_campaigns,
          SUM(CAST(ORDERS AS INT64)) as daily_orders
        FROM `{self.project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL {days} DAY)
          AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
          AND SALES IS NOT NULL
          AND SALES != 'null'
        GROUP BY DATE
        ORDER BY DATE
        """
        return self.execute_query(query)
    
    def get_top_campaigns(self, days: int = 30, store_ids: list = None) -> pd.DataFrame:
        """Get top performing campaigns"""
        store_filter = ""
        if store_ids:
            store_ids_str = "', '".join(store_ids)
            store_filter = f"AND STORE_ID IN ('{store_ids_str}')"
        
        query = f"""
        SELECT 
          CAMPAIGN_NAME,
          STORE_NAME,
          SUM(CAST(SALES AS FLOAT64)) as total_sales,
          SUM(CAST(ORDERS AS INT64)) as total_orders,
          AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
          COUNT(*) as campaign_days
        FROM `{self.project_id}.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL {days} DAY)
          AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
          AND SALES IS NOT NULL
          AND SALES != 'null'
          {store_filter}
        GROUP BY CAMPAIGN_NAME, STORE_NAME
        ORDER BY total_sales DESC
        LIMIT 10
        """
        return self.execute_query(query)
    
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
    
    def _get_ue_pop_query(self) -> str:
        """Get UberEats PoP query"""
        return """
        WITH selected_period_ue AS (
          SELECT 
            SUM(CAST(REGEXP_REPLACE(SALES_USD, r'[$,]', '') AS FLOAT64)) as current_sales,
            COUNT(DISTINCT CAMPAIGN_UUID) as current_campaigns,
            SUM(CAST(ORDERS AS INT64)) as current_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
          WHERE START_DATE <= '{end_date}' AND END_DATE >= '{start_date}'
            AND SALES_USD IS NOT NULL
            AND SALES_USD != '$0'
            AND SALES_USD != 'null'
        ),
        previous_period_ue AS (
          SELECT 
            SUM(CAST(REGEXP_REPLACE(SALES_USD, r'[$,]', '') AS FLOAT64)) as prev_sales,
            COUNT(DISTINCT CAMPAIGN_UUID) as prev_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
          WHERE START_DATE <= '{prev_end_date}' AND END_DATE >= '{prev_start_date}'
            AND SALES_USD IS NOT NULL
            AND SALES_USD != '$0'
            AND SALES_USD != 'null'
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
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
            AND SALES IS NOT NULL
            AND SALES != 'null'
        ),
        previous_month AS (
          SELECT 
            SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
            COUNT(DISTINCT CAMPAIGN_ID) as prev_month_campaigns,
            SUM(CAST(ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
          WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 MONTH), MONTH)
            AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 MONTH)
            AND SALES IS NOT NULL
            AND SALES != 'null'
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
