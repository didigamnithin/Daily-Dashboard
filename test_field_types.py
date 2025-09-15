"""
Test script to check data types of CSV and DB fields
This script will help identify data type mismatches between CSV and BigQuery table
"""

import pandas as pd
import os
from bigquery_utils import BigQueryClient
from config import Config

def test_csv_field_types():
    """Test and print data types from CSV file"""
    print("=" * 60)
    print("CSV FIELD TYPES ANALYSIS")
    print("=" * 60)
    
    try:
        csv_path = "Account Information-McDonalds.csv"
        df = pd.read_csv(csv_path)
        
        print(f"CSV File: {csv_path}")
        print(f"Total rows: {len(df)}")
        print(f"Total columns: {len(df.columns)}")
        print()
        
        # Focus on DoorDash Store ID column
        if 'DoorDash Store ID' in df.columns:
            print("DOORDASH STORE ID COLUMN ANALYSIS:")
            print("-" * 40)
            
            # Get data type info
            store_id_series = df['DoorDash Store ID']
            print(f"Pandas dtype: {store_id_series.dtype}")
            print(f"Non-null count: {store_id_series.count()}")
            print(f"Null count: {store_id_series.isnull().sum()}")
            
            # Sample values and their types
            print("\nSample values and their types:")
            sample_values = store_id_series.dropna().head(10)
            for i, value in enumerate(sample_values):
                print(f"  {i+1}. Value: '{value}' | Type: {type(value)} | str(): '{str(value)}'")
            
            # Check for unique values
            unique_values = store_id_series.dropna().unique()
            print(f"\nUnique values count: {len(unique_values)}")
            print(f"First 10 unique values: {list(unique_values[:10])}")
            
            # Test conversion to string
            print("\nCONVERSION TESTS:")
            print("-" * 20)
            test_values = sample_values.head(5)
            for value in test_values:
                try:
                    str_val = str(value)
                    int_val = int(float(value))
                    str_from_int = str(int_val)
                    print(f"Original: '{value}' -> str(): '{str_val}' -> int(float()): {int_val} -> str(int()): '{str_from_int}'")
                except Exception as e:
                    print(f"Original: '{value}' -> ERROR: {e}")
        
        print("\n" + "=" * 60)
        
    except Exception as e:
        print(f"Error reading CSV: {e}")

def test_db_field_types():
    """Test and print data types from BigQuery table"""
    print("BIGQUERY TABLE FIELD TYPES ANALYSIS")
    print("=" * 60)
    
    try:
        # Initialize BigQuery client
        client = BigQueryClient(Config.BIGQUERY_SERVICE_ACCOUNT_PATH)
        
        # Query to get sample data and schema info
        query = """
        SELECT 
            STORE_ID,
            TYPEOF(STORE_ID) as store_id_type,
            SALES,
            TYPEOF(SALES) as sales_type,
            ORDERS,
            TYPEOF(ORDERS) as orders_type,
            CAMPAIGN_ID,
            TYPEOF(CAMPAIGN_ID) as campaign_id_type,
            DATE,
            TYPEOF(DATE) as date_type
        FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE STORE_ID IS NOT NULL
        LIMIT 10
        """
        
        result = client.execute_query(query)
        
        if not result.empty:
            print("BIGQUERY TABLE SAMPLE DATA:")
            print("-" * 40)
            print(result.to_string())
            
            print("\nFIELD TYPE ANALYSIS:")
            print("-" * 20)
            for col in ['store_id_type', 'sales_type', 'orders_type', 'campaign_id_type', 'date_type']:
                if col in result.columns:
                    unique_types = result[col].unique()
                    print(f"{col.replace('_type', '').upper()}: {unique_types}")
            
            # Check STORE_ID values specifically
            print("\nSTORE_ID VALUES ANALYSIS:")
            print("-" * 30)
            store_ids = result['STORE_ID'].dropna().unique()
            print(f"Sample STORE_ID values: {list(store_ids[:10])}")
            print(f"STORE_ID data types: {[type(x) for x in store_ids[:5]]}")
            
        else:
            print("No data returned from BigQuery query")
            
    except Exception as e:
        print(f"Error querying BigQuery: {e}")
    
    print("\n" + "=" * 60)

def test_data_compatibility():
    """Test compatibility between CSV and DB data types"""
    print("DATA COMPATIBILITY TEST")
    print("=" * 60)
    
    try:
        # Read CSV data
        csv_path = "Account Information-McDonalds.csv"
        df = pd.read_csv(csv_path)
        
        # Get sample DoorDash Store IDs from CSV
        csv_store_ids = df['DoorDash Store ID'].dropna().head(5)
        print("CSV Store IDs (original):")
        for sid in csv_store_ids:
            print(f"  '{sid}' (type: {type(sid)})")
        
        # Convert to string format as used in the app
        converted_store_ids = []
        for sid in csv_store_ids:
            try:
                if pd.isna(sid) or str(sid).strip() == '' or str(sid).strip().lower() == 'nan':
                    continue
                store_id_str = str(int(float(sid))).strip()
                converted_store_ids.append(store_id_str)
            except (ValueError, TypeError) as e:
                print(f"  Conversion failed for '{sid}': {e}")
        
        print("\nCSV Store IDs (converted to string):")
        for sid in converted_store_ids:
            print(f"  '{sid}' (type: {type(sid)})")
        
        # Test BigQuery query with these store IDs
        if converted_store_ids:
            client = BigQueryClient(Config.BIGQUERY_SERVICE_ACCOUNT_PATH)
            
            # Test query with string store IDs
            store_ids_str = "', '".join(converted_store_ids)
            test_query = f"""
            SELECT 
                STORE_ID,
                COUNT(*) as record_count,
                SUM(CAST(SALES AS FLOAT64)) as total_sales
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
            WHERE STORE_ID IN ('{store_ids_str}')
            GROUP BY STORE_ID
            ORDER BY total_sales DESC
            """
            
            print(f"\nTesting BigQuery query with store IDs: {converted_store_ids}")
            result = client.execute_query(test_query)
            
            if not result.empty:
                print("BigQuery results:")
                print(result.to_string())
            else:
                print("No results found - potential data type mismatch!")
                
                # Try with integer conversion
                print("\nTrying with integer conversion...")
                int_store_ids = [int(sid) for sid in converted_store_ids]
                int_store_ids_str = ", ".join(map(str, int_store_ids))
                int_test_query = f"""
                SELECT 
                    STORE_ID,
                    COUNT(*) as record_count,
                    SUM(CAST(SALES AS FLOAT64)) as total_sales
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE STORE_ID IN ({int_store_ids_str})
                GROUP BY STORE_ID
                ORDER BY total_sales DESC
                """
                
                int_result = client.execute_query(int_test_query)
                if not int_result.empty:
                    print("BigQuery results (with integer conversion):")
                    print(int_result.to_string())
                else:
                    print("Still no results - check if store IDs exist in the table")
        
    except Exception as e:
        print(f"Error in compatibility test: {e}")
    
    print("\n" + "=" * 60)

def main():
    """Main test function"""
    print("DOORDASH STORE ID DATA TYPE ANALYSIS")
    print("=" * 60)
    print("This script analyzes data types in CSV and BigQuery table")
    print("to identify potential mismatches causing zero results.")
    print()
    
    # Test CSV field types
    test_csv_field_types()
    
    # Test DB field types
    test_db_field_types()
    
    # Test compatibility
    test_data_compatibility()
    
    print("\nANALYSIS COMPLETE")
    print("=" * 60)
    print("Check the output above for data type mismatches.")
    print("Common issues:")
    print("1. CSV has float/int, DB expects string")
    print("2. CSV has string, DB expects int")
    print("3. Null/empty values in CSV")
    print("4. Store IDs don't exist in DB table")

if __name__ == "__main__":
    main()
