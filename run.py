#!/usr/bin/env python3
"""
Daily Dashboard Runner Script
Simple script to launch the Streamlit dashboard with proper configuration
"""

import os
import sys
import subprocess
from pathlib import Path

def check_requirements():
    """Check if all requirements are installed"""
    try:
        import streamlit
        import pandas
        import plotly
        import google.cloud.bigquery
        print("✅ All required packages are installed")
        return True
    except ImportError as e:
        print(f"❌ Missing required package: {e}")
        print("Please run: pip install -r requirements.txt")
        return False

def check_service_account():
    """Check if BigQuery service account file exists"""
    service_account_path = "todc-marketing-da349d76b96a.json"
    if os.path.exists(service_account_path):
        print("✅ BigQuery service account file found")
        return True
    else:
        print(f"❌ BigQuery service account file not found at: {service_account_path}")
        print("Please ensure the service account JSON file is in the correct location")
        return False

def check_slack_token():
    """Check if Slack token is configured"""
    slack_token = os.getenv('SLACK_BOT_TOKEN')
    if slack_token:
        print("✅ Slack bot token configured")
        return True
    else:
        print("⚠️  Slack bot token not configured (optional)")
        print("Set SLACK_BOT_TOKEN environment variable for Slack alerts")
        return False

def main():
    """Main function to run the dashboard"""
    print("🚀 Starting Daily Dashboard...")
    print("=" * 50)
    
    # Check prerequisites
    if not check_requirements():
        sys.exit(1)
    
    if not check_service_account():
        sys.exit(1)
    
    check_slack_token()
    
    print("=" * 50)
    print("🌐 Launching Streamlit dashboard...")
    print("Dashboard will be available at: http://localhost:8501")
    print("Press Ctrl+C to stop the server")
    print("=" * 50)
    
    # Launch Streamlit
    try:
        subprocess.run([
            sys.executable, "-m", "streamlit", "run", "app.py",
            "--server.port", "8501",
            "--server.address", "localhost",
            "--browser.gatherUsageStats", "false",
            "--theme.base", "light",
            "--theme.primaryColor", "#3b82f6",
            "--theme.backgroundColor", "#ffffff",
            "--theme.secondaryBackgroundColor", "#f8fafc",
            "--theme.textColor", "#000000"
        ])
    except KeyboardInterrupt:
        print("\n👋 Dashboard stopped by user")
    except Exception as e:
        print(f"❌ Error launching dashboard: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
