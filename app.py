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
from typing import Dict, Optional
from dotenv import load_dotenv

# Load environment variables from slack.env
load_dotenv('slack.env')

# Import custom modules
from bigquery_utils import BigQueryClient
from slack_utils import SlackNotifier
import pandas as pd

# Page configuration
st.set_page_config(
    page_title="Daily Dashboard - TODC Marketing Analytics",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="collapsed"
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
    """Load unique business names from CSV file"""
    try:
        csv_path = "Account Information-McDonalds.csv"
        df = pd.read_csv(csv_path)
        
        # Get unique business names and sort them
        business_names = df['Business Name'].dropna().unique()
        business_names = sorted([name.strip() for name in business_names if name.strip()])
        
        return business_names
    except Exception as e:
        st.error(f"Error loading business names: {e}")
        # Fallback to default options
        return ["KFC", "McDonald's", "Subway", "Pizza Hut"]

@st.cache_data
def get_store_ids_for_operators(selected_operators):
    """Get DoorDash Store IDs for selected operators"""
    try:
        if not selected_operators or "All" in selected_operators:
            return None  # No filtering needed
        
        csv_path = "Account Information-McDonalds.csv"
        df = pd.read_csv(csv_path)
        
        # Filter by selected operators
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
    except Exception as e:
        st.error(f"Error loading store IDs: {e}")
        return None

@st.cache_data
def get_operators_with_store_ids():
    """Get all unique operators with their store IDs"""
    try:
        csv_path = "Account Information-McDonalds.csv"
        df = pd.read_csv(csv_path)
        
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
        st.error(f"Error loading operators data: {e}")
        return {}

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

def format_currency(value: float) -> str:
    """Format currency values"""
    if pd.isna(value) or value is None:
        return "$0.00"
    return f"${value:,.2f}"

def format_percentage(value: float) -> str:
    """Format percentage values with color coding"""
    if pd.isna(value) or value is None:
        return "0.0%"
    
    formatted = f"{value:+.1f}%"
    if value > 0:
        return f'<span class="delta-positive">{formatted}</span>'
    elif value < 0:
        return f'<span class="delta-negative">{formatted}</span>'
    else:
        return f'<span class="delta-neutral">{formatted}</span>'

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
        
        # Operators Filter - Load from CSV (moved above date range)
        st.subheader("Operators")
        business_names = load_business_names()
        
        # Add "All" option at the beginning
        operator_options = ["All"] + business_names
        
        # Show count of available operators
        st.caption(f"📊 {len(business_names)} operators available")
        
        operators = st.multiselect(
            "Select Operators",
            operator_options,
            default=["All"]
        )
        
        # Show store IDs being filtered (if any specific operators selected)
        if operators and "All" not in operators:
            store_ids = get_store_ids_for_operators(operators)
            if store_ids:
                st.caption(f"🏪 Filtering by {len(store_ids)} store IDs")
            else:
                st.caption("⚠️ No store IDs found for selected operators")
        elif "All" in operators:
            st.caption("🌐 Showing data for all operators (no filtering)")
        
        # Date Range Selection
        st.subheader("Date Range")
        use_custom_dates = st.checkbox("Use Custom Date Range", value=False)
        
        if use_custom_dates:
            col1, col2 = st.columns(2)
            with col1:
                start_date = st.date_input(
                    "From Date",
                    value=date.today() - timedelta(days=11),  # Default to 7 days before today-2
                    max_value=date.today() - timedelta(days=2)
                )
            with col2:
                end_date = st.date_input(
                    "To Date",
                    value=date.today() - timedelta(days=2),  # Default to today-2
                    max_value=date.today() - timedelta(days=2)
                )
        else:
            # Default to last 7 days for better data visibility
            start_date = date.today() - timedelta(days=9)  # Start 9 days ago
            end_date = date.today() - timedelta(days=2)    # End 2 days ago (7-day range)
        
        # Refresh Button
        if st.button("🔄 Refresh Data", type="primary"):
            st.rerun()
        
        # Slack Integration Status
        st.subheader("Slack Integration")
        if st.session_state.slack_notifier:
            st.success("✅ Slack Connected - Summary will be sent automatically on load")
            
            # Show Slack configuration details
            with st.expander("🔧 Slack Configuration Details"):
                slack_webhook = os.getenv('SLACK_WEBHOOK_URL')
                slack_channel = os.getenv('SLACK_CHANNEL', 'alerts')
                
                st.write(f"**Channel:** {slack_channel}")
                st.write(f"**Webhook URL:** {slack_webhook[:50]}...")
                st.write("**Connection Type:** Webhook")
                
                # Test configuration
                if st.button("🔍 Test Slack Configuration"):
                    try:
                        if st.session_state.slack_notifier.test_connection():
                            st.success("✅ Slack configuration is working correctly!")
                        else:
                            st.error("❌ Slack configuration test failed")
                    except Exception as e:
                        st.error(f"❌ Configuration test error: {str(e)}")
            
            # Manual Slack alert buttons
            col1, col2 = st.columns(2)
            
            with col1:
                if st.button("📤 Test Alert", help="Send a test alert to Slack"):
                    try:
                        # Test the connection first
                        if st.session_state.slack_notifier.test_connection():
                            # Send a test message
                            channel = os.getenv('SLACK_CHANNEL', '#alerts')
                            test_message = "🧪 Test alert from Daily Dashboard - Application is running successfully!"
                            success = st.session_state.slack_notifier.send_alert(channel, test_message)
                            
                            if success:
                                st.success("✅ Test alert sent successfully to Slack!")
                            else:
                                st.error("❌ Failed to send test alert to Slack")
                        else:
                            st.error("❌ Slack connection test failed")
                    except Exception as e:
                        st.error(f"❌ Error sending test alert: {str(e)}")
            
            with col2:
                if st.button("📊 Send Summary", help="Send dashboard summary to Slack (bypass daily limit)"):
                    try:
                        # Force send summary by clearing the daily flag
                        today = datetime.now().strftime("%Y-%m-%d")
                        summary_key = f"summary_sent_{today}"
                        if summary_key in st.session_state:
                            del st.session_state[summary_key]
                        
                        st.info("🔄 Refreshing data to send summary...")
                        st.rerun()
                    except Exception as e:
                        st.error(f"❌ Error: {str(e)}")
        else:
            st.warning("⚠️ Slack not configured - No automatic summaries will be sent")
        
        return start_date, end_date, operators

def render_kpi_widgets(pop_data: Dict, mom_data: Dict, yoy_data: Dict):
    """Render KPI widgets for PoP, MoM, and YoY"""
    st.subheader("📈 Key Performance Indicators")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        st.markdown("### Period over Period")
        if pop_data:
            current_sales = pop_data.get('current_sales', 0)
            delta_pct = pop_data.get('sales_delta_percent', 0)
            create_metric_card(
                "Sales",
                format_currency(current_sales),
                format_percentage(delta_pct),
                f"vs Previous Period"
            )
        else:
            create_metric_card("Sales", "$0.00", "No Data", "vs Previous Period")
    
    with col2:
        st.markdown("### Month over Month")
        if mom_data:
            current_sales = mom_data.get('current_month_sales', 0)
            delta_pct = mom_data.get('mom_sales_delta_percent', 0)
            create_metric_card(
                "Sales",
                format_currency(current_sales),
                format_percentage(delta_pct),
                f"vs Last Month"
            )
        else:
            create_metric_card("Sales", "$0.00", "No Data", "vs Last Month")
    
    with col3:
        st.markdown("### Year over Year")
        if yoy_data:
            current_sales = yoy_data.get('current_year_sales', 0)
            delta_pct = yoy_data.get('yoy_sales_delta_percent', 0)
            create_metric_card(
                "Sales",
                format_currency(current_sales),
                format_percentage(delta_pct),
                f"vs Last Year"
            )
        else:
            create_metric_card("Sales", "$0.00", "No Data", "vs Last Year")

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

def render_operator_summary_table(operator_data: pd.DataFrame):
    """Render operator summary table with aggregated data"""
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
    
    st.subheader("🏢 Operator Performance Summary")
    
    # Format the data for display
    display_data = operator_data.copy()
    display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{x:.2f}x" if pd.notna(x) else "N/A")
    display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{int(x):,}" if pd.notna(x) else "0")
    display_data['store_count'] = display_data['store_count'].apply(lambda x: f"{int(x)}" if pd.notna(x) else "0")
    display_data['total_campaigns'] = display_data['total_campaigns'].apply(lambda x: f"{int(x)}" if pd.notna(x) else "0")
    
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    # Reorder columns for better display
    column_order = ['rank', 'operator_name', 'total_sales', 'total_orders', 'avg_roas', 'store_count', 'total_campaigns']
    display_data = display_data[column_order]
    
    # Create clickable rows for drilldown
    selected_rows = st.dataframe(
        display_data,
        column_config={
            "rank": st.column_config.NumberColumn("Rank", width="small"),
            "operator_name": st.column_config.TextColumn("Operator", width="large"),
            "total_sales": st.column_config.TextColumn("Total Sales", width="medium"),
            "total_orders": st.column_config.TextColumn("Total Orders", width="medium"),
            "avg_roas": st.column_config.TextColumn("Avg ROAS", width="small"),
            "store_count": st.column_config.TextColumn("Stores", width="small"),
            "total_campaigns": st.column_config.TextColumn("Campaigns", width="small")
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
        st.rerun()

def render_store_wise_breakdown(store_data: pd.DataFrame):
    """Render store-wise breakdown table"""
    if store_data.empty:
        st.warning("No store data available")
        return
    
    st.subheader("🏪 Store-wise Performance Breakdown")
    
    # Format the data for display
    display_data = store_data.copy()
    display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{x:.2f}x" if pd.notna(x) else "N/A")
    display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{int(x):,}" if pd.notna(x) else "0")
    display_data['total_campaigns'] = display_data['total_campaigns'].apply(lambda x: f"{int(x)}" if pd.notna(x) else "0")
    
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    # Reorder columns for better display (removed operator_name since we're filtering by selected operators)
    column_order = ['rank', 'STORE_ID', 'total_sales', 'total_orders', 'avg_roas', 'total_campaigns']
    display_data = display_data[column_order]
    
    # Create clickable rows for drilldown
    selected_rows = st.dataframe(
        display_data,
        column_config={
            "rank": st.column_config.NumberColumn("Rank", width="small"),
            "STORE_ID": st.column_config.TextColumn("Store ID", width="medium"),
            "total_sales": st.column_config.TextColumn("Total Sales", width="medium"),
            "total_orders": st.column_config.TextColumn("Total Orders", width="medium"),
            "avg_roas": st.column_config.TextColumn("Avg ROAS", width="small"),
            "total_campaigns": st.column_config.TextColumn("Campaigns", width="small")
        },
        use_container_width=True,
        hide_index=True
    )
    
    # Handle row selection for drilldown
    # Note: DataFrame selection is not available in this Streamlit version
    # Using alternative approach with selectbox for store selection
    st.markdown("### 🔍 Select Store for Drilldown")
    store_options = ["Select a store..."] + display_data['STORE_ID'].astype(str).tolist()
    selected_store_id = st.selectbox("Choose store to view campaign details:", store_options)
    
    if selected_store_id and selected_store_id != "Select a store...":
        # Update session state for drilldown
        st.session_state.drilldown_level = "campaign"
        st.session_state.selected_store = selected_store_id
        
        st.success(f"🔍 Selected store: **{selected_store_id}** - Loading campaign details...")
        st.rerun()

def render_campaign_breakdown(campaign_data: pd.DataFrame):
    """Render campaign-level breakdown table"""
    if campaign_data.empty:
        st.warning("No campaign data available")
        return
    
    st.subheader("📊 Campaign Performance Breakdown")
    
    # Format the data for display
    display_data = campaign_data.copy()
    if 'total_sales' in display_data.columns:
        display_data['total_sales'] = display_data['total_sales'].apply(format_currency)
    if 'avg_roas' in display_data.columns:
        display_data['avg_roas'] = display_data['avg_roas'].apply(lambda x: f"{x:.2f}x" if pd.notna(x) else "N/A")
    if 'total_orders' in display_data.columns:
        display_data['total_orders'] = display_data['total_orders'].apply(lambda x: f"{int(x):,}" if pd.notna(x) else "0")
    
    # Add performance ranking
    display_data['rank'] = range(1, len(display_data) + 1)
    
    st.dataframe(
        display_data,
        use_container_width=True,
        hide_index=True
    )

def render_drilldown_navigation():
    """Render navigation buttons for drilldown levels"""
    col1, col2, col3 = st.columns([1, 1, 1])
    
    with col1:
        if st.button("🏠 Back to Operators", disabled=st.session_state.drilldown_level == "operator"):
            st.session_state.drilldown_level = "operator"
            st.session_state.selected_operator = None
            st.session_state.selected_store = None
            st.rerun()
    
    with col2:
        if st.button("🏪 Back to Stores", disabled=st.session_state.drilldown_level in ["operator", "store"]):
            st.session_state.drilldown_level = "store"
            st.session_state.selected_store = None
            st.rerun()
    
    with col3:
        if st.button("🔄 Reset View"):
            st.session_state.drilldown_level = "operator"
            st.session_state.selected_operator = None
            st.session_state.selected_store = None
            st.rerun()

def send_dashboard_summary_on_load(pop_data: Dict, mom_data: Dict, yoy_data: Dict, start_date_str: str, end_date_str: str):
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
                
                # Add PoP metrics
                if pop_data:
                    summary_data['metrics'].update({
                        'Current Sales (PoP)': pop_data.get('current_sales', 0),
                        'Previous Sales (PoP)': pop_data.get('prev_sales', 0),
                        'Sales Change (PoP)': pop_data.get('sales_delta_percent', 0),
                        'Current Orders (PoP)': pop_data.get('current_orders', 0),
                        'Previous Orders (PoP)': pop_data.get('prev_orders', 0),
                        'Orders Change (PoP)': pop_data.get('orders_delta_percent', 0)
                    })
                
                # Add MoM metrics
                if mom_data:
                    summary_data['metrics'].update({
                        'Current Month Sales (MoM)': mom_data.get('current_month_sales', 0),
                        'Previous Month Sales (MoM)': mom_data.get('prev_month_sales', 0),
                        'Sales Change (MoM)': mom_data.get('mom_sales_delta_percent', 0)
                    })
                
                # Add YoY metrics
                if yoy_data:
                    summary_data['metrics'].update({
                        'Current Year Sales (YoY)': yoy_data.get('current_year_sales', 0),
                        'Previous Year Sales (YoY)': yoy_data.get('prev_year_sales', 0),
                        'Sales Change (YoY)': yoy_data.get('yoy_sales_delta_percent', 0)
                    })
                
                # Send summary to Slack
                channel = os.getenv('SLACK_CHANNEL', '#alerts')
                
                # Test connection first
                if st.session_state.slack_notifier.test_connection():
                    success = st.session_state.slack_notifier.send_daily_summary(channel, summary_data)
                    
                    if success:
                        st.session_state[summary_key] = True
                        st.success("✅ Dashboard summary sent to Slack successfully!")
                    else:
                        st.warning("⚠️ Failed to send dashboard summary to Slack")
                else:
                    st.error("❌ Slack connection test failed - check your webhook URL")
                    
            except Exception as e:
                st.error(f"❌ Error sending dashboard summary: {e}")
    else:
        # Show that summary was already sent today
        st.info("ℹ️ Dashboard summary already sent to Slack today")


def main():
    """Main application function"""
    # Initialize clients
    initialize_clients()
    
    # Header
    st.title("📊 Daily Dashboard - TODC Marketing Analytics")
    
    # Render sidebar and get filters
    start_date, end_date, operators = render_sidebar()
    
    # Check if BigQuery client is available
    if not st.session_state.bigquery_client:
        st.error("❌ BigQuery client not initialized. Please check your service account file.")
        return
    
    # Convert dates to strings
    start_date_str = start_date.strftime("%Y-%m-%d")
    end_date_str = end_date.strftime("%Y-%m-%d")
    
    # Get store IDs for selected operators
    store_ids = get_store_ids_for_operators(operators)
    
    # Load data with progress indicators
    with st.spinner("Loading data..."):
        # Fetch KPI data
        pop_data = st.session_state.bigquery_client.get_pop_data(
            start_date_str, end_date_str, st.session_state.selected_platform, store_ids
        )
        mom_data = st.session_state.bigquery_client.get_mom_data(st.session_state.selected_platform)
        yoy_data = st.session_state.bigquery_client.get_yoy_data(st.session_state.selected_platform)
        
        # Get operator data based on selection
        if "All" in operators:
            # Get all operators and their store IDs
            all_operators_data = get_operators_with_store_ids()
            operator_summary_data = st.session_state.bigquery_client.get_operator_aggregated_data(
                start_date_str, end_date_str, all_operators_data
            )
            store_breakdown_data = pd.DataFrame()  # No store breakdown for "All"
        else:
            # Get data for selected operators only
            selected_operators_data = get_operators_with_store_ids()
            filtered_operators_data = {k: v for k, v in selected_operators_data.items() if k in operators}
            
            operator_summary_data = st.session_state.bigquery_client.get_operator_aggregated_data(
                start_date_str, end_date_str, filtered_operators_data
            )
            
            # Get store-wise breakdown for selected operators
            store_breakdown_data = st.session_state.bigquery_client.get_operator_wise_data(
                start_date_str, end_date_str, store_ids
            )
        
        # Fetch additional data (reduced for faster loading)
        campaigns_data = st.session_state.bigquery_client.get_top_campaigns(7, store_ids)  # Only last 7 days initially
    
    # Send dashboard summary to Slack on load
    send_dashboard_summary_on_load(pop_data, mom_data, yoy_data, start_date_str, end_date_str)
    
    # Render KPI widgets
    render_kpi_widgets(pop_data, mom_data, yoy_data)
    
    # Add some spacing
    st.markdown("---")
    
    # Render drilldown navigation
    render_drilldown_navigation()
    
    # Handle drilldown levels
    if st.session_state.drilldown_level == "operator":
        # Render operator summary table
        render_operator_summary_table(operator_summary_data)
        
        # Show store-wise breakdown only if specific operators are selected (not "All")
        if not store_breakdown_data.empty:
            # Add some spacing
            st.markdown("---")
            render_store_wise_breakdown(store_breakdown_data)
    
    elif st.session_state.drilldown_level == "store" and st.session_state.selected_operator:
        # Show store-level data for selected operator
        st.subheader(f"🏪 Store Performance - {st.session_state.selected_operator}")
        store_data = get_store_data_for_operator(
            st.session_state.selected_operator, start_date_str, end_date_str
        )
        render_store_wise_breakdown(store_data)
    
    elif st.session_state.drilldown_level == "campaign" and st.session_state.selected_store:
        # Show campaign-level data for selected store
        st.subheader(f"📊 Campaign Performance - Store {st.session_state.selected_store}")
        campaign_data = get_campaign_data_for_store(
            st.session_state.selected_store, start_date_str, end_date_str
        )
        render_campaign_breakdown(campaign_data)
    
    # Add some spacing
    st.markdown("---")
    
    
    # Note: Slack alerts are now sent automatically on dashboard load
    
    # Footer
    st.markdown("---")
    st.markdown(
        f"<div style='text-align: center; color: #6b7280; font-size: 0.8rem;'>"
        f"Last updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | "
        f"Platform: {st.session_state.selected_platform.title()} | "
        f"Date Range: {start_date_str} to {end_date_str}"
        f"</div>",
        unsafe_allow_html=True
    )

if __name__ == "__main__":
    main()
