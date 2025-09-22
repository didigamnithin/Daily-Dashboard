"""
Daily Dashboard - Streamlit Application
CEO-level dashboard for DoorDash and UberEats campaign analytics
"""

import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from datetime import datetime, timedelta, date
import os
from typing import Dict, Optional, Any
from dotenv import load_dotenv

# Load environment variables from slack.env
load_dotenv('slack.env')

# Import custom modules
from bigquery_utils import BigQueryClient
from slack_utils import SlackNotifier
# Cache functionality removed
import pandas as pd

# Page configuration
st.set_page_config(
    page_title="Daily Dashboard - TODC Marketing Analytics",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Force light mode
st.markdown("""
<style>
    .stApp {
        color: #000000;
        background-color: #ffffff;
    }
    
    .main .block-container {
        background-color: #ffffff;
        color: #000000;
    }
    
    .sidebar .sidebar-content {
        background-color: #f8fafc;
        color: #000000;
    }
    
    .stSelectbox > div > div {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stDateInput > div > div {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stMultiSelect > div > div {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stCheckbox > div > div {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stRadio > div > div {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stButton > button {
        background-color: #ffffff;
        color: #000000;
        border: 1px solid #d1d5db;
    }
    
    .stButton > button:hover {
        background-color: #f9fafb;
        color: #000000;
    }
    
    .stDataFrame {
        background-color: #ffffff;
        color: #000000;
    }
    
    .stMetric {
        background-color: #ffffff;
        color: #000000;
    }
    
    /* Override any dark mode styles */
    [data-testid="stAppViewContainer"] {
        background-color: #ffffff;
        color: #000000;
    }
    
    [data-testid="stSidebar"] {
        background-color: #f8fafc;
        color: #000000;
    }
    
    [data-testid="stHeader"] {
        background-color: #ffffff;
        color: #000000;
    }
    
    [data-testid="stToolbar"] {
        background-color: #ffffff;
        color: #000000;
    }
</style>
""", unsafe_allow_html=True)

# Custom CSS for styling
st.markdown("""
<style>
    .main {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    body {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stApp {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .metric-card {
        background-color: #ffffff;
        padding: 1rem;
        border-radius: 10px;
        border: 1px solid #e0e0e0;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        margin: 0.5rem 0;
    }
    
    .metric-value {
        font-size: 2rem;
        font-weight: 700;
        color: #1f2937;
        margin: 0;
    }
    
    .metric-label {
        font-size: 0.9rem;
        color: #6b7280;
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .delta-positive {
        color: #059669;
        font-weight: 600;
    }
    
    .delta-negative {
        color: #dc2626;
        font-weight: 600;
    }
    
    .delta-neutral {
        color: #6b7280;
        font-weight: 600;
    }
    
    .sidebar .sidebar-content {
        background-color: #f8fafc;
    }
    
    .stSelectbox > div > div {
        background-color: white;
    }
    
    .stDateInput > div > div {
        background-color: white;
    }
    
    .platform-selector {
        display: flex;
        gap: 1rem;
        margin: 1rem 0;
    }
    
    .platform-button {
        flex: 1;
        padding: 0.75rem;
        border: 2px solid #e5e7eb;
        border-radius: 8px;
        background-color: white;
        cursor: pointer;
        text-align: center;
        font-weight: 600;
        transition: all 0.2s;
    }
    
    .platform-button.selected {
        border-color: #3b82f6;
        background-color: #eff6ff;
        color: #1d4ed8;
    }
    
    .platform-button:hover {
        border-color: #3b82f6;
    }
    
    /* Force light mode for all elements */
    * {
        color: #000000 !important;
    }
    
    /* All Streamlit text elements */
    .stMarkdown, .stMarkdown * {
        color: #000000 !important;
    }
    
    .stText, .stText * {
        color: #000000 !important;
    }
    
    .stTitle, .stTitle * {
        color: #000000 !important;
    }
    
    .stHeader, .stHeader * {
        color: #000000 !important;
    }
    
    .stSubheader, .stSubheader * {
        color: #000000 !important;
    }
    
    .stCaption, .stCaption * {
        color: #000000 !important;
    }
    
    /* Alert messages */
    .stSuccess, .stSuccess * {
        background-color: #d1fae5 !important;
        color: #000000 !important;
    }
    
    .stError, .stError * {
        background-color: #fee2e2 !important;
        color: #000000 !important;
    }
    
    .stWarning, .stWarning * {
        background-color: #fef3c7 !important;
        color: #000000 !important;
    }
    
    .stInfo, .stInfo * {
        background-color: #dbeafe !important;
        color: #000000 !important;
    }
    
    /* DataFrames and tables */
    .stDataFrame, .stDataFrame * {
        color: #000000 !important;
    }
    
    .dataframe, .dataframe * {
        color: #000000 !important;
    }
    
    /* Metrics and KPIs */
    .stMetric, .stMetric * {
        color: #000000 !important;
    }
    
    .metric-card, .metric-card * {
        color: #000000 !important;
    }
    
    /* Sidebar elements */
    .sidebar .sidebar-content, .sidebar .sidebar-content * {
        color: #000000 !important;
    }
    
    /* Form elements */
    .stSelectbox, .stSelectbox * {
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    .stSelectbox > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
        border: 1px solid #d1d5db !important;
    }
    
    .stSelectbox > div > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stDateInput, .stDateInput * {
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    .stDateInput > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
        border: 1px solid #d1d5db !important;
    }
    
    .stMultiSelect, .stMultiSelect * {
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    .stMultiSelect > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
        border: 1px solid #d1d5db !important;
    }
    
    .stMultiSelect > div > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stCheckbox, .stCheckbox * {
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    .stRadio, .stRadio * {
        color: #000000 !important;
        background-color: #ffffff !important;
    }
    
    /* Dropdown menu styling */
    .stSelectbox [data-baseweb="select"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stSelectbox [data-baseweb="select"] > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stSelectbox [data-baseweb="select"] > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    /* Dropdown options */
    [role="listbox"] {
        background-color: #ffffff !important;
        color: #000000 !important;
        border: 1px solid #d1d5db !important;
    }
    
    [role="option"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    [role="option"]:hover {
        background-color: #f3f4f6 !important;
        color: #000000 !important;
    }
    
    [role="option"][aria-selected="true"] {
        background-color: #dbeafe !important;
        color: #000000 !important;
    }
    
    /* Buttons */
    .stButton, .stButton * {
        color: #000000 !important;
    }
    
    /* Platform buttons */
    .platform-button, .platform-button * {
        color: #000000 !important;
    }
    
    /* All text elements */
    p, span, div, h1, h2, h3, h4, h5, h6, label, a, li, td, th {
        color: #000000 !important;
    }
    
    /* Override any white or light text */
    .text-white, .text-light, .text-muted {
        color: #000000 !important;
    }
    
    /* Force all text to be black */
    [class*="text-"], [class*="color-"] {
        color: #000000 !important;
    }
    
    /* Red row styling for low WoW performance */
    .low-wow-row {
        background-color: #dc2626 !important;
        color: #ffffff !important;
    }
    
    .low-wow-row * {
        background-color: #dc2626 !important;
        color: #ffffff !important;
    }
    
    .low-wow-row td, .low-wow-row th {
        background-color: #dc2626 !important;
        color: #ffffff !important;
    }
    
    .low-wow-row:hover {
        background-color: #b91c1c !important;
        color: #ffffff !important;
    }
    
    .low-wow-row:hover * {
        background-color: #b91c1c !important;
        color: #ffffff !important;
    }
    
    /* Sidebar toggle button */
    .stSidebarToggle {
        background-color: #ffffff !important;
        color: #000000 !important;
        border: 1px solid #d1d5db !important;
    }
    
    .stSidebarToggle:hover {
        background-color: #f3f4f6 !important;
        color: #000000 !important;
    }
    
    /* Additional dropdown fixes */
    .stSelectbox [data-baseweb="select"] [data-baseweb="select__value-container"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stSelectbox [data-baseweb="select"] [data-baseweb="select__placeholder"] {
        color: #6b7280 !important;
    }
    
    .stSelectbox [data-baseweb="select"] [data-baseweb="select__single-value"] {
        color: #000000 !important;
    }
    
    /* Multi-select specific styling */
    .stMultiSelect [data-baseweb="select"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stMultiSelect [data-baseweb="select"] > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    .stMultiSelect [data-baseweb="select"] [data-baseweb="select__value-container"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    /* Ensure all dropdown elements are white */
    div[data-baseweb="select"] {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    div[data-baseweb="select"] > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
    
    div[data-baseweb="select"] > div > div {
        background-color: #ffffff !important;
        color: #000000 !important;
    }
</style>
""", unsafe_allow_html=True)


@st.cache_data
def load_business_names():
    """Load unique business names from BigQuery"""
    try:
        if not st.session_state.bigquery_client:
            return []
            
        query = """
        SELECT DISTINCT `Business Name`
        FROM `todc-marketing.merchant_portal_upload.mcd_account_information`
        WHERE `Business Name` IS NOT NULL
        ORDER BY `Business Name`
        """
        
        df = st.session_state.bigquery_client.execute_query(query)
        
        # Get unique business names and sort them
        business_names = df['Business Name'].dropna().unique()
        business_names = sorted([name.strip() for name in business_names if name.strip()])
        
        return business_names
    except Exception as e:
        st.error(f"Error loading business names from BigQuery: {e}")
        return []

@st.cache_data
def get_store_ids_for_operators(selected_operators):
    """Get DoorDash Store IDs for selected operators from BigQuery"""
    try:
        if not selected_operators or "All" in selected_operators:
            return None  # No filtering needed
        
        if not st.session_state.bigquery_client:
            return None
            
        # Use a safer approach - get all data and filter in Python
        # This avoids SQL injection issues with special characters
        query = """
        SELECT `Business Name`, `DoorDash Store ID`
        FROM `todc-marketing.merchant_portal_upload.mcd_account_information`
        WHERE `Business Name` IS NOT NULL 
            AND `DoorDash Store ID` IS NOT NULL
        """
        
        df = st.session_state.bigquery_client.execute_query(query)
        
        # Filter by selected operators in Python (safer than SQL)
        if not df.empty:
            # Filter rows where Business Name is in selected_operators
            filtered_df = df[df['Business Name'].isin(selected_operators)]
            
            # Get unique DoorDash Store IDs with proper validation
            store_ids = []
            for sid in filtered_df['DoorDash Store ID'].dropna().unique():
                try:
                    if pd.isna(sid) or str(sid).strip() == '' or str(sid).strip().lower() == 'nan':
                        continue
                    store_id_str = str(int(float(sid))).strip()
                    if store_id_str and store_id_str not in store_ids:
                        store_ids.append(store_id_str)
                except (ValueError, TypeError):
                    # Skip invalid store IDs
                    continue
            
            return store_ids if store_ids else None
        else:
            return None
    except Exception as e:
        st.error(f"Error loading store IDs from BigQuery: {e}")
        return None

@st.cache_data
def get_operators_with_store_ids():
    """Get all unique operators with their store IDs from BigQuery"""
    try:
        if not st.session_state.bigquery_client:
            return {}
            
        query = """
        SELECT 
            `Business Name`,
            `DoorDash Store ID`
        FROM `todc-marketing.merchant_portal_upload.mcd_account_information`
        WHERE `Business Name` IS NOT NULL 
            AND `DoorDash Store ID` IS NOT NULL
        ORDER BY `Business Name`, `DoorDash Store ID`
        """
        
        df = st.session_state.bigquery_client.execute_query(query)
        
        # Group by Business Name and get all store IDs for each operator
        operator_data = {}
        for _, row in df.iterrows():
            business_name = row['Business Name']
            store_id = row['DoorDash Store ID']
            
            if pd.notna(business_name) and pd.notna(store_id):
                business_name = business_name.strip()
                
                # Safely convert store_id to string, handling non-numeric values
                try:
                    if pd.isna(store_id) or str(store_id).strip() == '' or str(store_id).strip().lower() == 'nan':
                        continue
                    store_id_str = str(int(float(store_id))).strip()
                    if not store_id_str:
                        continue
                except (ValueError, TypeError):
                    # Skip invalid store IDs
                    continue
                
                if business_name not in operator_data:
                    operator_data[business_name] = []
                
                if store_id_str not in operator_data[business_name]:
                    operator_data[business_name].append(store_id_str)
        
        return operator_data
    except Exception as e:
        st.error(f"Error loading operators data from BigQuery: {e}")
        return {}

@st.cache_data
def get_max_date_for_platform(platform: str):
    """Get the maximum date available for the given platform"""
    try:
        if not st.session_state.bigquery_client:
            return None
        return st.session_state.bigquery_client.get_max_date(platform)
    except Exception as e:
        st.error(f"Error getting max date: {e}")
        return None


@st.cache_data
def get_store_data_for_operator(operator_name: str, start_date: str, end_date: str):
    """Get store-level data for a specific operator"""
    try:
        # Get store IDs for the operator
        operator_data = get_operators_with_store_ids()
        if operator_name not in operator_data:
            return pd.DataFrame()
        
        store_ids = operator_data[operator_name]
        if not store_ids:
            return pd.DataFrame()
        
        # Get store-wise data from BigQuery
        if st.session_state.selected_platform == "ubereats":
            return st.session_state.bigquery_client.get_ue_operator_wise_data(
                start_date, end_date, store_ids
            )
        else:
            return st.session_state.bigquery_client.get_operator_wise_data(
                start_date, end_date, store_ids
            )
    except Exception as e:
        st.error(f"Error loading store data for {operator_name}: {e}")
        return pd.DataFrame()

@st.cache_data
def get_campaign_data_for_store(store_id: str, start_date: str, end_date: str):
    """Get campaign-level data for a specific store"""
    try:
        # Get campaign data for the store
        if st.session_state.selected_platform == "ubereats":
            return st.session_state.bigquery_client.get_ue_top_campaigns(
                days=30, store_ids=[store_id]
            )
        else:
            return st.session_state.bigquery_client.get_top_campaigns(
                days=30, store_ids=[store_id]
            )
    except Exception as e:
        st.error(f"Error loading campaign data for store {store_id}: {e}")
        return pd.DataFrame()

# Initialize session state
if 'bigquery_client' not in st.session_state:
    st.session_state.bigquery_client = None
if 'slack_notifier' not in st.session_state:
    st.session_state.slack_notifier = None
if 'selected_platform' not in st.session_state:
    st.session_state.selected_platform = 'doordash'
if 'drilldown_level' not in st.session_state:
    st.session_state.drilldown_level = "operator"  # operator, store, campaign
if 'selected_operator' not in st.session_state:
    st.session_state.selected_operator = None
if 'selected_store' not in st.session_state:
    st.session_state.selected_store = None

# Cache for loaded data to avoid reloading
if 'kpi_data_loaded' not in st.session_state:
    st.session_state.kpi_data_loaded = False
if 'wow_data' not in st.session_state:
    st.session_state.wow_data = {}
if 'mom_data' not in st.session_state:
    st.session_state.mom_data = {}
if 'operator_data_loaded' not in st.session_state:
    st.session_state.operator_data_loaded = False
if 'operator_summary_data' not in st.session_state:
    st.session_state.operator_summary_data = pd.DataFrame()
if 'store_breakdown_data' not in st.session_state:
    st.session_state.store_breakdown_data = pd.DataFrame()
if 'current_platform' not in st.session_state:
    st.session_state.current_platform = 'doordash'
if 'current_date_range' not in st.session_state:
    st.session_state.current_date_range = None

def initialize_clients():
    """Initialize BigQuery and Slack clients"""
    # BigQuery client
    service_account_path = "todc-marketing-da349d76b96a.json"
    if os.path.exists(service_account_path):
        try:
            st.session_state.bigquery_client = BigQueryClient(service_account_path)
        except Exception as e:
            st.error(f"Failed to initialize BigQuery client: {str(e)}")
    
    # Slack notifier (webhook only)
    slack_webhook = os.getenv('SLACK_WEBHOOK_URL')
    if slack_webhook:
        st.session_state.slack_notifier = SlackNotifier(webhook_url=slack_webhook)

def should_reload_data(platform: str, start_date: str, end_date: str) -> bool:
    """Check if data needs to be reloaded based on platform or date changes"""
    current_range = f"{start_date}_{end_date}"
    
    # Reload if platform changed
    if st.session_state.current_platform != platform:
        return True
    
    # Reload if date range changed
    if st.session_state.current_date_range != current_range:
        return True
    
    return False

def load_kpi_data_if_needed(platform: str, start_date: str, end_date: str, store_ids: list):
    """Load KPI data only if needed"""
    if not st.session_state.kpi_data_loaded or should_reload_data(platform, start_date, end_date):
        with st.spinner("Loading KPI data..."):
            # Load WoW data
            wow_result = load_kpi_data_individual(start_date, end_date, platform, store_ids)
            st.session_state.wow_data = wow_result['wow_data']
            
            # Load MoM data
            mom_result = load_mom_data_individual(platform)
            st.session_state.mom_data = mom_result['mom_data']
            
            st.session_state.kpi_data_loaded = True
            st.session_state.current_platform = platform
            st.session_state.current_date_range = f"{start_date}_{end_date}"

def load_operator_data_if_needed(platform: str, start_date: str, end_date: str, store_ids: list, selected_businesses: list):
    """Load operator data only if needed - using max date for actual data"""
    if not st.session_state.operator_data_loaded or should_reload_data(platform, start_date, end_date):
        with st.spinner("Loading operator data..."):
            # Get max date for the platform
            max_date = get_max_date_for_platform(platform)
            if not max_date:
                st.error("Could not determine max date for data loading")
                return
            
            # Get operator data for the selected businesses
            target_operators_data = get_operators_with_store_ids()
            # Filter to only include selected businesses
            filtered_operators_data = {k: v for k, v in target_operators_data.items() if k in selected_businesses}
            
            if platform == "ubereats":
                st.session_state.operator_summary_data = st.session_state.bigquery_client.get_ue_operator_aggregated_data(
                    max_date, max_date, filtered_operators_data
                )
                st.session_state.store_breakdown_data = st.session_state.bigquery_client.get_ue_operator_wise_data_all_time(
                    store_ids
                )
            else:
                st.session_state.operator_summary_data = st.session_state.bigquery_client.get_operator_aggregated_data(
                    max_date, max_date, filtered_operators_data
                )
                st.session_state.store_breakdown_data = st.session_state.bigquery_client.get_operator_wise_data(
                    max_date, max_date, store_ids
                )
            
            st.session_state.operator_data_loaded = True

def format_currency(value) -> str:
    """Format currency values"""
    if pd.isna(value) or value is None:
        return "$0.00"
    try:
        # Handle both string and numeric values
        if isinstance(value, str):
            # Remove any non-numeric characters except decimal point
            clean_value = ''.join(c for c in value if c.isdigit() or c == '.')
            if clean_value:
                return f"${float(clean_value):,.2f}"
            else:
                return "$0.00"
        else:
            return f"${float(value):,.2f}"
    except (ValueError, TypeError):
        return "$0.00"

def format_percentage(value) -> str:
    """Format percentage values with color coding"""
    if pd.isna(value) or value is None:
        return "0.0%"
    
    try:
        # Handle both string and numeric values
        if isinstance(value, str):
            # Remove any non-numeric characters except decimal point and minus sign
            clean_value = ''.join(c for c in value if c.isdigit() or c in '.-')
            if clean_value:
                numeric_value = float(clean_value)
            else:
                return "0.0%"
        else:
            numeric_value = float(value)
        
        formatted = f"{numeric_value:+.1f}%"
        if numeric_value > 0:
            return f'<span class="delta-positive">{formatted}</span>'
        elif numeric_value < 0:
            return f'<span class="delta-negative">{formatted}</span>'
        else:
            return f'<span class="delta-neutral">{formatted}</span>'
    except (ValueError, TypeError):
        return "0.0%"

def safe_float(value, default=0.0):
    """Safely convert value to float"""
    if pd.isna(value) or value is None:
        return default
    try:
        if isinstance(value, str):
            clean_value = ''.join(c for c in value if c.isdigit() or c in '.-')
            return float(clean_value) if clean_value else default
        else:
            return float(value)
    except (ValueError, TypeError):
        return default

def safe_int(value, default=0):
    """Safely convert value to int"""
    if pd.isna(value) or value is None:
        return default
    try:
        if isinstance(value, str):
            clean_value = ''.join(c for c in value if c.isdigit() or c in '.-')
            return int(float(clean_value)) if clean_value else default
        else:
            return int(float(value))
    except (ValueError, TypeError):
        return default

def create_metric_card(title: str, value: str, delta: str = None, subtitle: str = None):
    """Create a styled metric card"""
    card_html = f"""
    <div class="metric-card">
        <p class="metric-label">{title}</p>
        <p class="metric-value">{value}</p>
        {f'<p class="metric-label">{delta}</p>' if delta else ''}
        {f'<p class="metric-label">{subtitle}</p>' if subtitle else ''}
    </div>
    """
    return st.markdown(card_html, unsafe_allow_html=True)

def render_sidebar():
    """Render the collapsible sidebar with filters"""
    with st.sidebar:
        st.title("📊 Dashboard Filters")
        
        # Platform Selection with Text Buttons
        st.subheader("Platform")
        
        # Create two columns for platform selection
        col1, col2 = st.columns(2)
        
        with col1:
            # DoorDash selection
            dd_selected = st.session_state.selected_platform == "doordash"
            
            if st.button("🚚 DoorDash", key="dd_platform", type="primary" if dd_selected else "secondary"):
                st.session_state.selected_platform = "doordash"
                st.rerun()
        
        with col2:
            # UberEats selection
            ue_selected = st.session_state.selected_platform == "ubereats"
            
            if st.button("🍔 UberEats", key="ue_platform", type="primary" if ue_selected else "secondary"):
                st.session_state.selected_platform = "ubereats"
                st.rerun()
        
        # Load all business names from BigQuery (no selection needed)
        business_names = load_business_names()
        selected_businesses = business_names  # Use all businesses
        
        # Date Range Selection - Fixed to latest available data
        st.subheader("Date Range")
        st.info("📅 Data shown for latest available date")
        
        # Default to latest available data (2025-09-10) since BigQuery data is 12 days behind
        default_date = date(2025, 9, 10)  # Latest available data
        start_date = default_date
        end_date = default_date
        
        # Refresh Button
        if st.button("🔄 Refresh Data", type="primary"):
            st.rerun()
        
        # Slack Integration Status (simplified)
        # st.subheader("Slack Integration")
        # if st.session_state.slack_notifier:
        #     st.success("✅ Slack Connected")
        # else:
        #     st.warning("⚠️ Slack not configured")
        
        
        return start_date, end_date, selected_businesses

def load_kpi_data_individual(start_date_str: str, end_date_str: str, platform: str, store_ids: list) -> Dict[str, Any]:
    """Load KPI data individually - WoW uses all operators, MoM uses positive operators only"""
    try:
        wow_data = st.session_state.bigquery_client.get_wow_data(
            start_date_str, end_date_str, platform, store_ids
        )
        return {'wow_data': wow_data, 'error': None}
    except Exception as e:
        return {'wow_data': {}, 'error': str(e)}

def load_mom_data_individual(platform: str) -> Dict[str, Any]:
    """Load MoM data individually - using positive operators only"""
    try:
        mom_data = st.session_state.bigquery_client.get_positive_operators_mom_data(platform)
        return {'mom_data': mom_data, 'error': None}
    except Exception as e:
        return {'mom_data': {}, 'error': str(e)}

# YoY functionality removed

def render_kpi_widgets(wow_data: Dict, mom_data: Dict, 
                      wow_loading: bool = False, mom_loading: bool = False):
    """Render KPI widgets for WoW and MoM with individual loading states"""
    st.subheader("📈 Key Performance Indicators")
    
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("### Week over Week")
        if wow_loading:
            with st.spinner("Loading WoW data..."):
                pass
        elif wow_data:
            current_sales = wow_data.get('current_sales', 0)
            delta_pct = wow_data.get('sales_delta_percent', 0)
            current_dates = wow_data.get('current_period_dates', '')
            prev_dates = wow_data.get('previous_period_dates', '')
            positive_ops = wow_data.get('positive_operators_count', 0)
            create_metric_card(
                "Sales",
                format_currency(current_sales),
                format_percentage(delta_pct),
                f"vs Previous Week<br><small>{current_dates} vs {prev_dates}</small>"
            )
        else:
            create_metric_card("Sales", "$0.00", "No Data", "vs Previous Week")
    
    with col2:
        st.markdown("### Month over Month")
        if mom_loading:
            with st.spinner("Loading MoM data..."):
                pass
        elif mom_data:
            current_sales = mom_data.get('current_month_sales', 0)
            delta_pct = mom_data.get('mom_sales_delta_percent', 0)
            current_dates = mom_data.get('current_period_dates', '')
            prev_dates = mom_data.get('previous_period_dates', '')
            positive_ops = mom_data.get('positive_operators_count', 0)
            create_metric_card(
                "Sales",
                format_currency(current_sales),
                format_percentage(delta_pct),
                f"vs Last Month<br><small>{current_dates} vs {prev_dates}</small>"
            )
        else:
            create_metric_card("Sales", "$0.00", "No Data", "vs Last Month")
    

def render_trend_chart(trend_data: pd.DataFrame):
    """Render daily sales trend chart"""
    if trend_data.empty:
        st.warning("No trend data available")
        return
    
    fig = go.Figure()
    
    fig.add_trace(go.Scatter(
        x=trend_data['DATE'],
        y=trend_data['daily_sales'],
        mode='lines+markers',
        name='Daily Sales',
        line=dict(color='#3b82f6', width=3),
        marker=dict(size=6)
    ))
    
    fig.update_layout(
        title={
            'text': "📈 Daily Sales Trend (Last 7 Days)",
            'x': 0.5,
            'xanchor': 'center',
            'font': {'size': 18, 'color': '#000000'}
        },
        xaxis_title="Date",
        yaxis_title="Sales ($)",
        hovermode='x unified',
        template='plotly_white',
        font=dict(family="Arial, sans-serif", size=12, color="#000000"),
        plot_bgcolor='white',
        paper_bgcolor='white',
        height=500
    )
    
    fig.update_xaxes(showgrid=True, gridwidth=1, gridcolor='#f0f0f0')
    fig.update_yaxes(showgrid=True, gridwidth=1, gridcolor='#f0f0f0')
    
    st.plotly_chart(fig, use_container_width=True)

def render_operator_summary_table(operator_data: pd.DataFrame, loading: bool = False):
    """Render operator summary table with aggregated data and loading state"""
    if loading:
        st.subheader("🏢 Operator Performance Summary")
        with st.spinner("Loading operator data..."):
            pass
        return
    
    if operator_data.empty:
        st.warning("No operator data available")
        # Add debug information
        with st.expander("🔍 Debug Information"):
            st.write("**Possible causes for empty data:**")
            st.write("1. No data in the selected date range")
            st.write("2. Store IDs not found in database")
            st.write("3. All sales values are null or 'null'")
            st.write("4. Date range is too narrow")
            st.write("")
            st.write("**Try:**")
            st.write("- Expand the date range using 'Use Custom Date Range'")
            st.write("- Check if store IDs exist in the CSV file")
            st.write("- Verify the selected operators have valid DoorDash Store IDs")
        return
    
    # Get and display max date
    max_date = get_max_date_for_platform(st.session_state.selected_platform)
    if max_date:
        st.subheader(f"🏢 Operator Performance Summary (Data as of: {max_date})")
    else:
        st.subheader("🏢 Operator Performance Summary")
    
    # Format the data for display
    display_data = operator_data.copy()
    display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{safe_float(x):.2f}x" if safe_float(x) != 0.0 else "N/A")
    display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{safe_int(x):,}")
    display_data['wow_sales_delta_percent'] = display_data['wow_sales_delta_percent'].apply(lambda x: f"{safe_float(x):+.1f}%")
    display_data['mom_sales_delta_percent'] = display_data['mom_sales_delta_percent'].apply(lambda x: f"{safe_float(x):+.1f}%")
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    # Reorder columns for better display (added WoW and MoM columns)
    column_order = ['rank', 'operator_name', 'total_sales', 'total_orders', 'avg_roas', 'wow_sales_delta_percent', 'mom_sales_delta_percent']
    display_data = display_data[column_order]
    
    # Add row styling for low WoW performance
    def style_low_wow_rows(row):
        wow_percent = safe_float(row['wow_sales_delta_percent'])
        if wow_percent < 5 and wow_percent != 0:
            return ['background-color: #dc2626; color: #ffffff'] * len(row)
        return [''] * len(row)
    
    # Apply styling to the dataframe
    styled_data = display_data.style.apply(style_low_wow_rows, axis=1)
    
    # Create clickable rows for drilldown
    selected_rows = st.dataframe(
        styled_data,
        column_config={
            "rank": st.column_config.NumberColumn("Rank", width="small"),
            "operator_name": st.column_config.TextColumn("Operator", width="large"),
            "total_sales": st.column_config.TextColumn("Total Sales", width="medium"),
            "total_orders": st.column_config.TextColumn("Total Orders", width="medium"),
            "avg_roas": st.column_config.TextColumn("Avg ROAS", width="small"),
            "wow_sales_delta_percent": st.column_config.TextColumn("WoW %", width="small"),
            "mom_sales_delta_percent": st.column_config.TextColumn("MoM %", width="small"),
        },
        use_container_width=True,
        hide_index=True
    )
    
    # Handle row selection for drilldown
    # Note: DataFrame selection is not available in this Streamlit version
    # Using alternative approach with selectbox for operator selection
    st.markdown("### 🔍 Select Operator for Drilldown")
    operator_options = ["Select an operator..."] + display_data['operator_name'].tolist()
    selected_operator = st.selectbox("Choose operator to view store details:", operator_options)
    
    if selected_operator and selected_operator != "Select an operator...":
        # Update session state for drilldown
        st.session_state.drilldown_level = "store"
        st.session_state.selected_operator = selected_operator
        st.session_state.selected_store = None  # Reset store selection
        
        st.success(f"🔍 Selected operator: **{selected_operator}** - Loading store details...")
        # Don't call st.rerun() - let the main function handle the display

def render_store_wise_breakdown(store_data: pd.DataFrame, loading: bool = False):
    """Render store-wise breakdown table with loading state"""
    if loading:
        st.subheader("🏪 Store-wise Performance Breakdown")
        with st.spinner("Loading store data..."):
            pass
        return
    
    if store_data.empty:
        st.warning("No store data available")
        return
    
    # Get and display max date
    max_date = get_max_date_for_platform(st.session_state.selected_platform)
    if max_date:
        st.subheader(f"🏪 Store-wise Performance Breakdown (Data as of: {max_date})")
    else:
        st.subheader("🏪 Store-wise Performance Breakdown")
    
    # Format the data for display
    display_data = store_data.copy()
    display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{safe_float(x):.2f}x" if safe_float(x) != 0.0 else "N/A")
    display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{safe_int(x):,}")
    display_data['wow_sales_delta_percent'] = display_data['wow_sales_delta_percent'].apply(lambda x: f"{safe_float(x):+.1f}%")
    display_data['mom_sales_delta_percent'] = display_data['mom_sales_delta_percent'].apply(lambda x: f"{safe_float(x):+.1f}%")
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    # Reorder columns for better display (added WoW and MoM columns)
    column_order = ['rank', 'STORE_ID', 'STORE_NAME', 'total_sales', 'total_orders', 'avg_roas', 'wow_sales_delta_percent', 'mom_sales_delta_percent']
    display_data = display_data[column_order]
    
    # Add row styling for low WoW performance
    def style_low_wow_rows(row):
        wow_percent = safe_float(row['wow_sales_delta_percent'])
        if wow_percent < 5 and wow_percent != 0:
            return ['background-color: #dc2626; color: #ffffff'] * len(row)
        return [''] * len(row)
    
    # Apply styling to the dataframe
    styled_data = display_data.style.apply(style_low_wow_rows, axis=1)
    
    # Create clickable rows for drilldown
    selected_rows = st.dataframe(
        styled_data,
        column_config={
            "rank": st.column_config.NumberColumn("Rank", width="small"),
            "STORE_ID": st.column_config.TextColumn("Store ID", width="medium"),
            "STORE_NAME": st.column_config.TextColumn("Store Name", width="large"),
            "total_sales": st.column_config.TextColumn("Total Sales", width="medium"),
            "total_orders": st.column_config.TextColumn("Total Orders", width="medium"),
            "avg_roas": st.column_config.TextColumn("Avg ROAS", width="small"),
            "wow_sales_delta_percent": st.column_config.TextColumn("WoW %", width="small"),
            "mom_sales_delta_percent": st.column_config.TextColumn("MoM %", width="small"),
        },
        use_container_width=True,
        hide_index=True
    )
    
    # Handle row selection for drilldown
    # Note: DataFrame selection is not available in this Streamlit version
    # Using alternative approach with selectbox for store selection
    st.markdown("### 🔍 Select Store for Drilldown")
    
    # Create store options with both store name and ID for display
    store_options = ["Select a store..."]
    store_mapping = {}  # Store name -> Store ID mapping
    
    for _, row in display_data.iterrows():
        store_name = row['STORE_NAME']
        store_id = row['STORE_ID']
        display_text = f"{store_name} ({store_id})"
        store_options.append(display_text)
        store_mapping[display_text] = store_id
    
    selected_store_display = st.selectbox("Choose store to view campaign details:", store_options)
    
    if selected_store_display and selected_store_display != "Select a store...":
        # Get the actual store ID from the mapping
        selected_store_id = store_mapping[selected_store_display]
        
        # Update session state for drilldown
        st.session_state.drilldown_level = "campaign"
        st.session_state.selected_store = selected_store_id
        
        st.success(f"🔍 Selected store: **{selected_store_display}** - Loading campaign details...")
        # Don't call st.rerun() - let the main function handle the display

def render_campaign_breakdown(campaign_data: pd.DataFrame):
    """Render campaign-level breakdown table"""
    if campaign_data.empty:
        st.warning("No campaign data available")
        return
    
    # Get and display max date
    max_date = get_max_date_for_platform(st.session_state.selected_platform)
    if max_date:
        st.subheader(f"📊 Campaign Performance Breakdown (Data as of: {max_date})")
    else:
        st.subheader("📊 Campaign Performance Breakdown")
    
    # Format the data for display
    display_data = campaign_data.copy()
    
    # Format WoW and MoM columns if they exist
    if 'wow_sales_delta_percent' in display_data.columns:
        display_data['wow_sales_delta_percent'] = display_data['wow_sales_delta_percent'].apply(
            lambda x: f"{safe_float(x):+.1f}%" if safe_float(x) != 0.0 else "N/A"
        )
    if 'mom_sales_delta_percent' in display_data.columns:
        display_data['mom_sales_delta_percent'] = display_data['mom_sales_delta_percent'].apply(
            lambda x: f"{safe_float(x):+.1f}%" if safe_float(x) != 0.0 else "N/A"
        )
    
    # Format other columns
    if 'total_sales' in display_data.columns:
        display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    if 'avg_roas' in display_data.columns:
        display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{safe_float(x):.2f}x" if safe_float(x) != 0.0 else "N/A")
    if 'total_orders' in display_data.columns:
        display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{safe_int(x):,}")
    
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    # Define column order: WoW, MoM before sales, orders, Avg. ROAS
    column_order = ['rank', 'CAMPAIGN_NAME', 'STORE_NAME']
    
    # Add WoW and MoM columns if they exist
    if 'wow_sales_delta_percent' in display_data.columns:
        column_order.append('wow_sales_delta_percent')
    if 'mom_sales_delta_percent' in display_data.columns:
        column_order.append('mom_sales_delta_percent')
    
    # Add other columns
    column_order.extend(['total_sales', 'total_orders', 'avg_roas', 'campaign_days'])
    
    # Reorder columns
    display_data = display_data[column_order]
    
    # Define column configuration
    column_config = {
        'rank': st.column_config.NumberColumn('Rank', width='small'),
        'CAMPAIGN_NAME': st.column_config.TextColumn('Campaign Name', width='medium'),
        'STORE_NAME': st.column_config.TextColumn('Store Name', width='medium'),
        'total_sales': st.column_config.TextColumn('Total Sales', width='medium'),
        'total_orders': st.column_config.TextColumn('Total Orders', width='medium'),
        'avg_roas': st.column_config.TextColumn('Avg. ROAS', width='medium'),
        'campaign_days': st.column_config.NumberColumn('Days', width='small')
    }
    
    # Add WoW and MoM column configs if they exist
    if 'wow_sales_delta_percent' in display_data.columns:
        column_config['wow_sales_delta_percent'] = st.column_config.TextColumn('WoW %', width='small')
    if 'mom_sales_delta_percent' in display_data.columns:
        column_config['mom_sales_delta_percent'] = st.column_config.TextColumn('MoM %', width='small')
    
    # Add row styling for low WoW performance
    def style_low_wow_rows(row):
        wow_percent = safe_float(row.get('wow_sales_delta_percent', 0))
        if wow_percent < 5 and wow_percent != 0:
            return ['background-color: #dc2626; color: #ffffff'] * len(row)
        return [''] * len(row)
    
    # Apply styling to the dataframe
    styled_data = display_data.style.apply(style_low_wow_rows, axis=1)
    
    st.dataframe(
        styled_data,
        use_container_width=True,
        hide_index=True,
        column_config=column_config
    )

def render_drilldown_navigation():
    """Render navigation buttons for drilldown levels"""
    # Navigation buttons removed as requested
    pass

def send_dashboard_summary_on_load(wow_data: Dict, mom_data: Dict, start_date_str: str, end_date_str: str):
    """Send dashboard summary to Slack on load"""
    if not st.session_state.slack_notifier:
        return
    
    # Check if summary was already sent today
    today = datetime.now().strftime("%Y-%m-%d")
    summary_key = f"summary_sent_{today}"
    
    if summary_key not in st.session_state:
        # Show loading indicator
        with st.spinner("📤 Sending dashboard summary to Slack..."):
            try:
                # Prepare summary data
                summary_data = {
                    'date': today,
                    'platform': st.session_state.selected_platform.title(),
                    'date_range': f"{start_date_str} to {end_date_str}",
                    'metrics': {}
                }
                
                # Add WoW metrics
                if wow_data:
                    summary_data['metrics'].update({
                        'Current Sales (WoW)': wow_data.get('current_sales', 0),
                        'Previous Sales (WoW)': wow_data.get('prev_sales', 0),
                        'Sales Change (WoW)': wow_data.get('sales_delta_percent', 0),
                        'Current Orders (WoW)': wow_data.get('current_orders', 0),
                        'Previous Orders (WoW)': wow_data.get('prev_orders', 0),
                        'Orders Change (WoW)': wow_data.get('orders_delta_percent', 0)
                    })
                
                # Add MoM metrics
                if mom_data:
                    summary_data['metrics'].update({
                        'Current Month Sales (MoM)': mom_data.get('current_month_sales', 0),
                        'Previous Month Sales (MoM)': mom_data.get('prev_month_sales', 0),
                        'Sales Change (MoM)': mom_data.get('mom_sales_delta_percent', 0)
                    })
                
                # YoY metrics removed
                
                # Send summary to Slack
                channel = os.getenv('SLACK_CHANNEL', '#alerts')
                
                # Test connection first
                if st.session_state.slack_notifier.test_connection():
                    success = st.session_state.slack_notifier.send_daily_summary(channel, summary_data)
                    
                    if success:
                        st.session_state[summary_key] = True
                        st.success("✅ Dashboard summary sent to Slack successfully!")
                        
                        # Now send operator performance alert
                        send_operator_performance_alert_on_load()
                        
                        # For UberEats, also send bottom performers alert
                        if st.session_state.selected_platform == "ubereats":
                            send_ue_bottom_performers_alert()
                    else:
                        st.warning("⚠️ Failed to send dashboard summary to Slack")
                else:
                    st.error("❌ Slack connection test failed - check your webhook URL")
                    
            except Exception as e:
                st.error(f"❌ Error sending dashboard summary: {e}")
    else:
        # Show that summary was already sent today
        st.info("ℹ️ Dashboard summary already sent to Slack today")

def send_operator_alert(operator_name: str, store_data: pd.DataFrame):
    """Send alert for stores with less than 5% WoW"""
    if not st.session_state.slack_notifier or store_data.empty:
        return
    
    # Filter stores with less than 5% WoW
    low_performing_stores = store_data[
        (store_data['wow_sales_delta_percent'] < 5) & 
        (store_data['wow_sales_delta_percent'] != 0)
    ]
    
    if low_performing_stores.empty:
        return
    
    try:
        platform_name = st.session_state.selected_platform.title()
        platform_emoji = "🚚" if st.session_state.selected_platform == "doordash" else "🍔"
        
        store_names = low_performing_stores['STORE_NAME'].tolist()
        store_count = len(store_names)
        
        message = f"""
⚠️ *Alert: Stores with Low WoW Performance*
{platform_emoji} *Platform:* {platform_name}
🏢 *Operator:* {operator_name}
📊 *Stores with <5% WoW:* {store_count}

🏪 *Store Names:*
{chr(10).join([f"• {name}" for name in store_names])}

📈 *Action Required:* Review these stores for performance optimization
        """.strip()
        
        success = st.session_state.slack_notifier.send_alert(
            channel="#marketing-analytics",
            message=message
        )
        
        if success:
            st.success(f"✅ Alert sent for {store_count} low-performing stores!")
        
    except Exception as e:
        st.error(f"Error sending operator alert: {e}")

def send_store_alert(store_name: str, campaign_data: pd.DataFrame):
    """Send alert for campaigns with less than 5% WoW"""
    if not st.session_state.slack_notifier or campaign_data.empty:
        return
    
    # Filter campaigns with less than 5% WoW
    low_performing_campaigns = campaign_data[
        (campaign_data['wow_sales_delta_percent'] < 5) & 
        (campaign_data['wow_sales_delta_percent'] != 0)
    ]
    
    if low_performing_campaigns.empty:
        return
    
    try:
        platform_name = st.session_state.selected_platform.title()
        platform_emoji = "🚚" if st.session_state.selected_platform == "doordash" else "🍔"
        
        campaign_names = low_performing_campaigns['CAMPAIGN_NAME'].tolist()
        campaign_count = len(campaign_names)
        
        message = f"""
⚠️ *Alert: Campaigns with Low WoW Performance*
{platform_emoji} *Platform:* {platform_name}
🏪 *Store:* {store_name}
📊 *Campaigns with <5% WoW:* {campaign_count}

🎯 *Campaign Names:*
{chr(10).join([f"• {name}" for name in campaign_names])}

📈 *Action Required:* Review these campaigns for performance optimization
        """.strip()
        
        success = st.session_state.slack_notifier.send_alert(
            channel="#marketing-analytics",
            message=message
        )
        
        if success:
            st.success(f"✅ Alert sent for {campaign_count} low-performing campaigns!")
        
    except Exception as e:
        st.error(f"Error sending store alert: {e}")

def send_operator_performance_alert_on_load():
    """Send alert for operators with WoW less than 5% on dashboard load"""
    if not st.session_state.slack_notifier or not st.session_state.operator_data_loaded:
        return
    
    try:
        # Get operator data from session state
        operator_data = st.session_state.operator_summary_data
        
        if operator_data.empty:
            return
        
        # Filter operators with WoW less than 5%
        low_performing_operators = operator_data[
            (operator_data['wow_sales_delta_percent'] < 5) & 
            (operator_data['wow_sales_delta_percent'] != 0)
        ]
        
        if low_performing_operators.empty:
            return
        
        platform_name = st.session_state.selected_platform.title()
        platform_emoji = "🚚" if st.session_state.selected_platform == "doordash" else "🍔"
        
        operator_count = len(low_performing_operators)
        
        message = f"""
⚠️ *Alert: Operators with Low WoW Performance*
{platform_emoji} *Platform:* {platform_name}
📊 *Operators with <5% WoW:* {operator_count}

🏢 *Operator Names:*
{chr(10).join([f"• {row['operator_name']} ({row['wow_sales_delta_percent']:+.1f}%)" for _, row in low_performing_operators.iterrows()])}

📈 *Action Required:* Review these operators for performance optimization
        """.strip()
        
        success = st.session_state.slack_notifier.send_alert(
            channel="#marketing-analytics",
            message=message
        )
        
        if success:
            st.success(f"✅ Operator performance alert sent for {operator_count} low-performing operators!")
        
    except Exception as e:
        st.error(f"Error sending operator performance alert: {e}")

def send_ue_bottom_performers_alert():
    """Send alert for UberEats bottom 5 performers (operators, stores, campaigns)"""
    if not st.session_state.slack_notifier or st.session_state.selected_platform != "ubereats":
        return
    
    try:
        # Get bottom 5 performers for each category
        bottom_operators = st.session_state.bigquery_client.get_ue_bottom_operators_by_sales(5)
        bottom_stores = st.session_state.bigquery_client.get_ue_bottom_stores_by_sales(5)
        bottom_campaigns = st.session_state.bigquery_client.get_ue_bottom_campaigns_by_sales(5)
        
        if bottom_operators.empty and bottom_stores.empty and bottom_campaigns.empty:
            return
        
        platform_emoji = "🍔"
        
        message = f"""
⚠️ *UberEats Bottom 5 Performers Alert*
{platform_emoji} *Platform:* UberEats
📊 *Bottom performers by sales (last 5 rows)*

🏢 *Bottom 5 Operators/Stores:*
{chr(10).join([f"• {row['STORE_NAME']} (ID: {row['STORE_ID']}) - Sales: ${row['total_sales']:,.2f}" for _, row in bottom_operators.iterrows()]) if not bottom_operators.empty else "• No operator data available"}

🏪 *Bottom 5 Stores:*
{chr(10).join([f"• {row['STORE_NAME']} (ID: {row['STORE_ID']}) - Sales: ${row['total_sales']:,.2f}" for _, row in bottom_stores.iterrows()]) if not bottom_stores.empty else "• No store data available"}

🎯 *Bottom 5 Campaigns:*
{chr(10).join([f"• {row['CAMPAIGN_NAME']} ({row['STORE_NAME']}) - Sales: ${row['total_sales']:,.2f}" for _, row in bottom_campaigns.iterrows()]) if not bottom_campaigns.empty else "• No campaign data available"}

📈 *Action Required:* Review these bottom performers for improvement opportunities
        """.strip()
        
        success = st.session_state.slack_notifier.send_alert(
            channel="#marketing-analytics",
            message=message
        )
        
        if success:
            total_bottom = len(bottom_operators) + len(bottom_stores) + len(bottom_campaigns)
            st.success(f"✅ UberEats bottom performers alert sent for {total_bottom} items!")
        
    except Exception as e:
        st.error(f"Error sending UberEats bottom performers alert: {e}")


def main():
    """Main application function with efficient data loading"""
    # Initialize clients
    initialize_clients()
    
    # Header with dynamic platform indicator
    platform_name = st.session_state.selected_platform.title()
    platform_emoji = "🚚" if st.session_state.selected_platform == "doordash" else "🍔"
    st.title(f"📊 Daily Dashboard - TODC Marketing Analytics")
    st.header(f"{platform_emoji} {platform_name} Data")
    
    # Render sidebar and get filters
    start_date, end_date, selected_businesses = render_sidebar()
    
    # Check if BigQuery client is available
    if not st.session_state.bigquery_client:
        st.error("❌ BigQuery client not initialized. Please check your service account file.")
        return
    
    # Convert dates to strings
    start_date_str = start_date.strftime("%Y-%m-%d")
    end_date_str = end_date.strftime("%Y-%m-%d")
    
    # Get store IDs for the selected businesses
    store_ids = get_store_ids_for_operators(selected_businesses)
    
    # Load KPI data only if needed (platform or date changed)
    load_kpi_data_if_needed(st.session_state.selected_platform, start_date_str, end_date_str, store_ids)
    
    # Always render KPI widgets (data is cached in session state)
    render_kpi_widgets(st.session_state.wow_data, st.session_state.mom_data, wow_loading=False, mom_loading=False)
    
    # Render drilldown navigation
    render_drilldown_navigation()
    
    # Load operator data only if needed
    load_operator_data_if_needed(st.session_state.selected_platform, start_date_str, end_date_str, store_ids, selected_businesses)
    
    # Always render operator table (data is cached in session state)
    render_operator_summary_table(st.session_state.operator_summary_data, loading=False)
    
    # Handle drilldown sections - only load when needed
    target_operators_data = get_operators_with_store_ids()
    
    # Show store breakdown if an operator is selected
    if st.session_state.drilldown_level in ["store", "campaign"] and st.session_state.selected_operator:
        selected_operator_stores = target_operators_data.get(st.session_state.selected_operator, [])
        
        if selected_operator_stores:
            # Get max date for the platform
            max_date = get_max_date_for_platform(st.session_state.selected_platform)
            if not max_date:
                st.error("Could not determine max date for store data loading")
                return
            
            # Load store data for the selected operator's stores only
            if st.session_state.selected_platform == "ubereats":
                # For UberEats, get all available data without date filters
                selected_operator_store_data = st.session_state.bigquery_client.get_ue_operator_wise_data_all_time(
                    selected_operator_stores
                )
            else:
                selected_operator_store_data = st.session_state.bigquery_client.get_operator_wise_data(
                    max_date, max_date, selected_operator_stores
                )
            
            # Only show warning if no data found
            if selected_operator_store_data.empty:
                if st.session_state.selected_platform == "ubereats":
                    st.warning("⚠️ **No UberEats data found for these store IDs.**")
                    st.warning("**Possible causes:**")
                    st.warning("• Store IDs don't exist in UberEats BigQuery table")
                    st.warning("• No UberEats campaign data for these stores")
                    st.warning("• UberEats table may be empty or inaccessible")
                    st.info("**Note:** UberEats data is limited to historical periods")
                    st.info("**Store IDs checked:** " + ", ".join(selected_operator_stores[:5]) + ("..." if len(selected_operator_stores) > 5 else ""))
                else:
                    st.warning("⚠️ **No data found for these store IDs on this date.**")
                    st.warning("**Possible causes:**")
                    st.warning("• Store IDs don't exist in BigQuery table")
                    st.warning("• No campaign data for these stores")
                    st.warning("• Data sync issues between CSV and BigQuery")
                    st.info(f"**Latest available data:** 2025-09-10")
                    st.info(f"**Dashboard date:** {start_date_str}")
            else:
                # Send alert for stores with low WoW performance
                send_operator_alert(st.session_state.selected_operator, selected_operator_store_data)
            
            render_store_wise_breakdown(selected_operator_store_data, loading=False)
        else:
            st.warning(f"No stores found for operator: {st.session_state.selected_operator}")
    
    # Show campaign breakdown if a store is selected
    if st.session_state.drilldown_level == "campaign" and st.session_state.selected_store:
        # Load campaign data for the selected store
        if st.session_state.selected_platform == "ubereats":
            # For UberEats, get all available campaign data without date filters
            campaigns_data = st.session_state.bigquery_client.get_ue_top_campaigns_all_time([st.session_state.selected_store])
        else:
            campaigns_data = st.session_state.bigquery_client.get_top_campaigns(30, [st.session_state.selected_store])
        
        # Send alert for campaigns with low WoW performance
        if not campaigns_data.empty:
            # Get store name from the campaign data
            store_name = campaigns_data['STORE_NAME'].iloc[0] if 'STORE_NAME' in campaigns_data.columns else st.session_state.selected_store
            send_store_alert(store_name, campaigns_data)
        
        render_campaign_breakdown(campaigns_data)
    
    # Send dashboard summary to Slack on load (only once per session)
    if not st.session_state.get('slack_summary_sent', False):
        send_dashboard_summary_on_load(st.session_state.wow_data, st.session_state.mom_data, start_date_str, end_date_str)
        st.session_state.slack_summary_sent = True

if __name__ == "__main__":
    main()
