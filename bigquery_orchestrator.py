"""
BigQuery Orchestrator for Daily Dashboard
Handles parallel query execution and drilldown functionality
"""

import os
import concurrent.futures
from typing import Dict, List, Any, Optional, Tuple
import pandas as pd
import streamlit as st

# Import individual BigQuery clients
from bigquery_base import BaseBigQueryClient
from bigquery_wow import WoWBigQueryClient
from bigquery_mom import MoMBigQueryClient
from bigquery_operator import OperatorBigQueryClient
from bigquery_store import StoreBigQueryClient
from bigquery_campaign import CampaignBigQueryClient


class BigQueryOrchestrator:
    """Orchestrator for managing multiple BigQuery clients and parallel execution"""
    
    def __init__(self, service_account_path: str):
        """Initialize the orchestrator with all BigQuery clients"""
        self.service_account_path = service_account_path
        
        # Initialize all clients
        self.wow_client = WoWBigQueryClient(service_account_path)
        self.mom_client = MoMBigQueryClient(service_account_path)
        self.operator_client = OperatorBigQueryClient(service_account_path)
        self.store_client = StoreBigQueryClient(service_account_path)
        self.campaign_client = CampaignBigQueryClient(service_account_path)
        
        # Base client for common operations
        self.base_client = BaseBigQueryClient(service_account_path, "Orchestrator")
        
        print("✅ BigQuery Orchestrator initialized with all clients")
    
    def get_all_business_names(self) -> List[str]:
        """Get all unique business names from the CSV"""
        return self.base_client.get_all_business_names()
    
    def get_store_ids_by_business_name(self, business_name: str) -> List[str]:
        """Get all DoorDash Store IDs for a given business name"""
        return self.base_client.get_store_ids_by_business_name(business_name)
    
    def get_max_date(self, platform: str = "doordash") -> str:
        """Get the maximum date available in the database"""
        return self.base_client.get_max_date(platform)
    
    def run_initial_queries_parallel(self, platform: str = "doordash") -> Dict[str, Any]:
        """Run WoW, MoM, and Operator level queries in parallel when app opens"""
        print("🚀 Running initial queries in parallel...")
        
        # Get all business names and store IDs
        business_names = self.get_all_business_names()
        operator_store_mapping = {}
        for business_name in business_names:
            store_ids = self.get_store_ids_by_business_name(business_name)
            if store_ids:
                operator_store_mapping[business_name] = store_ids
        
        # Get max date for date calculations
        max_date = self.get_max_date(platform)
        if not max_date:
            return {"error": "Could not determine max date"}
        
        results = {}
        
        # Run queries in parallel using ThreadPoolExecutor
        with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
            # Submit all three queries
            wow_future = executor.submit(self.wow_client.get_wow_data, platform)
            mom_future = executor.submit(self.mom_client.get_mom_data, platform)
            operator_future = executor.submit(
                self.operator_client.get_operator_aggregated_data,
                max_date, max_date, operator_store_mapping
            )
            
            # Collect results
            try:
                results['wow_data'] = wow_future.result(timeout=60)
                print("✅ WoW query completed")
            except Exception as e:
                print(f"❌ WoW query failed: {e}")
                results['wow_data'] = {}
            
            try:
                results['mom_data'] = mom_future.result(timeout=60)
                print("✅ MoM query completed")
            except Exception as e:
                print(f"❌ MoM query failed: {e}")
                results['mom_data'] = {}
            
            try:
                results['operator_data'] = operator_future.result(timeout=120)
                print("✅ Operator query completed")
            except Exception as e:
                print(f"❌ Operator query failed: {e}")
                results['operator_data'] = pd.DataFrame()
        
        print("🎉 All initial queries completed!")
        return results
    
    def run_operator_drilldown_parallel(self, operator_name: str, platform: str = "doordash") -> Dict[str, Any]:
        """Run store-level queries for a specific operator when operator is clicked"""
        print(f"🔍 Running operator drilldown for: {operator_name}")
        
        # Get store IDs for the operator
        store_ids = self.get_store_ids_by_business_name(operator_name)
        if not store_ids:
            return {"error": f"No store IDs found for operator: {operator_name}"}
        
        results = {}
        
        # Run store-level queries in parallel
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as executor:
            if platform == "ubereats":
                # For UberEats, get all available data without date filters
                store_future = executor.submit(
                    self.store_client.get_ue_operator_wise_data_all_time,
                    store_ids
                )
            else:
                # For DoorDash, get store-level data for the operator
                store_future = executor.submit(
                    self.store_client.get_store_level_data_for_operator,
                    operator_name, store_ids
                )
            
            # Collect results
            try:
                results['store_data'] = store_future.result(timeout=90)
                print(f"✅ Store data query completed for {operator_name}")
            except Exception as e:
                print(f"❌ Store data query failed for {operator_name}: {e}")
                results['store_data'] = pd.DataFrame()
        
        return results
    
    def run_store_drilldown_parallel(self, store_id: str, platform: str = "doordash") -> Dict[str, Any]:
        """Run campaign-level queries for a specific store when store is clicked"""
        print(f"🔍 Running store drilldown for store ID: {store_id}")
        
        results = {}
        
        # Run campaign-level queries in parallel
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as executor:
            if platform == "ubereats":
                # For UberEats, get all available campaign data without date filters
                campaign_future = executor.submit(
                    self.campaign_client.get_ue_top_campaigns_all_time,
                    [store_id]
                )
                # For UberEats, we'll use the same data for both tables since we don't have IS_SELF_SERVE_CAMPAIGN
                results['todc_campaigns'] = campaign_future.result(timeout=60)
                results['corporate_campaigns'] = results['todc_campaigns']
            else:
                # For DoorDash, get both TODC and Corporate campaign data
                todc_future = executor.submit(
                    self.campaign_client.get_todc_campaigns,
                    30, [store_id]
                )
                corporate_future = executor.submit(
                    self.campaign_client.get_corporate_campaigns,
                    30, [store_id]
                )
                
                # Collect results
                try:
                    results['todc_campaigns'] = todc_future.result(timeout=60)
                    print(f"✅ TODC campaigns query completed for store {store_id}")
                except Exception as e:
                    print(f"❌ TODC campaigns query failed for store {store_id}: {e}")
                    results['todc_campaigns'] = pd.DataFrame()
                
                try:
                    results['corporate_campaigns'] = corporate_future.result(timeout=60)
                    print(f"✅ Corporate campaigns query completed for store {store_id}")
                except Exception as e:
                    print(f"❌ Corporate campaigns query failed for store {store_id}: {e}")
                    results['corporate_campaigns'] = pd.DataFrame()
        
        return results
    
    def get_operators_with_store_ids(self) -> Dict[str, List[str]]:
        """Get all unique operators with their store IDs from CSV"""
        business_names = self.get_all_business_names()
        operator_data = {}
        for business_name in business_names:
            store_ids = self.get_store_ids_by_business_name(business_name)
            if store_ids:
                operator_data[business_name] = store_ids
        return operator_data
    
    def get_store_ids_for_operators(self, selected_operators: List[str]) -> Optional[List[str]]:
        """Get DoorDash Store IDs for selected operators from CSV"""
        if not selected_operators or "All" in selected_operators:
            return None  # No filtering needed
        
        # Get store IDs for each selected operator from CSV
        all_store_ids = []
        for operator in selected_operators:
            store_ids = self.get_store_ids_by_business_name(operator)
            all_store_ids.extend(store_ids)
        
        # Remove duplicates and return
        unique_store_ids = list(set(all_store_ids))
        return unique_store_ids if unique_store_ids else None
    
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
                project_id=self.base_client.project_id,
                start_date=start_date,
                end_date=end_date,
                prev_start_date=prev_start_date,
                prev_end_date=prev_end_date,
                store_filter=store_filter
            )
            
            result = self.base_client.execute_query(query)
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
            project_id=self.base_client.project_id,
            limit=limit
        )
        try:
            return self.base_client.execute_query(query)
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
            project_id=self.base_client.project_id,
            limit=limit
        )
        try:
            return self.base_client.execute_query(query)
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
            project_id=self.base_client.project_id,
            limit=limit
        )
        try:
            return self.base_client.execute_query(query)
        except Exception as e:
            print(f"Error in get_ue_bottom_campaigns_by_sales: {e}")
            return pd.DataFrame()
