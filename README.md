# Daily Dashboard - TODC Marketing Analytics

A comprehensive CEO-level dashboard for analyzing DoorDash and UberEats campaign performance data from BigQuery. This Streamlit application provides real-time insights with Period over Period (PoP), Month over Month (MoM), and Year over Year (YoY) analytics, along with Slack integration for automated alerts.

## 🚀 Features

### 📊 Analytics & Metrics
- **Period over Period (PoP) Analysis**: Compare selected date range with previous equivalent period
- **Month over Month (MoM) Analysis**: Current month vs. same period last month
- **Year over Year (YoY) Analysis**: Current year vs. same period last year
- **Daily Sales Trends**: 30-day rolling trend visualization
- **Top Performing Campaigns**: Ranked list of best-performing campaigns

### 🎛️ Interactive Dashboard
- **Collapsible Sidebar**: Clean, organized filter panel
- **Platform Selection**: Toggle between DoorDash and UberEats data
- **Date Range Picker**: Custom date selection with default to today
- **Operator Filters**: Multi-select operator filtering (extensible)
- **Real-time Refresh**: Manual data refresh capability
- **Interactive Drilldown**: Click through Operator → Store → Campaign levels
- **Progressive Navigation**: Smooth state management with back/forward buttons

### 📱 Slack Integration
- **Automated Summary**: Send dashboard summary automatically on load
- **PoP/MoM/YoY Metrics**: Comprehensive performance overview
- **Formatted Messages**: Rich, structured alert messages with color coding
- **Test Connectivity**: Built-in Slack connection testing
- **Daily Notifications**: One-time daily summary to avoid spam

### 🎨 Design & UX
- **CEO-Level Presentation**: Clean, professional interface
- **Light Mode Theme**: Optimized for business presentations
- **Google Open Sans Font**: Consistent, readable typography
- **Responsive Layout**: Works on desktop and tablet devices
- **Color-Coded Metrics**: Green/red indicators for performance trends

## 📁 Project Structure

```
Daily Dashboard/
├── app.py                 # Main Streamlit application
├── bigquery_utils.py      # BigQuery connection and data fetching
├── slack_utils.py         # Slack integration and notifications
├── config.py              # Configuration settings
├── sql_queries.sql        # All SQL queries for analytics
├── requirements.txt       # Python dependencies
├── test_field_types.py    # Data type testing script
├── debug_operator_data.py # Operator data debugging script
└── README.md             # This documentation
```

## 🔍 Data Type Reference

### CSV File Field Types
The `Account Information-McDonalds.csv` file contains the following key field types:

| Field Name | Data Type | Description | Example Values |
|------------|-----------|-------------|----------------|
| `DoorDash Store ID` | `float64` | Store identifier as float | `24207786.0`, `655940.0` |
| `Business Name` | `string` | Operator business name | `"Bear Family Restaurants MCD"` |
| `Account Name` | `string` | Full account identifier | `"Bear Family Restaurants MCD - 401 Summit St"` |
| `Status` | `string` | Account status | `"Contracting"`, `"Paused /Cancelled"` |

### BigQuery Table Field Types
The `dd_raw_promotion_campaigns` table contains the following field types:

| Field Name | Data Type | Description | Example Values |
|------------|-----------|-------------|----------------|
| `STORE_ID` | `STRING` | Store identifier as string | `"24207786"`, `"655940"` |
| `SALES` | `STRING` | Sales amount as string | `"24.21"`, `"35.47"` |
| `ORDERS` | `STRING` | Order count as string | `"1"`, `"5"` |
| `ROAS` | `STRING` | Return on ad spend as string | `"4.21"`, `"3.85"` |
| `CAMPAIGN_ID` | `STRING` | Campaign identifier | `"0617012f-d76a-4b5d-a720-28d0201f604f"` |
| `DATE` | `STRING` | Date in YYYY-MM-DD format | `"2025-08-05"`, `"2025-08-06"` |

### Data Type Conversion
The application handles data type conversion between CSV and BigQuery:

1. **CSV to BigQuery**: `float64` → `string`
   ```python
   store_id_str = str(int(float(store_id))).strip()
   ```

2. **BigQuery Processing**: String values are cast to appropriate types in SQL:
   ```sql
   SUM(CAST(SALES AS FLOAT64)) as total_sales
   SUM(CAST(ORDERS AS INT64)) as total_orders
   AVG(CAST(ROAS AS FLOAT64)) as avg_roas
   ```

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Zero results in operator table | Date range too narrow | Expand date range to 7+ days |
| Store IDs not found | Data type mismatch | Verify CSV has valid numeric store IDs |
| Null values in CSV | Missing data | Check CSV for empty DoorDash Store ID fields |
| BigQuery connection errors | Invalid credentials | Verify service account JSON file |
| Font warnings | Invalid Streamlit font | Use system fonts (sans serif, serif, monospace) |
| BigQuery Storage warnings | Missing storage module | Install: `pip install google-cloud-bigquery-storage` |

## 🆕 New Features (Latest Update)

### Interactive Drilldown Functionality
The dashboard now supports progressive drill-down navigation:

1. **Operator Level**: View aggregated metrics for all operators
2. **Store Level**: Click on an operator to see store-wise breakdown
3. **Campaign Level**: Click on a store to see campaign performance

**Navigation Controls:**
- 🏠 **Back to Operators**: Return to operator summary view
- 🏪 **Back to Stores**: Return to store breakdown for selected operator
- 🔄 **Reset View**: Clear all selections and return to operator view

### Automated Slack Integration
- **Daily Summary**: Automatically sends PoP, MoM, and YoY metrics on dashboard load
- **One-time Daily**: Prevents spam by sending only one summary per day
- **Rich Formatting**: Includes current vs. previous period comparisons
- **Status Indicators**: Shows connection status in sidebar

### Enhanced Data Processing
- **Fixed Date Range**: Default to 7-day range for better data visibility
- **Improved Error Handling**: Better debugging information for empty data
- **Data Type Validation**: Comprehensive testing scripts for field compatibility
- **Warning Suppression**: Resolved font and BigQuery Storage warnings
- **Standard Fonts**: Updated to use system fonts for better compatibility

## 🛠️ Installation & Setup

### Prerequisites
- Python 3.8 or higher
- Google Cloud BigQuery service account with access to `todc-marketing` project
- Slack Bot Token (optional, for alerts)

### Step 1: Clone and Setup Environment

```bash
# Navigate to the project directory
cd "Daily Dashboard"

# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Step 2: BigQuery Configuration

1. **Service Account Setup**:
   - Ensure your service account JSON file is in the project directory: `todc-marketing-da349d76b96a.json`
   - The service account needs access to the following tables:
     - `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
     - `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`

2. **Verify Access**:
   ```python
   from bigquery_utils import BigQueryClient
   client = BigQueryClient("todc-marketing-da349d76b96a.json")
   # Should initialize without errors
   ```

### Step 3: Slack Configuration (Optional)

1. **Create Slack App**:
   - Go to [api.slack.com/apps](https://api.slack.com/apps)
   - Create a new app and get the Bot User OAuth Token

2. **Set Environment Variable**:
   ```bash
   export SLACK_BOT_TOKEN="xoxb-your-token-here"
   ```

3. **Configure Channel**:
   - Update `SLACK_DEFAULT_CHANNEL` in `config.py` to your desired channel
   - Default: `#marketing-alerts`

### Step 4: Run the Application

```bash
streamlit run app.py
```

The dashboard will be available at `http://localhost:8501`

## 📊 Data Sources & Schema

### DoorDash Data (`dd_raw_promotion_campaigns`)
Key fields used in analytics:
- `DATE`: Campaign date
- `SALES`: Total sales amount
- `ORDERS`: Number of orders
- `CAMPAIGN_ID`: Unique campaign identifier
- `STORE_NAME`: Store/restaurant name
- `ROAS`: Return on Ad Spend

### UberEats Data (`ue_raw_offers_campaigns`)
Key fields used in analytics:
- `START_DATE` / `END_DATE`: Campaign date range
- `SALES_USD`: Total sales in USD
- `ORDERS`: Number of orders
- `CAMPAIGN_UUID`: Unique campaign identifier
- `STORES`: Store information

## 🔧 Usage Guide

### Dashboard Navigation

1. **Sidebar Filters**:
   - **Platform**: Select DoorDash or UberEats
   - **Date Range**: Choose custom dates or use today's data
   - **Operators**: Filter by specific restaurant chains
   - **Refresh**: Manually reload data

2. **Main Dashboard**:
   - **KPI Widgets**: PoP, MoM, and YoY metrics with delta percentages
   - **Trend Chart**: 30-day sales trend visualization
   - **Top Campaigns**: Best-performing campaigns table

3. **Slack Alerts**:
   - **Test Connection**: Verify Slack integration
   - **Send Alerts**: Manually trigger PoP, MoM, or YoY alerts

### Understanding the Metrics

#### Period over Period (PoP)
- **Current Period**: Sales for selected date range
- **Previous Period**: Sales for equivalent period before
- **Delta %**: Percentage change between periods
- **Example**: Sep 1-10 vs Aug 22-31 (same 10-day period)

#### Month over Month (MoM)
- **Current Month**: Sales from start of current month to today-2
- **Previous Month**: Sales for same days in previous month
- **Delta %**: Month-over-month percentage change

#### Year over Year (YoY)
- **Current Year**: Sales from start of current year to today-2
- **Previous Year**: Sales for same period in previous year
- **Delta %**: Year-over-year percentage change

### Color Coding
- 🟢 **Green**: Positive growth (>0%)
- 🔴 **Red**: Negative growth (<0%)
- ⚪ **Gray**: No change (0%)

## 🔍 SQL Queries

All queries are stored in `sql_queries.sql` and include:

1. **PoP Sales Query**: Period comparison with automatic date calculation
2. **MoM Sales Query**: Month-over-month analysis
3. **YoY Sales Query**: Year-over-year analysis
4. **Daily Trend Query**: 30-day rolling sales data
5. **Top Campaigns Query**: Best-performing campaigns ranking

### Query Customization

To modify queries:
1. Edit `sql_queries.sql` for static queries
2. Modify methods in `bigquery_utils.py` for dynamic queries
3. Update `app.py` to use new query results

## 🚨 Troubleshooting

### Common Issues

1. **BigQuery Connection Error**:
   ```
   Error: Failed to initialize BigQuery client
   ```
   - Verify service account JSON file path
   - Check BigQuery permissions
   - Ensure project ID is correct

2. **No Data Displayed**:
   - Check if tables contain data for selected date range
   - Verify table names in `config.py`
   - Check BigQuery console for data availability

3. **Slack Alerts Not Working**:
   ```
   Warning: Slack bot token not provided
   ```
   - Set `SLACK_BOT_TOKEN` environment variable
   - Verify bot has channel access
   - Check Slack app permissions

4. **Performance Issues**:
   - Reduce date range for faster queries
   - Add indexes to BigQuery tables
   - Use query result caching

### Debug Mode

Enable debug logging:
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

## 🔒 Security Considerations

1. **Service Account**: Keep JSON file secure and never commit to version control
2. **Slack Token**: Store as environment variable, not in code
3. **Data Access**: Ensure minimal required permissions for BigQuery
4. **Network**: Run on secure network for production deployment

## 🚀 Deployment

### Local Development
```bash
streamlit run app.py
```

### Production Deployment
1. **Streamlit Cloud**: Deploy directly from GitHub
2. **Docker**: Create Dockerfile for containerized deployment
3. **Cloud Run**: Deploy on Google Cloud Platform
4. **AWS/GCP**: Use cloud services for scalable deployment

### Environment Variables for Production
```bash
SLACK_BOT_TOKEN=xoxb-production-token
BIGQUERY_SERVICE_ACCOUNT_PATH=/path/to/service-account.json
```

## 📈 Future Enhancements

### Planned Features
- [ ] Real-time data streaming
- [ ] Advanced filtering options
- [ ] Export functionality (PDF/Excel)
- [ ] Mobile-responsive design
- [ ] Multi-language support
- [ ] Custom alert thresholds
- [ ] Data export scheduling
- [ ] Advanced visualizations

### Customization Options
- Modify color schemes in `app.py` CSS
- Add new metrics in `bigquery_utils.py`
- Extend Slack integration in `slack_utils.py`
- Customize queries in `sql_queries.sql`

## 📞 Support

For technical support or feature requests:
1. Check this README for common solutions
2. Review error logs in Streamlit console
3. Verify BigQuery and Slack configurations
4. Test with minimal data sets

## 📄 License

This project is proprietary to TODC Marketing Analytics.

---

**Last Updated**: January 2025  
**Version**: 1.0.0  
**Author**: TODC Development Team
