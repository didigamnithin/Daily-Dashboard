"""
Utility functions for Daily Dashboard
Common helper functions used across the application
"""

import pandas as pd
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Union
import streamlit as st


def format_currency(value: Union[float, int, str]) -> str:
    """Format currency values with proper formatting"""
    if pd.isna(value) or value is None or value == '':
        return "$0.00"
    
    try:
        # Handle string values that might contain currency symbols
        if isinstance(value, str):
            # Remove common currency symbols and commas
            clean_value = value.replace('$', '').replace(',', '').strip()
            if clean_value == '' or clean_value.lower() == 'null':
                return "$0.00"
            value = float(clean_value)
        
        return f"${value:,.2f}"
    except (ValueError, TypeError):
        return "$0.00"


def format_percentage(value: Union[float, int, str]) -> str:
    """Format percentage values with proper formatting"""
    if pd.isna(value) or value is None or value == '':
        return "0.0%"
    
    try:
        if isinstance(value, str):
            clean_value = value.replace('%', '').strip()
            if clean_value == '' or clean_value.lower() == 'null':
                return "0.0%"
            value = float(clean_value)
        
        return f"{value:+.1f}%"
    except (ValueError, TypeError):
        return "0.0%"


def format_number(value: Union[float, int, str]) -> str:
    """Format numbers with comma separators"""
    if pd.isna(value) or value is None or value == '':
        return "0"
    
    try:
        if isinstance(value, str):
            clean_value = value.replace(',', '').strip()
            if clean_value == '' or clean_value.lower() == 'null':
                return "0"
            value = float(clean_value)
        
        return f"{value:,.0f}"
    except (ValueError, TypeError):
        return "0"


def calculate_date_range(start_date: str, end_date: str) -> Dict[str, str]:
    """Calculate previous period dates for PoP comparison"""
    try:
        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")
        
        # Calculate period length
        period_days = (end_dt - start_dt).days + 1
        
        # Calculate previous period
        prev_end_dt = start_dt - timedelta(days=1)
        prev_start_dt = prev_end_dt - timedelta(days=period_days - 1)
        
        return {
            'prev_start_date': prev_start_dt.strftime("%Y-%m-%d"),
            'prev_end_date': prev_end_dt.strftime("%Y-%m-%d"),
            'period_days': period_days
        }
    except ValueError as e:
        st.error(f"Invalid date format: {e}")
        return {}


def validate_date_range(start_date: str, end_date: str) -> bool:
    """Validate that date range is logical"""
    try:
        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")
        
        # Check if start date is before end date
        if start_dt > end_dt:
            st.error("Start date must be before end date")
            return False
        
        # Check if dates are not in the future
        today = datetime.now().date()
        if start_dt.date() > today or end_dt.date() > today:
            st.error("Dates cannot be in the future")
            return False
        
        # Check if date range is not too large (more than 1 year)
        if (end_dt - start_dt).days > 365:
            st.warning("Date range is very large (>1 year). This may impact performance.")
        
        return True
    except ValueError:
        st.error("Invalid date format. Use YYYY-MM-DD format.")
        return False


def get_color_for_delta(delta: float) -> str:
    """Get color class for delta percentage"""
    if delta > 0:
        return "delta-positive"
    elif delta < 0:
        return "delta-negative"
    else:
        return "delta-neutral"


def clean_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    """Clean DataFrame by handling null values and data types"""
    if df.empty:
        return df
    
    # Replace common null representations
    df = df.replace(['null', 'NULL', '', 'None'], pd.NA)
    
    # Convert numeric columns
    numeric_columns = ['SALES', 'ORDERS', 'ROAS', 'SALES_USD']
    for col in numeric_columns:
        if col in df.columns:
            # Handle currency strings
            if col in ['SALES', 'SALES_USD']:
                df[col] = df[col].astype(str).str.replace('$', '').str.replace(',', '')
            df[col] = pd.to_numeric(df[col], errors='coerce')
    
    return df


def create_summary_stats(data: Dict) -> Dict:
    """Create summary statistics from data dictionary"""
    summary = {}
    
    for key, value in data.items():
        if isinstance(value, (int, float)):
            if 'sales' in key.lower():
                summary[f"{key}_formatted"] = format_currency(value)
            elif 'percent' in key.lower():
                summary[f"{key}_formatted"] = format_percentage(value)
            else:
                summary[f"{key}_formatted"] = format_number(value)
    
    return summary


def log_performance(func_name: str, start_time: datetime, end_time: datetime):
    """Log function performance for debugging"""
    duration = (end_time - start_time).total_seconds()
    st.write(f"⏱️ {func_name} completed in {duration:.2f} seconds")


def handle_bigquery_error(error: Exception) -> str:
    """Handle and format BigQuery errors for user display"""
    error_str = str(error)
    
    if "permission" in error_str.lower():
        return "❌ Permission denied. Please check your BigQuery access rights."
    elif "not found" in error_str.lower():
        return "❌ Table or dataset not found. Please verify table names."
    elif "quota" in error_str.lower():
        return "❌ BigQuery quota exceeded. Please try again later."
    elif "timeout" in error_str.lower():
        return "❌ Query timeout. Try reducing the date range."
    else:
        return f"❌ BigQuery error: {error_str}"


def validate_environment() -> Dict[str, bool]:
    """Validate environment setup"""
    import os
    
    validation = {
        'bigquery_service_account': os.path.exists("todc-marketing-da349d76b96a.json"),
        'slack_token': bool(os.getenv('SLACK_BOT_TOKEN')),
        'slack_webhook': bool(os.getenv('SLACK_WEBHOOK_URL')),
        'slack_configured': bool(os.getenv('SLACK_BOT_TOKEN') or os.getenv('SLACK_WEBHOOK_URL')),
        'required_packages': True  # This would be checked by import statements
    }
    
    try:
        import streamlit
        import pandas
        import plotly
        import google.cloud.bigquery
    except ImportError:
        validation['required_packages'] = False
    
    return validation


def get_default_dates() -> tuple:
    """Get default date range (latest available data)"""
    # Since data is typically 4 days behind, use today-4 as default
    today_minus_4 = datetime.now().date() - timedelta(days=4)
    return today_minus_4, today_minus_4


def get_last_7_days() -> tuple:
    """Get last 7 days date range (ending today-4)"""
    end_date = datetime.now().date() - timedelta(days=4)
    start_date = end_date - timedelta(days=6)
    return start_date, end_date


def get_last_30_days() -> tuple:
    """Get last 30 days date range (ending today-4)"""
    end_date = datetime.now().date() - timedelta(days=4)
    start_date = end_date - timedelta(days=29)
    return start_date, end_date


def get_current_month() -> tuple:
    """Get current month date range (ending today-4)"""
    today_minus_4 = datetime.now().date() - timedelta(days=4)
    start_date = today_minus_4.replace(day=1)
    return start_date, today_minus_4


def get_previous_month() -> tuple:
    """Get previous month date range (ending today-4)"""
    today_minus_4 = datetime.now().date() - timedelta(days=4)
    first_this_month = today_minus_4.replace(day=1)
    last_month = first_this_month - timedelta(days=1)
    first_last_month = last_month.replace(day=1)
    return first_last_month, last_month
