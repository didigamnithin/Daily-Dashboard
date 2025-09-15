"""
Slack utilities for Daily Dashboard alerts
Handles Slack notifications and alerts
"""

import os
import json
import requests
from typing import Dict, Optional
from datetime import datetime
import streamlit as st


class SlackNotifier:
    """Slack notification handler for dashboard alerts"""
    
    def __init__(self, webhook_url: Optional[str] = None):
        """Initialize Slack client with webhook URL"""
        self.webhook_url = webhook_url or os.getenv('SLACK_WEBHOOK_URL')
        
        if self.webhook_url:
            self.client = None
            self.use_webhook = True
        else:
            self.client = None
            self.use_webhook = False
            st.warning("Slack webhook URL not provided. Alerts will be disabled.")
    
    def send_alert(self, channel: str, message: str, blocks: Optional[list] = None) -> bool:
        """Send alert message to Slack channel via webhook"""
        if self.use_webhook:
            return self._send_webhook_alert(message, blocks)
        else:
            st.error("Slack webhook not configured. Please provide webhook URL.")
            return False
    
    def _send_webhook_alert(self, message: str, blocks: Optional[list] = None) -> bool:
        """Send alert using webhook URL"""
        try:
            payload = {
                "text": message,
                "blocks": blocks
            }
            
            response = requests.post(
                self.webhook_url,
                data=json.dumps(payload),
                headers={'Content-Type': 'application/json'},
                timeout=10
            )
            
            if response.status_code == 200:
                return True
            else:
                st.error(f"Webhook send failed with status code: {response.status_code}")
                st.error(f"Response: {response.text}")
                return False
        except Exception as e:
            st.error(f"Webhook error: {str(e)}")
            return False
    
    
    def send_sales_alert(self, channel: str, data: Dict, alert_type: str) -> bool:
        """Send formatted sales alert to Slack"""
        if not data:
            return False
        
        # Determine alert color based on performance
        color = "good"  # green
        if alert_type == "pop":
            delta = data.get('sales_delta_percent') or 0
        elif alert_type == "mom":
            delta = data.get('mom_sales_delta_percent') or 0
        elif alert_type == "yoy":
            delta = data.get('yoy_sales_delta_percent') or 0
        else:
            delta = 0
        
        if delta < -10:
            color = "danger"  # red
        elif delta < 0:
            color = "warning"  # yellow
        
        # Create formatted message
        if alert_type == "pop":
            title = "📊 Period over Period Sales Alert"
            current_sales = data.get('current_sales')
            prev_sales = data.get('prev_sales')
            delta_pct = data.get('sales_delta_percent')
        elif alert_type == "mom":
            title = "📈 Month over Month Sales Alert"
            current_sales = data.get('current_month_sales')
            prev_sales = data.get('prev_month_sales')
            delta_pct = data.get('mom_sales_delta_percent')
        elif alert_type == "yoy":
            title = "📅 Year over Year Sales Alert"
            current_sales = data.get('current_year_sales')
            prev_sales = data.get('prev_year_sales')
            delta_pct = data.get('yoy_sales_delta_percent')
        else:
            return False
        
        blocks = [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": title
                }
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": f"*Current Sales:* ${current_sales:,.2f}" if current_sales is not None else "*Current Sales:* N/A"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Previous Period:* ${prev_sales:,.2f}" if prev_sales is not None else "*Previous Period:* N/A"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Change:* {delta_pct:+.1f}%" if delta_pct is not None else "*Change:* N/A"
                    },
                    {
                        "type": "mrkdwn",
                        "text": f"*Status:* {'📈' if delta_pct and delta_pct > 0 else '📉' if delta_pct and delta_pct < 0 else '➡️' if delta_pct is not None else '❓'}"
                    }
                ]
            }
        ]
        
        current_display = f"${current_sales:,.2f}" if current_sales is not None else "N/A"
        prev_display = f"${prev_sales:,.2f}" if prev_sales is not None else "N/A"
        change_display = f"{delta_pct:+.1f}%" if delta_pct is not None else "N/A"
        message = f"{title}\nCurrent: {current_display} | Previous: {prev_display} | Change: {change_display}"
        
        return self.send_alert(channel, message, blocks)
    
    def send_daily_summary(self, channel: str, summary_data: Dict) -> bool:
        """Send daily summary to Slack"""
        if not summary_data:
            return False
        
        # Create a simple, compatible block structure
        blocks = [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"🌅 *Daily Dashboard Summary*\n*Date:* {summary_data.get('date', 'Today')}\n*Platform:* {summary_data.get('platform', 'All')}\n*Date Range:* {summary_data.get('date_range', 'N/A')}"
                }
            }
        ]
        
        # Add metrics in a simple format
        metrics = summary_data.get('metrics', {})
        if metrics:
            metrics_text = "\n".join([
                f"*{key.replace('_', ' ').title()}:* {self._format_metric_value(key, value)}"
                for key, value in metrics.items()
                if isinstance(value, (int, float))
            ])
            
            if metrics_text:
                blocks.append({
                    "type": "section",
                    "text": {
                        "type": "mrkdwn",
                        "text": f"📊 *Key Metrics:*\n{metrics_text}"
                    }
                })
        
        # Add footer
        blocks.append({
            "type": "context",
            "elements": [
                {
                    "type": "mrkdwn",
                    "text": f"📊 Dashboard accessed at {datetime.now().strftime('%H:%M:%S')} | 🚀 Application running successfully"
                }
            ]
        })
        
        message = f"Daily Dashboard Summary - {summary_data.get('date', 'Today')} | Platform: {summary_data.get('platform', 'All')}"
        return self.send_alert(channel, message, blocks)
    
    def _format_metric_value(self, key: str, value: float) -> str:
        """Format metric values for display"""
        if 'sales' in key.lower():
            return f"${value:,.2f}"
        elif 'percent' in key.lower():
            return f"{value:+.1f}%"
        else:
            return f"{value:,}"
    
    def test_connection(self) -> bool:
        """Test Slack webhook connection"""
        if self.use_webhook:
            return self._test_webhook_connection()
        else:
            return False
    
    def _test_webhook_connection(self) -> bool:
        """Test webhook connection"""
        try:
            test_payload = {
                "text": "🧪 Hey, TODC. Testing webhook connection from Daily Dashboard."
            }
            
            response = requests.post(
                self.webhook_url,
                data=json.dumps(test_payload),
                headers={'Content-Type': 'application/json'},
                timeout=10
            )
            
            if response.status_code == 200:
                return True
            else:
                st.error(f"Webhook test failed with status code: {response.status_code}")
                st.error(f"Response: {response.text}")
                return False
        except Exception as e:
            st.error(f"Webhook connection error: {str(e)}")
            return False
    
