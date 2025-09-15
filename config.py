"""
Configuration settings for Daily Dashboard
"""

import os
from typing import Optional

class Config:
    """Configuration class for dashboard settings"""
    
    # BigQuery Configuration
    BIGQUERY_PROJECT_ID = "todc-marketing"
    BIGQUERY_SERVICE_ACCOUNT_PATH = "todc-marketing-da349d76b96a.json"
    
    # Slack Configuration (Optional)
    SLACK_BOT_TOKEN: Optional[str] = os.getenv('SLACK_BOT_TOKEN')
    SLACK_WEBHOOK_URL: Optional[str] = os.getenv('SLACK_WEBHOOK_URL')
    SLACK_APP_ID = os.getenv('SLACK_APP_ID', 'A09EU16AU1W')
    SLACK_CLIENT_ID = os.getenv('SLACK_CLIENT_ID', '1090020357526.9504040368064')
    SLACK_CLIENT_SECRET = os.getenv('SLACK_CLIENT_SECRET', '0da48958dbe8108477abe0ad1eb4944b')
    SLACK_SIGNING_SECRET = os.getenv('SLACK_SIGNING_SECRET', '8e79a03a653d07f1962fcb6add56284d')
    SLACK_VERIFICATION_TOKEN = os.getenv('SLACK_VERIFICATION_TOKEN', 'WWCvMwgN0Yt3buEQRJaM5U0Z')
    SLACK_DEFAULT_CHANNEL = os.getenv('SLACK_CHANNEL', '#alerts')
    
    # Dashboard Configuration
    DEFAULT_PLATFORM = "doordash"
    DEFAULT_DATE_RANGE_DAYS = 7
    DEFAULT_TREND_DAYS = 30
    DEFAULT_TOP_CAMPAIGNS_LIMIT = 10
    
    # Table Names
    DD_TABLE = "todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns"
    UE_TABLE = "todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns"
    
    # UI Configuration
    PAGE_TITLE = "Daily Dashboard - TODC Marketing Analytics"
    PAGE_ICON = "📊"
    LAYOUT = "wide"
    
    # Font Configuration
    FONT_FAMILY = "sans serif"  # Streamlit compatible font
    PRIMARY_COLOR = "#3b82f6"
    SUCCESS_COLOR = "#059669"
    WARNING_COLOR = "#f59e0b"
    ERROR_COLOR = "#dc2626"
