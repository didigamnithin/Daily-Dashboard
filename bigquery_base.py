"""
Base BigQuery client for Daily Dashboard
Common functionality shared across all query clients
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


class BaseBigQueryClient:
    """Base BigQuery client wrapper for dashboard operations"""
    
    def __init__(self, service_account_path: str, client_name: str = "BaseClient"):
        """Initialize BigQuery client with service account credentials"""
        self.client_name = client_name
        try:
            credentials = service_account.Credentials.from_service_account_file(
                service_account_path,
                scopes=["https://www.googleapis.com/auth/cloud-platform"]
            )
            self.client = bigquery.Client(credentials=credentials)
            self.project_id = "todc-marketing"
            print(f"✅ {self.client_name} BigQuery client initialized successfully")
        except Exception as e:
            st.error(f"Failed to initialize {self.client_name} BigQuery client: {str(e)}")
            raise
    
    def _log_query(self, query: str, query_name: str = "query"):
        """Log query to queries.sql file for debugging"""
        try:
            with open("queries.sql", "a") as f:
                f.write(f"\n-- {self.client_name}_{query_name} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
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
            st.error(f"{self.client_name} Query execution failed: {str(e)}")
            # Log the failed query
            self._log_query(f"-- FAILED QUERY: {str(e)}\n{query}", f"FAILED_{query_name}")
            return pd.DataFrame()
    
    def get_max_date(self, platform: str = "doordash") -> str:
        """Get the maximum date available in the database"""
        try:
            if platform.lower() == "doordash":
                query = """
                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
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
    
    def _load_store_ids_csv(self) -> pd.DataFrame:
        """Load the STORE_IDs.csv file and return as DataFrame"""
        # Use class-level caching to avoid loading the same file multiple times
        if not hasattr(BaseBigQueryClient, '_csv_cache'):
            BaseBigQueryClient._csv_cache = None
        
        if BaseBigQueryClient._csv_cache is not None:
            return BaseBigQueryClient._csv_cache
            
        try:
            csv_path = "STORE_IDs.csv"
            if os.path.exists(csv_path):
                df = pd.read_csv(csv_path)
                BaseBigQueryClient._csv_cache = df
                print(f"✅ Loaded {len(df)} store records from STORE_IDs.csv (cached for all clients)")
                return df
            else:
                print(f"❌ STORE_IDs.csv not found at {csv_path}")
                BaseBigQueryClient._csv_cache = pd.DataFrame()
                return pd.DataFrame()
        except Exception as e:
            print(f"❌ Error loading STORE_IDs.csv: {e}")
            BaseBigQueryClient._csv_cache = pd.DataFrame()
            return pd.DataFrame()
    
    def get_store_ids_by_business_name(self, business_name: str) -> List[str]:
        """Get all DoorDash Store IDs for a given business name"""
        store_ids_df = self._load_store_ids_csv()
        if store_ids_df.empty:
            return []
        
        # Filter by business name and get store IDs
        filtered_df = store_ids_df[store_ids_df['Business Name'] == business_name]
        store_ids = filtered_df['DoorDash Store ID'].astype(str).tolist()
        return store_ids
    
    def get_all_business_names(self) -> List[str]:
        """Get all unique business names from the CSV"""
        store_ids_df = self._load_store_ids_csv()
        if store_ids_df.empty:
            return []
        return store_ids_df['Business Name'].unique().tolist()
    
    def _calculate_date_ranges(self, max_date_str: str) -> Dict[str, str]:
        """Calculate current week, previous week, current month, and previous month date ranges"""
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
                # Handle day overflow (e.g., Jan 31 -> Feb 28/29)
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
        
        return {
            'current_start_date': current_start_dt.strftime("%Y-%m-%d"),
            'current_end_date': current_end_dt.strftime("%Y-%m-%d"),
            'prev_start_date': prev_start_dt.strftime("%Y-%m-%d"),
            'prev_end_date': prev_end_dt.strftime("%Y-%m-%d"),
            'current_month_start_date': current_month_start.strftime("%Y-%m-%d"),
            'current_month_end_date': current_month_end.strftime("%Y-%m-%d"),
            'prev_month_start_date': prev_month_start.strftime("%Y-%m-%d"),
            'prev_month_end_date': prev_month_end.strftime("%Y-%m-%d")
        }
