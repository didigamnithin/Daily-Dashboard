-- SQL Queries for Daily Dashboard Analytics

-- Period over Period (PoP) Sales Query
-- This query calculates sales for selected date range and compares with previous period
WITH selected_period AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as current_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as current_campaigns,
    SUM(CAST(ORDERS AS INT64)) as current_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{start_date}' AND '{end_date}'
    AND SALES IS NOT NULL
    AND SALES != 'null'
),
previous_period AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as prev_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as prev_campaigns,
    SUM(CAST(ORDERS AS INT64)) as prev_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{prev_start_date}' AND '{prev_end_date}'
    AND SALES IS NOT NULL
    AND SALES != 'null'
)
SELECT 
  current_sales,
  prev_sales,
  current_campaigns,
  prev_campaigns,
  current_orders,
  prev_orders,
  CASE 
    WHEN prev_sales > 0 THEN ((current_sales - prev_sales) / prev_sales) * 100
    ELSE 0
  END as sales_delta_percent,
  CASE 
    WHEN prev_orders > 0 THEN ((current_orders - prev_orders) / prev_orders) * 100
    ELSE 0
  END as orders_delta_percent
FROM selected_period, previous_period;

-- Month over Month (MoM) Sales Query
-- This query calculates sales from start of current month to today-2 vs same period last month
WITH current_month AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as current_month_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as current_month_campaigns,
    SUM(CAST(ORDERS AS INT64)) as current_month_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), MONTH)
    AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY)
    AND SALES IS NOT NULL
    AND SALES != 'null'
),
previous_month AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as prev_month_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as prev_month_campaigns,
    SUM(CAST(ORDERS AS INT64)) as prev_month_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE PARSE_DATE('%Y-%m-%d', DATE) >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 MONTH), MONTH)
    AND PARSE_DATE('%Y-%m-%d', DATE) <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 4 DAY), INTERVAL 1 MONTH)
    AND SALES IS NOT NULL
    AND SALES != 'null'
)
SELECT 
  current_month_sales,
  prev_month_sales,
  current_month_campaigns,
  prev_month_campaigns,
  current_month_orders,
  prev_month_orders,
  CASE 
    WHEN prev_month_sales > 0 THEN ((current_month_sales - prev_month_sales) / prev_month_sales) * 100
    ELSE 0
  END as mom_sales_delta_percent,
  CASE 
    WHEN prev_month_orders > 0 THEN ((current_month_orders - prev_month_orders) / prev_month_orders) * 100
    ELSE 0
  END as mom_orders_delta_percent
FROM current_month, previous_month;

-- Year over Year (YoY) Sales Query
-- This query calculates sales from start of current year to today-2 vs same period last year
WITH current_year AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as current_year_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as current_year_campaigns,
    SUM(CAST(ORDERS AS INT64)) as current_year_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE DATE >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), YEAR)
    AND DATE <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
    AND SALES IS NOT NULL
    AND SALES != 'null'
),
previous_year AS (
  SELECT 
    SUM(CAST(SALES AS FLOAT64)) as prev_year_sales,
    COUNT(DISTINCT CAMPAIGN_ID) as prev_year_campaigns,
    SUM(CAST(ORDERS AS INT64)) as prev_year_orders
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE DATE >= DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 YEAR), YEAR)
    AND DATE <= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 1 YEAR)
    AND SALES IS NOT NULL
    AND SALES != 'null'
)
SELECT 
  current_year_sales,
  prev_year_sales,
  current_year_campaigns,
  prev_year_campaigns,
  current_year_orders,
  prev_year_orders,
  CASE 
    WHEN prev_year_sales > 0 THEN ((current_year_sales - prev_year_sales) / prev_year_sales) * 100
    ELSE 0
  END as yoy_sales_delta_percent,
  CASE 
    WHEN prev_year_orders > 0 THEN ((current_year_orders - prev_year_orders) / prev_year_orders) * 100
    ELSE 0
  END as yoy_orders_delta_percent
FROM current_year, previous_year;

-- UberEats PoP Sales Query
WITH selected_period_ue AS (
  SELECT 
    SUM(CAST(REGEXP_REPLACE(SALES_USD, r'[$,]', '') AS FLOAT64)) as current_sales,
    COUNT(DISTINCT CAMPAIGN_UUID) as current_campaigns,
    SUM(CAST(ORDERS AS INT64)) as current_orders
  FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
  WHERE START_DATE <= '{end_date}' AND END_DATE >= '{start_date}'
    AND SALES_USD IS NOT NULL
    AND SALES_USD != '$0'
    AND SALES_USD != 'null'
),
previous_period_ue AS (
  SELECT 
    SUM(CAST(REGEXP_REPLACE(SALES_USD, r'[$,]', '') AS FLOAT64)) as prev_sales,
    COUNT(DISTINCT CAMPAIGN_UUID) as prev_campaigns,
    SUM(CAST(ORDERS AS INT64)) as prev_orders
  FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
  WHERE START_DATE <= '{prev_end_date}' AND END_DATE >= '{prev_start_date}'
    AND SALES_USD IS NOT NULL
    AND SALES_USD != '$0'
    AND SALES_USD != 'null'
)
SELECT 
  current_sales,
  prev_sales,
  current_campaigns,
  prev_campaigns,
  current_orders,
  prev_orders,
  CASE 
    WHEN prev_sales > 0 THEN ((current_sales - prev_sales) / prev_sales) * 100
    ELSE 0
  END as sales_delta_percent,
  CASE 
    WHEN prev_orders > 0 THEN ((current_orders - prev_orders) / prev_orders) * 100
    ELSE 0
  END as orders_delta_percent
FROM selected_period_ue, previous_period_ue;

-- Daily Sales Trend Query
SELECT 
  DATE,
  SUM(CAST(SALES AS FLOAT64)) as daily_sales,
  COUNT(DISTINCT CAMPAIGN_ID) as daily_campaigns,
  SUM(CAST(ORDERS AS INT64)) as daily_orders
FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
WHERE DATE >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 30 DAY)
  AND DATE <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
  AND SALES IS NOT NULL
  AND SALES != 'null'
GROUP BY DATE
ORDER BY DATE;

-- Top Performing Campaigns Query
SELECT 
  CAMPAIGN_NAME,
  STORE_NAME,
  SUM(CAST(SALES AS FLOAT64)) as total_sales,
  SUM(CAST(ORDERS AS INT64)) as total_orders,
  AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
  COUNT(*) as campaign_days
FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
WHERE DATE >= DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY), INTERVAL 30 DAY)
  AND DATE <= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
  AND SALES IS NOT NULL
  AND SALES != 'null'
GROUP BY CAMPAIGN_NAME, STORE_NAME
ORDER BY total_sales DESC
LIMIT 10;

-- Operator-wise Sales, Orders, and ROAS Query
-- This query aggregates data by operator (Business Name) for the selected date range
WITH operator_data AS (
  SELECT 
    STORE_ID,
    SUM(CAST(SALES AS FLOAT64)) as total_sales,
    SUM(CAST(ORDERS AS INT64)) as total_orders,
    AVG(CAST(ROAS AS FLOAT64)) as avg_roas,
    COUNT(DISTINCT CAMPAIGN_ID) as total_campaigns,
    COUNT(*) as total_records
  FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
  WHERE PARSE_DATE('%Y-%m-%d', DATE) BETWEEN '{start_date}' AND '{end_date}'
    AND SALES IS NOT NULL
    AND SALES != 'null'
    {store_filter}
  GROUP BY STORE_ID
)
SELECT 
  od.STORE_ID,
  od.total_sales,
  od.total_orders,
  od.avg_roas,
  od.total_campaigns,
  od.total_records
FROM operator_data od
ORDER BY od.total_sales DESC;
