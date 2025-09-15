# Dashboard Cache System

## Overview
The Daily Dashboard now includes a sophisticated caching system that stores dashboard views for each session to improve performance and reduce BigQuery API calls.

## How It Works

### Session-Based Caching
- Each dashboard session gets a unique session ID (e.g., `session_20250915_201644_3304`)
- Cache files are stored in `cache/sessions/[session_id]/` directories
- Each dashboard state (platform, date range, operators, drilldown level) gets a unique cache key

### Cache Key Generation
Cache keys are generated based on:
- Platform (DoorDash/UberEats)
- Date range (start_date, end_date)
- Selected operators
- Drilldown level (operator/store/campaign)
- Selected operator/store (if applicable)

### Data Caching
The system caches:
- KPI data (PoP, MoM, YoY)
- Operator summary data
- Store breakdown data
- Campaign data

## Cache Management

### Automatic Features
- **Cache Expiration**: Cache files expire after 24 hours
- **Automatic Cleanup**: Old session caches are cleaned up automatically
- **Error Handling**: Corrupted cache files are automatically removed

### Manual Controls
In the sidebar, you can:
- **View Cache Stats**: See number of cached views and total size
- **Clear Cache**: Remove all cached data for current session
- **Clean Old**: Remove caches from old sessions (older than 7 days)

## Performance Benefits

### First Load
- Shows "Loading data from BigQuery..." spinner
- Saves data to cache after successful load
- Shows "💾 Data cached for faster future access!" message

### Subsequent Loads
- Shows "📁 Loading from cache..." message
- Loads data instantly from local cache
- No BigQuery API calls needed

## Cache File Structure
```
cache/
└── sessions/
    └── session_20250915_201644_3304/
        ├── 2113f623178a9ba141dc94245404b5c8_dashboard_view.pkl
        ├── 0d47128fcffbae5313a58b621ec88362_dashboard_view.pkl
        └── ...
```

## Technical Details

### Cache Implementation
- Uses Python `pickle` for serialization
- MD5 hashing for cache key generation
- Timestamp-based expiration
- Session-based isolation

### Data Types Cached
- `dashboard_view`: Complete dashboard state
- `kpi_data`: KPI metrics
- `operator_data`: Operator summary data
- `store_data`: Store breakdown data
- `campaign_data`: Campaign performance data

### Error Handling
- Graceful fallback to BigQuery if cache fails
- Automatic cleanup of corrupted files
- Session isolation prevents cross-session issues

## Benefits
1. **Faster Loading**: Instant data retrieval for previously viewed states
2. **Reduced API Calls**: Fewer BigQuery requests
3. **Better UX**: No waiting for repeated data loads
4. **Cost Savings**: Reduced BigQuery usage
5. **Offline Capability**: View cached data even without network

## Maintenance
- Cache files are automatically cleaned up
- No manual maintenance required
- Cache directory is excluded from version control
- Session-based isolation prevents conflicts
