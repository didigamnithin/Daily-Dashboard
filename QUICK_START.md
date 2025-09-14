# Quick Start Guide - Daily Dashboard

## 🚀 Getting Started

### 1. Install Dependencies
```bash
pip3 install -r requirements.txt
```

### 2. Verify Setup
```bash
python3 test_app.py
```

### 3. Run the Dashboard
```bash
python3 run.py
# OR
streamlit run app.py
```

## 📊 What You'll See

### Dashboard Features
- **KPI Widgets**: PoP, MoM, and YoY metrics with delta percentages
- **Interactive Filters**: Platform selection (DoorDash/UberEats), date ranges, operators
- **Trend Charts**: 30-day sales visualization
- **Top Campaigns**: Best-performing campaigns table
- **Slack Alerts**: Send performance alerts to Slack

### Slack Integration
- ✅ **Webhook URL**: Configured from `slack.env`
- ✅ **Test Connection**: Available in sidebar
- ✅ **Alert Types**: PoP, MoM, YoY performance alerts

## 🔧 Configuration

### BigQuery
- Service account file: `todc-marketing-da349d76b96a.json` (in project directory)
- Tables: `dd_raw_promotion_campaigns`, `ue_raw_offers_campaigns`

### Slack
- Webhook URL: Loaded from `slack.env`
- Channel: `#alerts` (configurable)

## 📈 Understanding the Metrics

### Period over Period (PoP)
- Compares selected date range with previous equivalent period
- Example: Sep 1-10 vs Aug 22-31 (same 10 days)

### Month over Month (MoM)
- Current month sales vs same days in previous month (ending today-2)
- Example: Sep 1-12 vs Aug 1-12 (both ending 2 days ago)

### Year over Year (YoY)
- Current year sales vs same period in previous year (ending today-2)
- Example: Jan 1 - Sep 12, 2025 vs Jan 1 - Sep 12, 2024

## 🎨 Design Features
- **Light Mode**: Clean, professional interface
- **Google Open Sans**: Consistent typography
- **Color Coding**: Green (positive), Red (negative), Gray (neutral)
- **CEO-Level**: Executive-ready presentation

## 🚨 Troubleshooting

### No Data Showing
- Check if tables contain data for selected date range
- Verify BigQuery permissions
- Try broader date ranges

### Slack Alerts Not Working
- Verify webhook URL in `slack.env`
- Test connection in sidebar
- Check Slack app permissions

### Performance Issues
- Reduce date range for faster queries
- Use default "today" setting for quick results

## 📞 Support
- Check `README.md` for detailed documentation
- Run `python3 test_app.py` for diagnostics
- Verify all environment variables are loaded

---

**Ready to go!** 🎉
