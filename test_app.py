"""
Test script for Daily Dashboard
Run this to test the application components without starting the full Streamlit app
"""

import os
import sys
from datetime import datetime, date, timedelta
import pandas as pd
from dotenv import load_dotenv

# Load environment variables from slack.env
load_dotenv('slack.env')

# Add current directory to path for imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from bigquery_utils import BigQueryClient
from slack_utils import SlackNotifier
from utils import validate_environment, get_default_dates, format_currency, format_percentage, get_last_7_days, get_last_30_days


def test_bigquery_connection():
    """Test BigQuery connection and basic queries"""
    print("🔍 Testing BigQuery connection...")
    
    service_account_path = "todc-marketing-da349d76b96a.json"
    
    if not os.path.exists(service_account_path):
        print(f"❌ Service account file not found: {service_account_path}")
        return False
    
    try:
        client = BigQueryClient(service_account_path)
        print("✅ BigQuery client initialized successfully")
        
        # Test a simple query to check if table has any data
        test_query = """
        SELECT COUNT(*) as total_records
        FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
        LIMIT 1
        """
        
        result = client.execute_query(test_query)
        if not result.empty:
            total_records = result.iloc[0]['total_records']
            print(f"✅ Test query successful. Found {total_records} total records in table")
            return True
        else:
            print("⚠️  Test query returned no results")
            return False
            
    except Exception as e:
        print(f"❌ BigQuery connection failed: {str(e)}")
        return False


def test_slack_connection():
    """Test Slack connection"""
    print("🔍 Testing Slack connection...")
    
    slack_token = os.getenv('SLACK_BOT_TOKEN')
    slack_webhook = os.getenv('SLACK_WEBHOOK_URL')
    
    if not slack_token and not slack_webhook:
        print("⚠️  Neither SLACK_BOT_TOKEN nor SLACK_WEBHOOK_URL set. Skipping Slack test.")
        return False
    
    try:
        notifier = SlackNotifier(slack_token, slack_webhook)
        if notifier.test_connection():
            connection_type = "webhook" if notifier.use_webhook else "bot token"
            print(f"✅ Slack connection successful (using {connection_type})")
            return True
        else:
            print("❌ Slack connection failed")
            return False
    except Exception as e:
        print(f"❌ Slack test failed: {str(e)}")
        return False


def test_data_queries():
    """Test data querying functions"""
    print("🔍 Testing data queries...")
    
    service_account_path = "todc-marketing-da349d76b96a.json"
    
    if not os.path.exists(service_account_path):
        print("❌ Cannot test queries without BigQuery connection")
        return False
    
    try:
        client = BigQueryClient(service_account_path)
        
        # Test PoP data
        start_date, end_date = get_default_dates()
        start_date_str = start_date.strftime("%Y-%m-%d")
        end_date_str = end_date.strftime("%Y-%m-%d")
        
        print(f"📊 Testing PoP query for {start_date_str} to {end_date_str}")
        pop_data = client.get_pop_data(start_date_str, end_date_str, "doordash")
        
        if pop_data:
            print("✅ PoP query successful")
            print(f"   Current Sales: {format_currency(pop_data.get('current_sales', 0))}")
            print(f"   Delta: {format_percentage(pop_data.get('sales_delta_percent', 0))}")
        else:
            print("⚠️  PoP query returned no data")
        
        # Test MoM data
        print("📈 Testing MoM query...")
        mom_data = client.get_mom_data("doordash")
        
        if mom_data:
            print("✅ MoM query successful")
            print(f"   Current Month Sales: {format_currency(mom_data.get('current_month_sales', 0))}")
            print(f"   Delta: {format_percentage(mom_data.get('mom_sales_delta_percent', 0))}")
        else:
            print("⚠️  MoM query returned no data")
        
        # Test YoY data
        print("📅 Testing YoY query...")
        yoy_data = client.get_yoy_data("doordash")
        
        if yoy_data:
            print("✅ YoY query successful")
            print(f"   Current Year Sales: {format_currency(yoy_data.get('current_year_sales', 0))}")
            print(f"   Delta: {format_percentage(yoy_data.get('yoy_sales_delta_percent', 0))}")
        else:
            print("⚠️  YoY query returned no data")
        
        # Test trend data
        print("📊 Testing trend query...")
        trend_data = client.get_daily_trend_data(7)  # Last 7 days
        
        if not trend_data.empty:
            print(f"✅ Trend query successful. Found {len(trend_data)} days of data")
            total_sales = trend_data['daily_sales'].sum()
            print(f"   Total Sales (7 days): {format_currency(total_sales)}")
        else:
            print("⚠️  Trend query returned no data")
        
        return True
        
    except Exception as e:
        print(f"❌ Data query test failed: {str(e)}")
        return False


def test_utility_functions():
    """Test utility functions"""
    print("🔍 Testing utility functions...")
    
    # Test formatting functions
    test_values = [1234.56, "1234.56", "$1,234.56", None, "", "null"]
    
    print("📊 Testing currency formatting...")
    for value in test_values:
        formatted = format_currency(value)
        print(f"   {value} -> {formatted}")
    
    print("📈 Testing percentage formatting...")
    test_percentages = [12.34, -5.67, 0, None, ""]
    for value in test_percentages:
        formatted = format_percentage(value)
        print(f"   {value} -> {formatted}")
    
    # Test date functions
    print("📅 Testing date functions...")
    start_date, end_date = get_default_dates()
    print(f"   Default dates: {start_date} to {end_date}")
    
    start_date, end_date = get_last_7_days()
    print(f"   Last 7 days: {start_date} to {end_date}")
    
    # Test environment validation
    print("🔧 Testing environment validation...")
    validation = validate_environment()
    for key, value in validation.items():
        status = "✅" if value else "❌"
        print(f"   {status} {key}: {value}")
    
    print("✅ Utility functions test completed")
    return True


def main():
    """Main test function"""
    print("🧪 Daily Dashboard Test Suite")
    print("=" * 50)
    
    # Test environment validation
    print("🔧 Environment Validation")
    validation = validate_environment()
    for key, value in validation.items():
        status = "✅" if value else "❌"
        print(f"   {status} {key}: {value}")
    
    print("\n" + "=" * 50)
    
    # Test BigQuery connection
    bq_success = test_bigquery_connection()
    
    print("\n" + "=" * 50)
    
    # Test Slack connection
    slack_success = test_slack_connection()
    
    print("\n" + "=" * 50)
    
    # Test utility functions
    utils_success = test_utility_functions()
    
    print("\n" + "=" * 50)
    
    # Test data queries (only if BigQuery is working)
    if bq_success:
        queries_success = test_data_queries()
    else:
        print("⏭️  Skipping data query tests due to BigQuery connection failure")
        queries_success = False
    
    print("\n" + "=" * 50)
    print("📋 Test Summary")
    print("=" * 50)
    
    tests = [
        ("BigQuery Connection", bq_success),
        ("Slack Connection", slack_success),
        ("Utility Functions", utils_success),
        ("Data Queries", queries_success)
    ]
    
    all_passed = True
    for test_name, success in tests:
        status = "✅ PASS" if success else "❌ FAIL"
        print(f"   {status} {test_name}")
        if not success:
            all_passed = False
    
    print("\n" + "=" * 50)
    
    if all_passed:
        print("🎉 All tests passed! The dashboard should work correctly.")
        print("Run 'python run.py' or 'streamlit run app.py' to start the dashboard.")
    else:
        print("⚠️  Some tests failed. Please check the configuration and try again.")
        print("Refer to the README.md for setup instructions.")
    
    return all_passed


if __name__ == "__main__":
    main()
