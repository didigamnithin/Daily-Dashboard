
-- query - 2025-09-24 22:41:41

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-24 22:41:45

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-24 23:22:33

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-24 23:22:37

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-24 23:22:39

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-24 23:22:42

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-24 23:22:45

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-24 23:22:48

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- query - 2025-09-24 23:22:50

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Bear Family Restaurants MCD - 2025-09-24 23:22:53

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-24 23:26:30

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-24 23:26:33

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-24 23:26:35

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-24 23:26:38

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-24 23:26:41

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-24 23:27:29

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-24 23:27:32

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24207786', '655940', '653706')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- query - 2025-09-24 23:51:27

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-24 23:51:30

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-24 23:51:33

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-24 23:51:36

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-24 23:51:39

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-24 23:51:42

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-24 23:51:45

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_RJ Nelson Enterprise MCD - 2025-09-24 23:51:48

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Hugh O’Reilly MCD - 2025-09-24 23:51:50

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2649668', '786522', '1732200')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_SSM Inc MCD - 2025-09-24 23:51:53

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management  - 2025-09-24 23:51:55

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management / Glennhaven - 2025-09-24 23:51:59

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24507855')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_JKK Enterprises - 2025-09-24 23:52:01

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('687357', '687002', '23987538', '686331')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSC Enterprises - 2025-09-24 23:52:04

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kinney QSR - 2025-09-24 23:52:06

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('680276', '23161795', '1727364', '680274')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alpha Management  - 2025-09-24 23:52:09

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Goodman Group Restaurants - 2025-09-24 23:52:11

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clark Management  - 2025-09-24 23:52:14

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Herb's Place Inc - 2025-09-24 23:52:16

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655647', '658045')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clone & Buck - 2025-09-24 23:52:19

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kory Management - 2025-09-24 23:52:21

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Arc Limited Group - 2025-09-24 23:52:24

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSR Executive Enterprises - 2025-09-24 23:52:27

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Big Gee Ent LLC - 2025-09-24 23:52:29

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_P.R. Pernecky Management - 2025-09-24 23:52:32

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Wiseman LLC - 2025-09-24 23:52:34

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_West Mount 23719, LLC - 2025-09-24 23:52:37

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Ricely Group - 2025-09-24 23:52:39

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_L3 Restaurants Inc - 2025-09-24 23:52:42

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Knoth Management Group - 2025-09-24 23:52:44

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1160043', '2664004', '1159715')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_O'Keefe Family McDonald's - 2025-09-24 23:52:47

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Upchurch Management  - 2025-09-24 23:52:49

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_LAZ II, Inc - 2025-09-24 23:52:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Marks Management  - 2025-09-24 23:52:54

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Mao Enterprises LLC - 2025-09-24 23:52:57

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Divine Favor, LLC - 2025-09-24 23:53:00

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kipco Restaurants LLC - 2025-09-24 23:53:02

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Grayco Mgt - 2025-09-24 23:53:05

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_DMD Restaurants - 2025-09-24 23:53:07

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659930', '659289', '659492', '655874')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alamo Family LLC - 2025-09-24 23:53:09

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Bican Family Restaurants Inc - 2025-09-24 23:53:12

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655822', '655827', '655825')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- query - 2025-09-24 23:53:14

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- query - 2025-09-24 23:53:17

        WITH current_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1179284', '687508', '655573', '659015', '694110', '685752', '694737', '684491', '686757', '786331', '837666', '679529', '684978', '659264', '688121', '655936', '685540', '24590418', '684476', '23000234', '686685', '687435', '786468', '24752906', '24510603', '654257', '685768', '687989', '654860', '659197', '684418', '680394', '684468', '23161795', '687137', '2108398', '694570', '1102267', '24507497', '24508148', '695044', '24821020', '655874', '2377932', '658077', '684546', '662301', '657012', '2664487', '701506', '860644', '656474', '654943', '656457', '657765', '24821039', '684918', '655954', '658837', '786462', '659888', '24202561', '946241', '662502', '694592', '654446', '655292', '647795', '685069', '1179395', '687052', '653660', '790716', '687850', '694730', '2731379', '946236', '694583', '27993089', '24507749', '2667097', '656518', '656573', '659805', '658616', '653707', '658045', '2297296', '860563', '694700', '24202476', '653727', '685073', '653877', '1011526', '659277', '655644', '680091', '695193', '1753726', '24207864', '679533', '686785', '659614', '677500', '24207837', '656284', '24575666', '694398', '2401263', '2400535', '678863', '685135', '685071', '29488956', '658610', '862451', '24409150', '659289', '24207786', '656317', '658813', '659117', '694246', '655825', '647812', '24277112', '1727364', '701236', '1102150', '23000258', '837676', '23450614', '684634', '680274', '680368', '684904', '656986', '684621', '694265', '694814', '24530672', '1544219', '653893', '680386', '684427', '684457', '677517', '2731693', '23000231', '24575626', '662305', '687543', '679532', '684545', '695172', '694578', '24507498', '837652', '694453', '2667134', '658728', '653737', '687357', '657905', '686331', '686892', '2650292', '505344', '1011529', '837641', '655305', '2444918', '678856', '686897', '24507855', '800214', '22918692', '653763', '2496264', '686788', '659572', '1170194', '656507', '653969', '687303', '695465', '694571', '1170166', '25044832', '657082', '860550', '2400648', '2496503', '2633556', '24508024', '23015273', '23450401', '24661300', '657312', '821321', '686979', '686399', '653606', '656318', '659492', '2631815', '656511', '694596', '679531', '654323', '1544237', '684472', '684443', '654732', '659199', '946269', '684559', '2667151', '659372', '22918798', '655822', '837238', '685609', '684628', '653706', '860650', '655647', '23695567', '31752210', '658130', '1286121', '680307', '684617', '679535', '684917', '657041', '695324', '695194', '25070220', '2110005', '659866', '684906', '688065', '2110096', '860640', '680392', '2732280', '1753653', '695100', '687101', '647807', '23000171', '24508284', '653819', '24408834', '24575642', '2663940', '685633', '2664004', '24408689', '786522', '647873', '24941763', '23701157', '2109065', '686392', '2110169', '657751', '657052', '659500', '1102215', '28834090', '1159715', '720447', '23000270', '837211', '837656', '659518', '659930', '696601', '656534', '680384', '23000302', '680388', '686273', '680276', '674658', '657157', '1732200', '2122176', '653528', '684455', '655934', '24590476', '31430117', '655941', '694587', '23000201', '686461', '860595', '679476', '685756', '694960', '684444', '2649668', '24202462', '2496846', '1179489', '656520', '24510688', '2400162', '655819', '695468', '655940', '2297300', '786388', '24655482', '658146', '694186', '23695622', '2399997', '2731118', '677499', '2400443', '655297', '684429', '654018', '1160043', '659641', '24122880', '656600', '786414', '659474', '694440', '1882630', '24508144', '837193', '653647', '837208', '659674', '23987538', '837189', '653618', '686933', '1102231', '655827', '680142', '2664473', '659452', '23015221', '653975', '687002', '655480', '2601637', '656282', '24752950', '946252', '657482', '23015471', '686781', '1898843', '2108974', '685532', '24821059', '659406', '647867', '659544', '2608798', '946258', '662129', '835522', '654674')
            GROUP BY STORE_ID, STORE_NAME
            ),
        previous_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1179284', '687508', '655573', '659015', '694110', '685752', '694737', '684491', '686757', '786331', '837666', '679529', '684978', '659264', '688121', '655936', '685540', '24590418', '684476', '23000234', '686685', '687435', '786468', '24752906', '24510603', '654257', '685768', '687989', '654860', '659197', '684418', '680394', '684468', '23161795', '687137', '2108398', '694570', '1102267', '24507497', '24508148', '695044', '24821020', '655874', '2377932', '658077', '684546', '662301', '657012', '2664487', '701506', '860644', '656474', '654943', '656457', '657765', '24821039', '684918', '655954', '658837', '786462', '659888', '24202561', '946241', '662502', '694592', '654446', '655292', '647795', '685069', '1179395', '687052', '653660', '790716', '687850', '694730', '2731379', '946236', '694583', '27993089', '24507749', '2667097', '656518', '656573', '659805', '658616', '653707', '658045', '2297296', '860563', '694700', '24202476', '653727', '685073', '653877', '1011526', '659277', '655644', '680091', '695193', '1753726', '24207864', '679533', '686785', '659614', '677500', '24207837', '656284', '24575666', '694398', '2401263', '2400535', '678863', '685135', '685071', '29488956', '658610', '862451', '24409150', '659289', '24207786', '656317', '658813', '659117', '694246', '655825', '647812', '24277112', '1727364', '701236', '1102150', '23000258', '837676', '23450614', '684634', '680274', '680368', '684904', '656986', '684621', '694265', '694814', '24530672', '1544219', '653893', '680386', '684427', '684457', '677517', '2731693', '23000231', '24575626', '662305', '687543', '679532', '684545', '695172', '694578', '24507498', '837652', '694453', '2667134', '658728', '653737', '687357', '657905', '686331', '686892', '2650292', '505344', '1011529', '837641', '655305', '2444918', '678856', '686897', '24507855', '800214', '22918692', '653763', '2496264', '686788', '659572', '1170194', '656507', '653969', '687303', '695465', '694571', '1170166', '25044832', '657082', '860550', '2400648', '2496503', '2633556', '24508024', '23015273', '23450401', '24661300', '657312', '821321', '686979', '686399', '653606', '656318', '659492', '2631815', '656511', '694596', '679531', '654323', '1544237', '684472', '684443', '654732', '659199', '946269', '684559', '2667151', '659372', '22918798', '655822', '837238', '685609', '684628', '653706', '860650', '655647', '23695567', '31752210', '658130', '1286121', '680307', '684617', '679535', '684917', '657041', '695324', '695194', '25070220', '2110005', '659866', '684906', '688065', '2110096', '860640', '680392', '2732280', '1753653', '695100', '687101', '647807', '23000171', '24508284', '653819', '24408834', '24575642', '2663940', '685633', '2664004', '24408689', '786522', '647873', '24941763', '23701157', '2109065', '686392', '2110169', '657751', '657052', '659500', '1102215', '28834090', '1159715', '720447', '23000270', '837211', '837656', '659518', '659930', '696601', '656534', '680384', '23000302', '680388', '686273', '680276', '674658', '657157', '1732200', '2122176', '653528', '684455', '655934', '24590476', '31430117', '655941', '694587', '23000201', '686461', '860595', '679476', '685756', '694960', '684444', '2649668', '24202462', '2496846', '1179489', '656520', '24510688', '2400162', '655819', '695468', '655940', '2297300', '786388', '24655482', '658146', '694186', '23695622', '2399997', '2731118', '677499', '2400443', '655297', '684429', '654018', '1160043', '659641', '24122880', '656600', '786414', '659474', '694440', '1882630', '24508144', '837193', '653647', '837208', '659674', '23987538', '837189', '653618', '686933', '1102231', '655827', '680142', '2664473', '659452', '23015221', '653975', '687002', '655480', '2601637', '656282', '24752950', '946252', '657482', '23015471', '686781', '1898843', '2108974', '685532', '24821059', '659406', '647867', '659544', '2608798', '946258', '662129', '835522', '654674')
            GROUP BY STORE_ID, STORE_NAME
            ),
            current_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1179284', '687508', '655573', '659015', '694110', '685752', '694737', '684491', '686757', '786331', '837666', '679529', '684978', '659264', '688121', '655936', '685540', '24590418', '684476', '23000234', '686685', '687435', '786468', '24752906', '24510603', '654257', '685768', '687989', '654860', '659197', '684418', '680394', '684468', '23161795', '687137', '2108398', '694570', '1102267', '24507497', '24508148', '695044', '24821020', '655874', '2377932', '658077', '684546', '662301', '657012', '2664487', '701506', '860644', '656474', '654943', '656457', '657765', '24821039', '684918', '655954', '658837', '786462', '659888', '24202561', '946241', '662502', '694592', '654446', '655292', '647795', '685069', '1179395', '687052', '653660', '790716', '687850', '694730', '2731379', '946236', '694583', '27993089', '24507749', '2667097', '656518', '656573', '659805', '658616', '653707', '658045', '2297296', '860563', '694700', '24202476', '653727', '685073', '653877', '1011526', '659277', '655644', '680091', '695193', '1753726', '24207864', '679533', '686785', '659614', '677500', '24207837', '656284', '24575666', '694398', '2401263', '2400535', '678863', '685135', '685071', '29488956', '658610', '862451', '24409150', '659289', '24207786', '656317', '658813', '659117', '694246', '655825', '647812', '24277112', '1727364', '701236', '1102150', '23000258', '837676', '23450614', '684634', '680274', '680368', '684904', '656986', '684621', '694265', '694814', '24530672', '1544219', '653893', '680386', '684427', '684457', '677517', '2731693', '23000231', '24575626', '662305', '687543', '679532', '684545', '695172', '694578', '24507498', '837652', '694453', '2667134', '658728', '653737', '687357', '657905', '686331', '686892', '2650292', '505344', '1011529', '837641', '655305', '2444918', '678856', '686897', '24507855', '800214', '22918692', '653763', '2496264', '686788', '659572', '1170194', '656507', '653969', '687303', '695465', '694571', '1170166', '25044832', '657082', '860550', '2400648', '2496503', '2633556', '24508024', '23015273', '23450401', '24661300', '657312', '821321', '686979', '686399', '653606', '656318', '659492', '2631815', '656511', '694596', '679531', '654323', '1544237', '684472', '684443', '654732', '659199', '946269', '684559', '2667151', '659372', '22918798', '655822', '837238', '685609', '684628', '653706', '860650', '655647', '23695567', '31752210', '658130', '1286121', '680307', '684617', '679535', '684917', '657041', '695324', '695194', '25070220', '2110005', '659866', '684906', '688065', '2110096', '860640', '680392', '2732280', '1753653', '695100', '687101', '647807', '23000171', '24508284', '653819', '24408834', '24575642', '2663940', '685633', '2664004', '24408689', '786522', '647873', '24941763', '23701157', '2109065', '686392', '2110169', '657751', '657052', '659500', '1102215', '28834090', '1159715', '720447', '23000270', '837211', '837656', '659518', '659930', '696601', '656534', '680384', '23000302', '680388', '686273', '680276', '674658', '657157', '1732200', '2122176', '653528', '684455', '655934', '24590476', '31430117', '655941', '694587', '23000201', '686461', '860595', '679476', '685756', '694960', '684444', '2649668', '24202462', '2496846', '1179489', '656520', '24510688', '2400162', '655819', '695468', '655940', '2297300', '786388', '24655482', '658146', '694186', '23695622', '2399997', '2731118', '677499', '2400443', '655297', '684429', '654018', '1160043', '659641', '24122880', '656600', '786414', '659474', '694440', '1882630', '24508144', '837193', '653647', '837208', '659674', '23987538', '837189', '653618', '686933', '1102231', '655827', '680142', '2664473', '659452', '23015221', '653975', '687002', '655480', '2601637', '656282', '24752950', '946252', '657482', '23015471', '686781', '1898843', '2108974', '685532', '24821059', '659406', '647867', '659544', '2608798', '946258', '662129', '835522', '654674')
            GROUP BY STORE_ID, STORE_NAME
            ),
            previous_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1179284', '687508', '655573', '659015', '694110', '685752', '694737', '684491', '686757', '786331', '837666', '679529', '684978', '659264', '688121', '655936', '685540', '24590418', '684476', '23000234', '686685', '687435', '786468', '24752906', '24510603', '654257', '685768', '687989', '654860', '659197', '684418', '680394', '684468', '23161795', '687137', '2108398', '694570', '1102267', '24507497', '24508148', '695044', '24821020', '655874', '2377932', '658077', '684546', '662301', '657012', '2664487', '701506', '860644', '656474', '654943', '656457', '657765', '24821039', '684918', '655954', '658837', '786462', '659888', '24202561', '946241', '662502', '694592', '654446', '655292', '647795', '685069', '1179395', '687052', '653660', '790716', '687850', '694730', '2731379', '946236', '694583', '27993089', '24507749', '2667097', '656518', '656573', '659805', '658616', '653707', '658045', '2297296', '860563', '694700', '24202476', '653727', '685073', '653877', '1011526', '659277', '655644', '680091', '695193', '1753726', '24207864', '679533', '686785', '659614', '677500', '24207837', '656284', '24575666', '694398', '2401263', '2400535', '678863', '685135', '685071', '29488956', '658610', '862451', '24409150', '659289', '24207786', '656317', '658813', '659117', '694246', '655825', '647812', '24277112', '1727364', '701236', '1102150', '23000258', '837676', '23450614', '684634', '680274', '680368', '684904', '656986', '684621', '694265', '694814', '24530672', '1544219', '653893', '680386', '684427', '684457', '677517', '2731693', '23000231', '24575626', '662305', '687543', '679532', '684545', '695172', '694578', '24507498', '837652', '694453', '2667134', '658728', '653737', '687357', '657905', '686331', '686892', '2650292', '505344', '1011529', '837641', '655305', '2444918', '678856', '686897', '24507855', '800214', '22918692', '653763', '2496264', '686788', '659572', '1170194', '656507', '653969', '687303', '695465', '694571', '1170166', '25044832', '657082', '860550', '2400648', '2496503', '2633556', '24508024', '23015273', '23450401', '24661300', '657312', '821321', '686979', '686399', '653606', '656318', '659492', '2631815', '656511', '694596', '679531', '654323', '1544237', '684472', '684443', '654732', '659199', '946269', '684559', '2667151', '659372', '22918798', '655822', '837238', '685609', '684628', '653706', '860650', '655647', '23695567', '31752210', '658130', '1286121', '680307', '684617', '679535', '684917', '657041', '695324', '695194', '25070220', '2110005', '659866', '684906', '688065', '2110096', '860640', '680392', '2732280', '1753653', '695100', '687101', '647807', '23000171', '24508284', '653819', '24408834', '24575642', '2663940', '685633', '2664004', '24408689', '786522', '647873', '24941763', '23701157', '2109065', '686392', '2110169', '657751', '657052', '659500', '1102215', '28834090', '1159715', '720447', '23000270', '837211', '837656', '659518', '659930', '696601', '656534', '680384', '23000302', '680388', '686273', '680276', '674658', '657157', '1732200', '2122176', '653528', '684455', '655934', '24590476', '31430117', '655941', '694587', '23000201', '686461', '860595', '679476', '685756', '694960', '684444', '2649668', '24202462', '2496846', '1179489', '656520', '24510688', '2400162', '655819', '695468', '655940', '2297300', '786388', '24655482', '658146', '694186', '23695622', '2399997', '2731118', '677499', '2400443', '655297', '684429', '654018', '1160043', '659641', '24122880', '656600', '786414', '659474', '694440', '1882630', '24508144', '837193', '653647', '837208', '659674', '23987538', '837189', '653618', '686933', '1102231', '655827', '680142', '2664473', '659452', '23015221', '653975', '687002', '655480', '2601637', '656282', '24752950', '946252', '657482', '23015471', '686781', '1898843', '2108974', '685532', '24821059', '659406', '647867', '659544', '2608798', '946258', '662129', '835522', '654674')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND STORE_ID IN ('1179284', '687508', '655573', '659015', '694110', '685752', '694737', '684491', '686757', '786331', '837666', '679529', '684978', '659264', '688121', '655936', '685540', '24590418', '684476', '23000234', '686685', '687435', '786468', '24752906', '24510603', '654257', '685768', '687989', '654860', '659197', '684418', '680394', '684468', '23161795', '687137', '2108398', '694570', '1102267', '24507497', '24508148', '695044', '24821020', '655874', '2377932', '658077', '684546', '662301', '657012', '2664487', '701506', '860644', '656474', '654943', '656457', '657765', '24821039', '684918', '655954', '658837', '786462', '659888', '24202561', '946241', '662502', '694592', '654446', '655292', '647795', '685069', '1179395', '687052', '653660', '790716', '687850', '694730', '2731379', '946236', '694583', '27993089', '24507749', '2667097', '656518', '656573', '659805', '658616', '653707', '658045', '2297296', '860563', '694700', '24202476', '653727', '685073', '653877', '1011526', '659277', '655644', '680091', '695193', '1753726', '24207864', '679533', '686785', '659614', '677500', '24207837', '656284', '24575666', '694398', '2401263', '2400535', '678863', '685135', '685071', '29488956', '658610', '862451', '24409150', '659289', '24207786', '656317', '658813', '659117', '694246', '655825', '647812', '24277112', '1727364', '701236', '1102150', '23000258', '837676', '23450614', '684634', '680274', '680368', '684904', '656986', '684621', '694265', '694814', '24530672', '1544219', '653893', '680386', '684427', '684457', '677517', '2731693', '23000231', '24575626', '662305', '687543', '679532', '684545', '695172', '694578', '24507498', '837652', '694453', '2667134', '658728', '653737', '687357', '657905', '686331', '686892', '2650292', '505344', '1011529', '837641', '655305', '2444918', '678856', '686897', '24507855', '800214', '22918692', '653763', '2496264', '686788', '659572', '1170194', '656507', '653969', '687303', '695465', '694571', '1170166', '25044832', '657082', '860550', '2400648', '2496503', '2633556', '24508024', '23015273', '23450401', '24661300', '657312', '821321', '686979', '686399', '653606', '656318', '659492', '2631815', '656511', '694596', '679531', '654323', '1544237', '684472', '684443', '654732', '659199', '946269', '684559', '2667151', '659372', '22918798', '655822', '837238', '685609', '684628', '653706', '860650', '655647', '23695567', '31752210', '658130', '1286121', '680307', '684617', '679535', '684917', '657041', '695324', '695194', '25070220', '2110005', '659866', '684906', '688065', '2110096', '860640', '680392', '2732280', '1753653', '695100', '687101', '647807', '23000171', '24508284', '653819', '24408834', '24575642', '2663940', '685633', '2664004', '24408689', '786522', '647873', '24941763', '23701157', '2109065', '686392', '2110169', '657751', '657052', '659500', '1102215', '28834090', '1159715', '720447', '23000270', '837211', '837656', '659518', '659930', '696601', '656534', '680384', '23000302', '680388', '686273', '680276', '674658', '657157', '1732200', '2122176', '653528', '684455', '655934', '24590476', '31430117', '655941', '694587', '23000201', '686461', '860595', '679476', '685756', '694960', '684444', '2649668', '24202462', '2496846', '1179489', '656520', '24510688', '2400162', '655819', '695468', '655940', '2297300', '786388', '24655482', '658146', '694186', '23695622', '2399997', '2731118', '677499', '2400443', '655297', '684429', '654018', '1160043', '659641', '24122880', '656600', '786414', '659474', '694440', '1882630', '24508144', '837193', '653647', '837208', '659674', '23987538', '837189', '653618', '686933', '1102231', '655827', '680142', '2664473', '659452', '23015221', '653975', '687002', '655480', '2601637', '656282', '24752950', '946252', '657482', '23015471', '686781', '1898843', '2108974', '685532', '24821059', '659406', '647867', '659544', '2608798', '946258', '662129', '835522', '654674')
            GROUP BY p.STORE_ID
            )
            SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
              COALESCE(cm.month_sales, 0) as month_sales,
              COALESCE(cm.month_orders, 0) as month_orders,
              COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
              COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
              CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
                ELSE 0
              END as wow_sales_delta_percent,
              CASE 
                WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
                ELSE 0
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-24 23:53:20

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:11

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:15

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:17

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Arc Limited Group - 2025-09-25 00:23:20

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:23:23

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:42

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:45

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:47

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Arc Limited Group - 2025-09-25 00:23:49

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:23:52

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:23:54

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- query - 2025-09-25 00:23:57

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.STORE_ID IN ('654943')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.STORE_ID IN ('654943')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.STORE_ID IN ('654943')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.STORE_ID IN ('654943')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:24:00

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:36:57

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:37:01

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:37:02
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 862a3294-0f76-41fa-b76e-ab6490686d86


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:37:02

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:37:04

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:37:05
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 91c68ab1-1586-4648-8cdc-89331519e72b


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('24207786')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:37:14

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:37:17

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:37:18
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 57ab1892-2d0e-4bbf-a0f8-bf7f626a99a1


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:37:18

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:37:20

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:37:21
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 2dd38f59-7a09-4beb-b5df-6c692ac815f7


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- Test_IS_SELF_SERVE_CAMPAIGN - 2025-09-25 00:38:09

    SELECT 
      CAMPAIGN_NAME,
      STORE_NAME,
      IS_SELF_SERVE_CAMPAIGN,
      SALES,
      ORDERS,
      ROAS,
      DATE
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
    WHERE DATE = '2025-09-21'
    LIMIT 5
    
================================================================================

-- Test_Date_Range - 2025-09-25 00:38:20

    SELECT 
      DATE,
      IS_SELF_SERVE_CAMPAIGN,
      COUNT(*) as campaign_count,
      SUM(CAST(SALES AS FLOAT64)) as total_sales
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
    WHERE DATE >= '2025-09-15' AND DATE <= '2025-09-21'
    GROUP BY DATE, IS_SELF_SERVE_CAMPAIGN
    ORDER BY DATE DESC, IS_SELF_SERVE_CAMPAIGN
    
================================================================================

-- Find_Store_With_TODC_Campaigns - 2025-09-25 00:38:36

    SELECT 
      STORE_ID,
      STORE_NAME,
      IS_SELF_SERVE_CAMPAIGN,
      COUNT(*) as campaign_count
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
    WHERE DATE = '2025-09-21' AND IS_SELF_SERVE_CAMPAIGN = 'true'
    GROUP BY STORE_ID, STORE_NAME, IS_SELF_SERVE_CAMPAIGN
    ORDER BY campaign_count DESC
    LIMIT 3
    
================================================================================

-- query - 2025-09-25 00:38:39

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:38:42

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:38:42
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: c82293bb-c80c-4a71-a210-43d5c75d5ad1


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:38:54

    SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
    FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
    
================================================================================

-- Check_Date_Range - 2025-09-25 00:38:57

        SELECT 
          DATE,
          IS_SELF_SERVE_CAMPAIGN,
          COUNT(*) as campaign_count
        FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE DATE BETWEEN '2025-09-15' AND '2025-09-21'
        GROUP BY DATE, IS_SELF_SERVE_CAMPAIGN
        ORDER BY DATE DESC
        
================================================================================

-- Check_Available_Dates - 2025-09-25 00:39:00

        SELECT 
          DATE,
          COUNT(*) as campaign_count
        FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
        WHERE DATE >= '2025-09-15'
        GROUP BY DATE
        ORDER BY DATE DESC
        LIMIT 10
        
================================================================================

-- Test_TODC_Query - 2025-09-25 00:39:13

    WITH current_period AS (
      SELECT 
        p.CAMPAIGN_NAME,
        p.STORE_NAME,
        SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
        SUM(CAST(p.ORDERS AS INT64)) as total_orders,
        AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
        COUNT(*) as campaign_days
      FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
      WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
        AND p.SALES IS NOT NULL
        AND p.SALES != 'null'
        AND p.SALES != ''
        AND p.IS_SELF_SERVE_CAMPAIGN = true
      GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
    )
    SELECT 
      c.CAMPAIGN_NAME,
      c.STORE_NAME,
      c.total_sales,
      c.total_orders,
      c.avg_roas,
      c.campaign_days
    FROM current_period c
    ORDER BY c.total_sales DESC
    LIMIT 10
    
================================================================================

-- FAILED_Test_TODC_Query - 2025-09-25 00:39:14
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:13]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:13]

Location: us-west1
Job ID: 41f36801-272f-49ac-b42b-af24d89aca84


    WITH current_period AS (
      SELECT 
        p.CAMPAIGN_NAME,
        p.STORE_NAME,
        SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
        SUM(CAST(p.ORDERS AS INT64)) as total_orders,
        AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
        COUNT(*) as campaign_days
      FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
      WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
        AND p.SALES IS NOT NULL
        AND p.SALES != 'null'
        AND p.SALES != ''
        AND p.IS_SELF_SERVE_CAMPAIGN = true
      GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
    )
    SELECT 
      c.CAMPAIGN_NAME,
      c.STORE_NAME,
      c.total_sales,
      c.total_orders,
      c.avg_roas,
      c.campaign_days
    FROM current_period c
    ORDER BY c.total_sales DESC
    LIMIT 10
    
================================================================================

-- Test_Without_SALES_Filter - 2025-09-25 00:39:27

    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      p.SALES,
      p.ORDERS,
      p.ROAS,
      p.IS_SELF_SERVE_CAMPAIGN,
      p.DATE
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
      AND p.IS_SELF_SERVE_CAMPAIGN = true
    LIMIT 5
    
================================================================================

-- FAILED_Test_Without_SALES_Filter - 2025-09-25 00:39:28
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [12:11]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [12:11]

Location: us-west1
Job ID: a809a4ef-b79b-41fa-9890-4c5d5794c42d


    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      p.SALES,
      p.ORDERS,
      p.ROAS,
      p.IS_SELF_SERVE_CAMPAIGN,
      p.DATE
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-15' AND '2025-09-21'
      AND p.IS_SELF_SERVE_CAMPAIGN = true
    LIMIT 5
    
================================================================================

-- Test_Simple_TODC_Query - 2025-09-25 00:39:37

    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      p.SALES,
      p.ORDERS,
      p.ROAS,
      p.IS_SELF_SERVE_CAMPAIGN,
      p.DATE
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE p.DATE = '2025-09-21'
      AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
    LIMIT 5
    
================================================================================

-- Test_Simple_Corporate_Query - 2025-09-25 00:39:40

    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      p.SALES,
      p.ORDERS,
      p.ROAS,
      p.IS_SELF_SERVE_CAMPAIGN,
      p.DATE
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE p.DATE = '2025-09-21'
      AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
    LIMIT 5
    
================================================================================

-- query - 2025-09-25 00:39:56

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:39:59

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:40:00
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 1b7a3d49-a223-46e2-8ab9-dbf7af35dfa7


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:40:00

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:40:03

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:40:03
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: f64a0c36-ffb9-4fa9-847b-792dfb7251ea


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE PARSE_DATE('%Y-%m-%d', p.DATE) BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:41:42

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:41:45

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:41:46
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 8d8a9574-8e64-41e6-a77d-bab9efe0fb13


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:41:46

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:41:48

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:41:48
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 4f2b136a-a531-49b2-b6d4-93d3a9c602a0


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:42:01

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:42:04

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:42:04
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 475d117f-f7aa-4791-847b-66e3b88e6fa0


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:42:04

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:42:06

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:42:07
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 292dace7-27c8-45b7-b4d5-7b8c5ad6a759


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('2631815')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- Test_Simplified_TODC_Query - 2025-09-25 00:42:20

    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
      SUM(CAST(p.ORDERS AS INT64)) as total_orders,
      AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
      COUNT(*) as campaign_days
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
      AND p.SALES IS NOT NULL
      AND p.SALES != 'null'
      AND p.SALES != ''
      AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
    GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
    ORDER BY total_sales DESC
    LIMIT 5
    
================================================================================

-- Test_Simplified_Corporate_Query - 2025-09-25 00:42:23

    SELECT 
      p.CAMPAIGN_NAME,
      p.STORE_NAME,
      SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
      SUM(CAST(p.ORDERS AS INT64)) as total_orders,
      AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
      COUNT(*) as campaign_days
    FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
    WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
      AND p.SALES IS NOT NULL
      AND p.SALES != 'null'
      AND p.SALES != ''
      AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
    GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
    ORDER BY total_sales DESC
    LIMIT 5
    
================================================================================

-- query - 2025-09-25 00:42:49

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-25 00:42:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-25 00:42:54

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-25 00:42:57

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-25 00:42:59

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:43:01

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-25 00:43:04

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_RJ Nelson Enterprise MCD - 2025-09-25 00:43:06

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Hugh O’Reilly MCD - 2025-09-25 00:43:08

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2649668', '786522', '1732200')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_SSM Inc MCD - 2025-09-25 00:43:11

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management  - 2025-09-25 00:43:13

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management / Glennhaven - 2025-09-25 00:43:16

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24507855')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_JKK Enterprises - 2025-09-25 00:43:19

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('687357', '687002', '23987538', '686331')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSC Enterprises - 2025-09-25 00:43:21

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kinney QSR - 2025-09-25 00:43:24

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('680276', '23161795', '1727364', '680274')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alpha Management  - 2025-09-25 00:43:26

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Goodman Group Restaurants - 2025-09-25 00:43:29

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clark Management  - 2025-09-25 00:43:32

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Herb's Place Inc - 2025-09-25 00:43:34

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655647', '658045')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clone & Buck - 2025-09-25 00:43:37

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kory Management - 2025-09-25 00:43:40

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Arc Limited Group - 2025-09-25 00:43:42

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSR Executive Enterprises - 2025-09-25 00:43:45

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Big Gee Ent LLC - 2025-09-25 00:43:47

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_P.R. Pernecky Management - 2025-09-25 00:43:49

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Wiseman LLC - 2025-09-25 00:43:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_West Mount 23719, LLC - 2025-09-25 00:43:54

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Ricely Group - 2025-09-25 00:43:57

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_L3 Restaurants Inc - 2025-09-25 00:43:59

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Knoth Management Group - 2025-09-25 00:44:01

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1160043', '2664004', '1159715')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_O'Keefe Family McDonald's - 2025-09-25 00:44:04

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Upchurch Management  - 2025-09-25 00:44:07

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_LAZ II, Inc - 2025-09-25 00:44:10

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Marks Management  - 2025-09-25 00:44:13

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Mao Enterprises LLC - 2025-09-25 00:44:15

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Divine Favor, LLC - 2025-09-25 00:44:17

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kipco Restaurants LLC - 2025-09-25 00:44:20

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Grayco Mgt - 2025-09-25 00:44:22

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_DMD Restaurants - 2025-09-25 00:44:25

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659930', '659289', '659492', '655874')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alamo Family LLC - 2025-09-25 00:44:27

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Bican Family Restaurants Inc - 2025-09-25 00:44:30

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655822', '655827', '655825')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- query - 2025-09-25 00:44:33

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- query - 2025-09-25 00:44:35

        WITH current_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('685073', '1732200', '786331', '658616', '24530672', '657082', '657012', '24941763', '694596', '659117', '2631815', '686781', '655934', '505344', '686331', '680142', '656518', '24661300', '24207837', '654860', '1727364', '837641', '2667151', '658837', '658728', '684468', '653647', '654018', '687303', '655480', '23000234', '23015221', '2496264', '1753653', '680394', '677500', '685633', '657905', '647873', '2444918', '24207786', '659277', '684628', '946252', '695193', '1179284', '1011526', '720447', '655297', '694398', '687508', '677517', '23701157', '2731693', '685135', '1170166', '23000171', '860563', '694186', '24508148', '647867', '24508284', '837208', '821321', '686757', '687052', '860595', '684491', '684559', '678863', '658146', '1544237', '657052', '694737', '680274', '24821020', '687137', '654323', '2400535', '1179489', '695100', '24510603', '653660', '2110005', '694578', '653737', '23015273', '2400162', '694730', '2667097', '701236', '658130', '2109065', '2122176', '2110096', '1102267', '658045', '684906', '24508024', '655954', '679529', '2664487', '2400443', '23987538', '685069', '659614', '684443', '694110', '659452', '786462', '656474', '786388', '24575626', '1882630', '2664004', '694453', '659572', '686461', '656318', '837666', '24507749', '655647', '2731118', '24821039', '27993089', '24575642', '655819', '1102215', '684457', '686979', '655644', '659930', '662129', '860650', '694246', '2108398', '684472', '24122880', '24507855', '786414', '837189', '684546', '662301', '786522', '687357', '655573', '662305', '659015', '684427', '657041', '2608798', '653877', '946236', '685540', '2377932', '23015471', '694571', '696601', '24507498', '655825', '680392', '659805', '684545', '2400648', '688121', '659289', '1159715', '23000270', '655822', '860550', '2731379', '655936', '837211', '31752210', '654257', '1102231', '2663940', '24408834', '685532', '686392', '656573', '24408689', '23450614', '679533', '659197', '800214', '25044832', '860640', '1286121', '658813', '647807', '694587', '2297296', '656600', '860644', '837652', '23695567', '679531', '654732', '946258', '659888', '23161795', '659500', '656457', '686892', '653727', '2664473', '658077', '686399', '654446', '946241', '680368', '694265', '684444', '24207864', '1170194', '1898843', '695468', '659518', '686788', '2110169', '653969', '684455', '2649668', '946269', '23000231', '653763', '695044', '686685', '659866', '684418', '680276', '837676', '679535', '24590476', '662502', '680388', '2297300', '657312', '680384', '23000302', '2633556', '837656', '656282', '24202462', '2399997', '23450401', '687543', '2650292', '656511', '24202476', '686897', '24590418', '24752950', '24510688', '2601637', '656520', '653706', '659264', '685071', '685768', '24752906', '694570', '653606', '659199', '837238', '687435', '2108974', '684904', '31430117', '655827', '647812', '686933', '694700', '1544219', '657157', '684917', '657751', '659492', '2496846', '686785', '24409150', '688065', '659474', '684978', '694440', '28834090', '659674', '684918', '687989', '25070220', '2496503', '680386', '655292', '837193', '23000201', '786468', '659544', '685752', '24655482', '653528', '2732280', '22918692', '655305', '659372', '694960', '685609', '24821059', '655874', '695324', '1160043', '694583', '686273', '29488956', '680091', '24507497', '679532', '656284', '653893', '658610', '684617', '655941', '695465', '684621', '684476', '1179395', '694814', '653707', '23695622', '657482', '656534', '695194', '2667134', '653819', '656507', '657765', '24202561', '656986', '790716', '679476', '1011529', '680307', '23000258', '687101', '656317', '678856', '674658', '677499', '685756', '654943', '684634', '694592', '22918798', '24575666', '687002', '653618', '654674', '659641', '862451', '1753726', '647795', '835522', '24277112', '653975', '24508144', '659406', '701506', '687850', '684429', '655940', '695172', '2401263', '1102150')
            GROUP BY STORE_ID, STORE_NAME
            ),
        previous_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('685073', '1732200', '786331', '658616', '24530672', '657082', '657012', '24941763', '694596', '659117', '2631815', '686781', '655934', '505344', '686331', '680142', '656518', '24661300', '24207837', '654860', '1727364', '837641', '2667151', '658837', '658728', '684468', '653647', '654018', '687303', '655480', '23000234', '23015221', '2496264', '1753653', '680394', '677500', '685633', '657905', '647873', '2444918', '24207786', '659277', '684628', '946252', '695193', '1179284', '1011526', '720447', '655297', '694398', '687508', '677517', '23701157', '2731693', '685135', '1170166', '23000171', '860563', '694186', '24508148', '647867', '24508284', '837208', '821321', '686757', '687052', '860595', '684491', '684559', '678863', '658146', '1544237', '657052', '694737', '680274', '24821020', '687137', '654323', '2400535', '1179489', '695100', '24510603', '653660', '2110005', '694578', '653737', '23015273', '2400162', '694730', '2667097', '701236', '658130', '2109065', '2122176', '2110096', '1102267', '658045', '684906', '24508024', '655954', '679529', '2664487', '2400443', '23987538', '685069', '659614', '684443', '694110', '659452', '786462', '656474', '786388', '24575626', '1882630', '2664004', '694453', '659572', '686461', '656318', '837666', '24507749', '655647', '2731118', '24821039', '27993089', '24575642', '655819', '1102215', '684457', '686979', '655644', '659930', '662129', '860650', '694246', '2108398', '684472', '24122880', '24507855', '786414', '837189', '684546', '662301', '786522', '687357', '655573', '662305', '659015', '684427', '657041', '2608798', '653877', '946236', '685540', '2377932', '23015471', '694571', '696601', '24507498', '655825', '680392', '659805', '684545', '2400648', '688121', '659289', '1159715', '23000270', '655822', '860550', '2731379', '655936', '837211', '31752210', '654257', '1102231', '2663940', '24408834', '685532', '686392', '656573', '24408689', '23450614', '679533', '659197', '800214', '25044832', '860640', '1286121', '658813', '647807', '694587', '2297296', '656600', '860644', '837652', '23695567', '679531', '654732', '946258', '659888', '23161795', '659500', '656457', '686892', '653727', '2664473', '658077', '686399', '654446', '946241', '680368', '694265', '684444', '24207864', '1170194', '1898843', '695468', '659518', '686788', '2110169', '653969', '684455', '2649668', '946269', '23000231', '653763', '695044', '686685', '659866', '684418', '680276', '837676', '679535', '24590476', '662502', '680388', '2297300', '657312', '680384', '23000302', '2633556', '837656', '656282', '24202462', '2399997', '23450401', '687543', '2650292', '656511', '24202476', '686897', '24590418', '24752950', '24510688', '2601637', '656520', '653706', '659264', '685071', '685768', '24752906', '694570', '653606', '659199', '837238', '687435', '2108974', '684904', '31430117', '655827', '647812', '686933', '694700', '1544219', '657157', '684917', '657751', '659492', '2496846', '686785', '24409150', '688065', '659474', '684978', '694440', '28834090', '659674', '684918', '687989', '25070220', '2496503', '680386', '655292', '837193', '23000201', '786468', '659544', '685752', '24655482', '653528', '2732280', '22918692', '655305', '659372', '694960', '685609', '24821059', '655874', '695324', '1160043', '694583', '686273', '29488956', '680091', '24507497', '679532', '656284', '653893', '658610', '684617', '655941', '695465', '684621', '684476', '1179395', '694814', '653707', '23695622', '657482', '656534', '695194', '2667134', '653819', '656507', '657765', '24202561', '656986', '790716', '679476', '1011529', '680307', '23000258', '687101', '656317', '678856', '674658', '677499', '685756', '654943', '684634', '694592', '22918798', '24575666', '687002', '653618', '654674', '659641', '862451', '1753726', '647795', '835522', '24277112', '653975', '24508144', '659406', '701506', '687850', '684429', '655940', '695172', '2401263', '1102150')
            GROUP BY STORE_ID, STORE_NAME
            ),
            current_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('685073', '1732200', '786331', '658616', '24530672', '657082', '657012', '24941763', '694596', '659117', '2631815', '686781', '655934', '505344', '686331', '680142', '656518', '24661300', '24207837', '654860', '1727364', '837641', '2667151', '658837', '658728', '684468', '653647', '654018', '687303', '655480', '23000234', '23015221', '2496264', '1753653', '680394', '677500', '685633', '657905', '647873', '2444918', '24207786', '659277', '684628', '946252', '695193', '1179284', '1011526', '720447', '655297', '694398', '687508', '677517', '23701157', '2731693', '685135', '1170166', '23000171', '860563', '694186', '24508148', '647867', '24508284', '837208', '821321', '686757', '687052', '860595', '684491', '684559', '678863', '658146', '1544237', '657052', '694737', '680274', '24821020', '687137', '654323', '2400535', '1179489', '695100', '24510603', '653660', '2110005', '694578', '653737', '23015273', '2400162', '694730', '2667097', '701236', '658130', '2109065', '2122176', '2110096', '1102267', '658045', '684906', '24508024', '655954', '679529', '2664487', '2400443', '23987538', '685069', '659614', '684443', '694110', '659452', '786462', '656474', '786388', '24575626', '1882630', '2664004', '694453', '659572', '686461', '656318', '837666', '24507749', '655647', '2731118', '24821039', '27993089', '24575642', '655819', '1102215', '684457', '686979', '655644', '659930', '662129', '860650', '694246', '2108398', '684472', '24122880', '24507855', '786414', '837189', '684546', '662301', '786522', '687357', '655573', '662305', '659015', '684427', '657041', '2608798', '653877', '946236', '685540', '2377932', '23015471', '694571', '696601', '24507498', '655825', '680392', '659805', '684545', '2400648', '688121', '659289', '1159715', '23000270', '655822', '860550', '2731379', '655936', '837211', '31752210', '654257', '1102231', '2663940', '24408834', '685532', '686392', '656573', '24408689', '23450614', '679533', '659197', '800214', '25044832', '860640', '1286121', '658813', '647807', '694587', '2297296', '656600', '860644', '837652', '23695567', '679531', '654732', '946258', '659888', '23161795', '659500', '656457', '686892', '653727', '2664473', '658077', '686399', '654446', '946241', '680368', '694265', '684444', '24207864', '1170194', '1898843', '695468', '659518', '686788', '2110169', '653969', '684455', '2649668', '946269', '23000231', '653763', '695044', '686685', '659866', '684418', '680276', '837676', '679535', '24590476', '662502', '680388', '2297300', '657312', '680384', '23000302', '2633556', '837656', '656282', '24202462', '2399997', '23450401', '687543', '2650292', '656511', '24202476', '686897', '24590418', '24752950', '24510688', '2601637', '656520', '653706', '659264', '685071', '685768', '24752906', '694570', '653606', '659199', '837238', '687435', '2108974', '684904', '31430117', '655827', '647812', '686933', '694700', '1544219', '657157', '684917', '657751', '659492', '2496846', '686785', '24409150', '688065', '659474', '684978', '694440', '28834090', '659674', '684918', '687989', '25070220', '2496503', '680386', '655292', '837193', '23000201', '786468', '659544', '685752', '24655482', '653528', '2732280', '22918692', '655305', '659372', '694960', '685609', '24821059', '655874', '695324', '1160043', '694583', '686273', '29488956', '680091', '24507497', '679532', '656284', '653893', '658610', '684617', '655941', '695465', '684621', '684476', '1179395', '694814', '653707', '23695622', '657482', '656534', '695194', '2667134', '653819', '656507', '657765', '24202561', '656986', '790716', '679476', '1011529', '680307', '23000258', '687101', '656317', '678856', '674658', '677499', '685756', '654943', '684634', '694592', '22918798', '24575666', '687002', '653618', '654674', '659641', '862451', '1753726', '647795', '835522', '24277112', '653975', '24508144', '659406', '701506', '687850', '684429', '655940', '695172', '2401263', '1102150')
            GROUP BY STORE_ID, STORE_NAME
            ),
            previous_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('685073', '1732200', '786331', '658616', '24530672', '657082', '657012', '24941763', '694596', '659117', '2631815', '686781', '655934', '505344', '686331', '680142', '656518', '24661300', '24207837', '654860', '1727364', '837641', '2667151', '658837', '658728', '684468', '653647', '654018', '687303', '655480', '23000234', '23015221', '2496264', '1753653', '680394', '677500', '685633', '657905', '647873', '2444918', '24207786', '659277', '684628', '946252', '695193', '1179284', '1011526', '720447', '655297', '694398', '687508', '677517', '23701157', '2731693', '685135', '1170166', '23000171', '860563', '694186', '24508148', '647867', '24508284', '837208', '821321', '686757', '687052', '860595', '684491', '684559', '678863', '658146', '1544237', '657052', '694737', '680274', '24821020', '687137', '654323', '2400535', '1179489', '695100', '24510603', '653660', '2110005', '694578', '653737', '23015273', '2400162', '694730', '2667097', '701236', '658130', '2109065', '2122176', '2110096', '1102267', '658045', '684906', '24508024', '655954', '679529', '2664487', '2400443', '23987538', '685069', '659614', '684443', '694110', '659452', '786462', '656474', '786388', '24575626', '1882630', '2664004', '694453', '659572', '686461', '656318', '837666', '24507749', '655647', '2731118', '24821039', '27993089', '24575642', '655819', '1102215', '684457', '686979', '655644', '659930', '662129', '860650', '694246', '2108398', '684472', '24122880', '24507855', '786414', '837189', '684546', '662301', '786522', '687357', '655573', '662305', '659015', '684427', '657041', '2608798', '653877', '946236', '685540', '2377932', '23015471', '694571', '696601', '24507498', '655825', '680392', '659805', '684545', '2400648', '688121', '659289', '1159715', '23000270', '655822', '860550', '2731379', '655936', '837211', '31752210', '654257', '1102231', '2663940', '24408834', '685532', '686392', '656573', '24408689', '23450614', '679533', '659197', '800214', '25044832', '860640', '1286121', '658813', '647807', '694587', '2297296', '656600', '860644', '837652', '23695567', '679531', '654732', '946258', '659888', '23161795', '659500', '656457', '686892', '653727', '2664473', '658077', '686399', '654446', '946241', '680368', '694265', '684444', '24207864', '1170194', '1898843', '695468', '659518', '686788', '2110169', '653969', '684455', '2649668', '946269', '23000231', '653763', '695044', '686685', '659866', '684418', '680276', '837676', '679535', '24590476', '662502', '680388', '2297300', '657312', '680384', '23000302', '2633556', '837656', '656282', '24202462', '2399997', '23450401', '687543', '2650292', '656511', '24202476', '686897', '24590418', '24752950', '24510688', '2601637', '656520', '653706', '659264', '685071', '685768', '24752906', '694570', '653606', '659199', '837238', '687435', '2108974', '684904', '31430117', '655827', '647812', '686933', '694700', '1544219', '657157', '684917', '657751', '659492', '2496846', '686785', '24409150', '688065', '659474', '684978', '694440', '28834090', '659674', '684918', '687989', '25070220', '2496503', '680386', '655292', '837193', '23000201', '786468', '659544', '685752', '24655482', '653528', '2732280', '22918692', '655305', '659372', '694960', '685609', '24821059', '655874', '695324', '1160043', '694583', '686273', '29488956', '680091', '24507497', '679532', '656284', '653893', '658610', '684617', '655941', '695465', '684621', '684476', '1179395', '694814', '653707', '23695622', '657482', '656534', '695194', '2667134', '653819', '656507', '657765', '24202561', '656986', '790716', '679476', '1011529', '680307', '23000258', '687101', '656317', '678856', '674658', '677499', '685756', '654943', '684634', '694592', '22918798', '24575666', '687002', '653618', '654674', '659641', '862451', '1753726', '647795', '835522', '24277112', '653975', '24508144', '659406', '701506', '687850', '684429', '655940', '695172', '2401263', '1102150')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND STORE_ID IN ('685073', '1732200', '786331', '658616', '24530672', '657082', '657012', '24941763', '694596', '659117', '2631815', '686781', '655934', '505344', '686331', '680142', '656518', '24661300', '24207837', '654860', '1727364', '837641', '2667151', '658837', '658728', '684468', '653647', '654018', '687303', '655480', '23000234', '23015221', '2496264', '1753653', '680394', '677500', '685633', '657905', '647873', '2444918', '24207786', '659277', '684628', '946252', '695193', '1179284', '1011526', '720447', '655297', '694398', '687508', '677517', '23701157', '2731693', '685135', '1170166', '23000171', '860563', '694186', '24508148', '647867', '24508284', '837208', '821321', '686757', '687052', '860595', '684491', '684559', '678863', '658146', '1544237', '657052', '694737', '680274', '24821020', '687137', '654323', '2400535', '1179489', '695100', '24510603', '653660', '2110005', '694578', '653737', '23015273', '2400162', '694730', '2667097', '701236', '658130', '2109065', '2122176', '2110096', '1102267', '658045', '684906', '24508024', '655954', '679529', '2664487', '2400443', '23987538', '685069', '659614', '684443', '694110', '659452', '786462', '656474', '786388', '24575626', '1882630', '2664004', '694453', '659572', '686461', '656318', '837666', '24507749', '655647', '2731118', '24821039', '27993089', '24575642', '655819', '1102215', '684457', '686979', '655644', '659930', '662129', '860650', '694246', '2108398', '684472', '24122880', '24507855', '786414', '837189', '684546', '662301', '786522', '687357', '655573', '662305', '659015', '684427', '657041', '2608798', '653877', '946236', '685540', '2377932', '23015471', '694571', '696601', '24507498', '655825', '680392', '659805', '684545', '2400648', '688121', '659289', '1159715', '23000270', '655822', '860550', '2731379', '655936', '837211', '31752210', '654257', '1102231', '2663940', '24408834', '685532', '686392', '656573', '24408689', '23450614', '679533', '659197', '800214', '25044832', '860640', '1286121', '658813', '647807', '694587', '2297296', '656600', '860644', '837652', '23695567', '679531', '654732', '946258', '659888', '23161795', '659500', '656457', '686892', '653727', '2664473', '658077', '686399', '654446', '946241', '680368', '694265', '684444', '24207864', '1170194', '1898843', '695468', '659518', '686788', '2110169', '653969', '684455', '2649668', '946269', '23000231', '653763', '695044', '686685', '659866', '684418', '680276', '837676', '679535', '24590476', '662502', '680388', '2297300', '657312', '680384', '23000302', '2633556', '837656', '656282', '24202462', '2399997', '23450401', '687543', '2650292', '656511', '24202476', '686897', '24590418', '24752950', '24510688', '2601637', '656520', '653706', '659264', '685071', '685768', '24752906', '694570', '653606', '659199', '837238', '687435', '2108974', '684904', '31430117', '655827', '647812', '686933', '694700', '1544219', '657157', '684917', '657751', '659492', '2496846', '686785', '24409150', '688065', '659474', '684978', '694440', '28834090', '659674', '684918', '687989', '25070220', '2496503', '680386', '655292', '837193', '23000201', '786468', '659544', '685752', '24655482', '653528', '2732280', '22918692', '655305', '659372', '694960', '685609', '24821059', '655874', '695324', '1160043', '694583', '686273', '29488956', '680091', '24507497', '679532', '656284', '653893', '658610', '684617', '655941', '695465', '684621', '684476', '1179395', '694814', '653707', '23695622', '657482', '656534', '695194', '2667134', '653819', '656507', '657765', '24202561', '656986', '790716', '679476', '1011529', '680307', '23000258', '687101', '656317', '678856', '674658', '677499', '685756', '654943', '684634', '694592', '22918798', '24575666', '687002', '653618', '654674', '659641', '862451', '1753726', '647795', '835522', '24277112', '653975', '24508144', '659406', '701506', '687850', '684429', '655940', '695172', '2401263', '1102150')
            GROUP BY p.STORE_ID
            )
            SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
              COALESCE(cm.month_sales, 0) as month_sales,
              COALESCE(cm.month_orders, 0) as month_orders,
              COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
              COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
              CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
                ELSE 0
              END as wow_sales_delta_percent,
              CASE 
                WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
                ELSE 0
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:44:38

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:44:49

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:44:52

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:44:54

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Big Gee Ent LLC - 2025-09-25 00:44:57

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:44:59

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:14

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:17

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:20

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Big Gee Ent LLC - 2025-09-25 00:46:22

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:46:25

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:35

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:38

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:41

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Big Gee Ent LLC - 2025-09-25 00:46:43

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:46:46

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:46:48

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:46:50

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_TODC_Campaigns - 2025-09-25 00:46:51
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 63e3d962-3539-43f3-b622-c710f3c7661a


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = true
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:46:51

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:46:53

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- FAILED_Corporate_Campaigns - 2025-09-25 00:46:54
-- FAILED QUERY: 400 No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]; reason: invalidQuery, location: query, message: No matching signature for operator = for argument types: STRING, BOOL
  Signature: T1 = T1
    Unable to find common supertype for templated argument <T1>
      Input types for <T1>: {BOOL, STRING} at [15:17]

Location: us-west1
Job ID: 5d1fb956-847c-4718-b0e4-eca7769395f9


        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = false
            AND p.STORE_ID IN ('946252')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:46:54

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:52:59

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:53:03

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:53:05

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:53:08

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:53:36

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-25 00:53:39

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-25 00:53:41

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-25 00:53:43

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-25 00:53:46

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:53:49

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-25 00:53:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_RJ Nelson Enterprise MCD - 2025-09-25 00:53:54

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Hugh O’Reilly MCD - 2025-09-25 00:53:57

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2649668', '786522', '1732200')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_SSM Inc MCD - 2025-09-25 00:53:59

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management  - 2025-09-25 00:54:02

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Third Gen Management / Glennhaven - 2025-09-25 00:54:05

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24507855')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24507855')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_JKK Enterprises - 2025-09-25 00:54:07

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('687357', '687002', '23987538', '686331')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSC Enterprises - 2025-09-25 00:54:10

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kinney QSR - 2025-09-25 00:54:12

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('680276', '23161795', '1727364', '680274')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alpha Management  - 2025-09-25 00:54:15

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Goodman Group Restaurants - 2025-09-25 00:54:17

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clark Management  - 2025-09-25 00:54:20

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Herb's Place Inc - 2025-09-25 00:54:22

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655647', '658045')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655647', '658045')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Clone & Buck - 2025-09-25 00:54:25

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kory Management - 2025-09-25 00:54:27

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Arc Limited Group - 2025-09-25 00:54:29

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_QSR Executive Enterprises - 2025-09-25 00:54:32

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Big Gee Ent LLC - 2025-09-25 00:54:34

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_P.R. Pernecky Management - 2025-09-25 00:54:37

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Wiseman LLC - 2025-09-25 00:54:39

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_West Mount 23719, LLC - 2025-09-25 00:54:42

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Ricely Group - 2025-09-25 00:54:44

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_L3 Restaurants Inc - 2025-09-25 00:54:46

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Knoth Management Group - 2025-09-25 00:54:49

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('1160043', '2664004', '1159715')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_O'Keefe Family McDonald's - 2025-09-25 00:54:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Upchurch Management  - 2025-09-25 00:54:54

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_LAZ II, Inc - 2025-09-25 00:54:56

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Marks Management  - 2025-09-25 00:54:58

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Mao Enterprises LLC - 2025-09-25 00:55:01

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Divine Favor, LLC - 2025-09-25 00:55:04

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Kipco Restaurants LLC - 2025-09-25 00:55:06

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Grayco Mgt - 2025-09-25 00:55:08

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_DMD Restaurants - 2025-09-25 00:55:11

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('659930', '659289', '659492', '655874')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Alamo Family LLC - 2025-09-25 00:55:13

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- Operator_Bican Family Restaurants Inc - 2025-09-25 00:55:15

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        avg_roas AS (
            SELECT 
                AVG(CAST(ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE PARSE_DATE('%Y-%m-%d', p.DATE) = '2025-09-21'
                AND p.STORE_ID IN ('655822', '655827', '655825')
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
        )
        SELECT 
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            pw.prev_sales,
            pw.prev_orders,
            cm.month_sales,
            cm.month_orders,
            pm.prev_month_sales,
            pm.prev_month_orders,
            CASE 
                WHEN pw.prev_sales > 0 THEN ((cw.total_sales - pw.prev_sales) / pw.prev_sales) * 100
            ELSE 0 
              END as wow_sales_delta_percent,
          CASE 
                WHEN pm.prev_month_sales > 0 THEN ((cm.month_sales - pm.prev_month_sales) / pm.prev_month_sales) * 100
            ELSE 0 
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON 1=1
            LEFT JOIN current_month cm ON 1=1
            LEFT JOIN previous_month pm ON 1=1
        LEFT JOIN avg_roas ar ON 1=1
        
================================================================================

-- query - 2025-09-25 00:55:17

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- query - 2025-09-25 00:55:20

        WITH current_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24752950', '24408689', '653893', '837676', '659866', '31752210', '655297', '2496503', '23987538', '684455', '24752906', '686392', '658837', '1179284', '2444918', '24202462', '837193', '659572', '687002', '24207786', '694960', '653975', '2667151', '684418', '694814', '686979', '679531', '654323', '680274', '653727', '686757', '2663940', '1102150', '837208', '684476', '654943', '657765', '647867', '1102215', '678856', '23000201', '686892', '694186', '684468', '686331', '695465', '1102231', '837666', '659930', '647795', '946258', '720447', '23000258', '695100', '1882630', '23450614', '659492', '677517', '24207837', '659474', '2664004', '655573', '659641', '685609', '1179395', '658616', '695324', '946252', '2400162', '647807', '2108398', '685768', '23701157', '24408834', '687137', '837238', '2400443', '680142', '2650292', '684617', '821321', '946241', '654446', '655819', '1011529', '653737', '23161795', '685633', '2377932', '2731693', '659015', '694587', '694583', '654732', '2109065', '696601', '684918', '687052', '684444', '684978', '1727364', '684546', '837641', '24508148', '2631815', '837656', '655822', '2731118', '687303', '658045', '694453', '786414', '23015471', '653707', '686461', '659888', '655874', '24821039', '23695567', '654860', '656534', '24590476', '684472', '25044832', '1159715', '860550', '658130', '655644', '655827', '2496846', '687989', '2110096', '860644', '24575642', '680394', '687101', '686788', '684491', '654257', '862451', '656457', '684457', '686897', '24277112', '659805', '659500', '674658', '701236', '688065', '659199', '24590418', '659289', '24821020', '685532', '686399', '684628', '694246', '28834090', '656518', '685540', '24530672', '24207864', '24507855', '653763', '684427', '1732200', '24508024', '679533', '1011526', '686685', '656282', '24941763', '23000171', '837652', '1170194', '657012', '680386', '687357', '684429', '946269', '23695622', '1170166', '684634', '694700', '2400535', '860563', '695194', '658813', '647873', '2601637', '23000234', '654674', '23015273', '685073', '647812', '23000270', '2108974', '701506', '659614', '2297300', '695468', '2667134', '786522', '659117', '2732280', '24510688', '2667097', '790716', '655940', '658610', '677499', '687435', '860650', '24507497', '655647', '680384', '24409150', '505344', '2297296', '656284', '680091', '2731379', '659372', '694398', '24661300', '24575626', '27993089', '655934', '23450401', '31430117', '786331', '860595', '656520', '662305', '694110', '694737', '687508', '654018', '653969', '657052', '685071', '653877', '684906', '684559', '655941', '688121', '2400648', '656317', '657905', '2664473', '656600', '685135', '659197', '694265', '662502', '25070220', '946236', '694570', '662301', '2110169', '659406', '659277', '684443', '657312', '22918798', '653528', '686781', '655480', '1753653', '2122176', '24507749', '24122880', '685752', '695172', '684917', '662129', '680307', '658728', '684904', '694596', '694571', '656573', '686273', '684621', '659264', '837189', '653618', '657082', '679529', '653606', '860640', '659674', '23000302', '2110005', '653706', '2399997', '24655482', '1753726', '837211', '2401263', '2664487', '695193', '694440', '24575666', '1544219', '678863', '1102267', '657751', '679532', '658077', '659452', '659518', '656318', '656474', '695044', '680388', '24202476', '655305', '1544237', '656986', '24508144', '658146', '653647', '1898843', '1160043', '679535', '786462', '656507', '655936', '29488956', '655825', '659544', '657157', '684545', '2496264', '23000231', '23015221', '680276', '686933', '694592', '24202561', '22918692', '687850', '677500', '680368', '653819', '686785', '680392', '800214', '657041', '1179489', '685069', '2633556', '694730', '24510603', '687543', '657482', '24821059', '653660', '2608798', '1286121', '655954', '786468', '835522', '24507498', '655292', '24508284', '694578', '679476', '656511', '685756', '2649668', '786388')
            GROUP BY STORE_ID, STORE_NAME
            ),
        previous_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24752950', '24408689', '653893', '837676', '659866', '31752210', '655297', '2496503', '23987538', '684455', '24752906', '686392', '658837', '1179284', '2444918', '24202462', '837193', '659572', '687002', '24207786', '694960', '653975', '2667151', '684418', '694814', '686979', '679531', '654323', '680274', '653727', '686757', '2663940', '1102150', '837208', '684476', '654943', '657765', '647867', '1102215', '678856', '23000201', '686892', '694186', '684468', '686331', '695465', '1102231', '837666', '659930', '647795', '946258', '720447', '23000258', '695100', '1882630', '23450614', '659492', '677517', '24207837', '659474', '2664004', '655573', '659641', '685609', '1179395', '658616', '695324', '946252', '2400162', '647807', '2108398', '685768', '23701157', '24408834', '687137', '837238', '2400443', '680142', '2650292', '684617', '821321', '946241', '654446', '655819', '1011529', '653737', '23161795', '685633', '2377932', '2731693', '659015', '694587', '694583', '654732', '2109065', '696601', '684918', '687052', '684444', '684978', '1727364', '684546', '837641', '24508148', '2631815', '837656', '655822', '2731118', '687303', '658045', '694453', '786414', '23015471', '653707', '686461', '659888', '655874', '24821039', '23695567', '654860', '656534', '24590476', '684472', '25044832', '1159715', '860550', '658130', '655644', '655827', '2496846', '687989', '2110096', '860644', '24575642', '680394', '687101', '686788', '684491', '654257', '862451', '656457', '684457', '686897', '24277112', '659805', '659500', '674658', '701236', '688065', '659199', '24590418', '659289', '24821020', '685532', '686399', '684628', '694246', '28834090', '656518', '685540', '24530672', '24207864', '24507855', '653763', '684427', '1732200', '24508024', '679533', '1011526', '686685', '656282', '24941763', '23000171', '837652', '1170194', '657012', '680386', '687357', '684429', '946269', '23695622', '1170166', '684634', '694700', '2400535', '860563', '695194', '658813', '647873', '2601637', '23000234', '654674', '23015273', '685073', '647812', '23000270', '2108974', '701506', '659614', '2297300', '695468', '2667134', '786522', '659117', '2732280', '24510688', '2667097', '790716', '655940', '658610', '677499', '687435', '860650', '24507497', '655647', '680384', '24409150', '505344', '2297296', '656284', '680091', '2731379', '659372', '694398', '24661300', '24575626', '27993089', '655934', '23450401', '31430117', '786331', '860595', '656520', '662305', '694110', '694737', '687508', '654018', '653969', '657052', '685071', '653877', '684906', '684559', '655941', '688121', '2400648', '656317', '657905', '2664473', '656600', '685135', '659197', '694265', '662502', '25070220', '946236', '694570', '662301', '2110169', '659406', '659277', '684443', '657312', '22918798', '653528', '686781', '655480', '1753653', '2122176', '24507749', '24122880', '685752', '695172', '684917', '662129', '680307', '658728', '684904', '694596', '694571', '656573', '686273', '684621', '659264', '837189', '653618', '657082', '679529', '653606', '860640', '659674', '23000302', '2110005', '653706', '2399997', '24655482', '1753726', '837211', '2401263', '2664487', '695193', '694440', '24575666', '1544219', '678863', '1102267', '657751', '679532', '658077', '659452', '659518', '656318', '656474', '695044', '680388', '24202476', '655305', '1544237', '656986', '24508144', '658146', '653647', '1898843', '1160043', '679535', '786462', '656507', '655936', '29488956', '655825', '659544', '657157', '684545', '2496264', '23000231', '23015221', '680276', '686933', '694592', '24202561', '22918692', '687850', '677500', '680368', '653819', '686785', '680392', '800214', '657041', '1179489', '685069', '2633556', '694730', '24510603', '687543', '657482', '24821059', '653660', '2608798', '1286121', '655954', '786468', '835522', '24507498', '655292', '24508284', '694578', '679476', '656511', '685756', '2649668', '786388')
            GROUP BY STORE_ID, STORE_NAME
            ),
            current_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24752950', '24408689', '653893', '837676', '659866', '31752210', '655297', '2496503', '23987538', '684455', '24752906', '686392', '658837', '1179284', '2444918', '24202462', '837193', '659572', '687002', '24207786', '694960', '653975', '2667151', '684418', '694814', '686979', '679531', '654323', '680274', '653727', '686757', '2663940', '1102150', '837208', '684476', '654943', '657765', '647867', '1102215', '678856', '23000201', '686892', '694186', '684468', '686331', '695465', '1102231', '837666', '659930', '647795', '946258', '720447', '23000258', '695100', '1882630', '23450614', '659492', '677517', '24207837', '659474', '2664004', '655573', '659641', '685609', '1179395', '658616', '695324', '946252', '2400162', '647807', '2108398', '685768', '23701157', '24408834', '687137', '837238', '2400443', '680142', '2650292', '684617', '821321', '946241', '654446', '655819', '1011529', '653737', '23161795', '685633', '2377932', '2731693', '659015', '694587', '694583', '654732', '2109065', '696601', '684918', '687052', '684444', '684978', '1727364', '684546', '837641', '24508148', '2631815', '837656', '655822', '2731118', '687303', '658045', '694453', '786414', '23015471', '653707', '686461', '659888', '655874', '24821039', '23695567', '654860', '656534', '24590476', '684472', '25044832', '1159715', '860550', '658130', '655644', '655827', '2496846', '687989', '2110096', '860644', '24575642', '680394', '687101', '686788', '684491', '654257', '862451', '656457', '684457', '686897', '24277112', '659805', '659500', '674658', '701236', '688065', '659199', '24590418', '659289', '24821020', '685532', '686399', '684628', '694246', '28834090', '656518', '685540', '24530672', '24207864', '24507855', '653763', '684427', '1732200', '24508024', '679533', '1011526', '686685', '656282', '24941763', '23000171', '837652', '1170194', '657012', '680386', '687357', '684429', '946269', '23695622', '1170166', '684634', '694700', '2400535', '860563', '695194', '658813', '647873', '2601637', '23000234', '654674', '23015273', '685073', '647812', '23000270', '2108974', '701506', '659614', '2297300', '695468', '2667134', '786522', '659117', '2732280', '24510688', '2667097', '790716', '655940', '658610', '677499', '687435', '860650', '24507497', '655647', '680384', '24409150', '505344', '2297296', '656284', '680091', '2731379', '659372', '694398', '24661300', '24575626', '27993089', '655934', '23450401', '31430117', '786331', '860595', '656520', '662305', '694110', '694737', '687508', '654018', '653969', '657052', '685071', '653877', '684906', '684559', '655941', '688121', '2400648', '656317', '657905', '2664473', '656600', '685135', '659197', '694265', '662502', '25070220', '946236', '694570', '662301', '2110169', '659406', '659277', '684443', '657312', '22918798', '653528', '686781', '655480', '1753653', '2122176', '24507749', '24122880', '685752', '695172', '684917', '662129', '680307', '658728', '684904', '694596', '694571', '656573', '686273', '684621', '659264', '837189', '653618', '657082', '679529', '653606', '860640', '659674', '23000302', '2110005', '653706', '2399997', '24655482', '1753726', '837211', '2401263', '2664487', '695193', '694440', '24575666', '1544219', '678863', '1102267', '657751', '679532', '658077', '659452', '659518', '656318', '656474', '695044', '680388', '24202476', '655305', '1544237', '656986', '24508144', '658146', '653647', '1898843', '1160043', '679535', '786462', '656507', '655936', '29488956', '655825', '659544', '657157', '684545', '2496264', '23000231', '23015221', '680276', '686933', '694592', '24202561', '22918692', '687850', '677500', '680368', '653819', '686785', '680392', '800214', '657041', '1179489', '685069', '2633556', '694730', '24510603', '687543', '657482', '24821059', '653660', '2608798', '1286121', '655954', '786468', '835522', '24507498', '655292', '24508284', '694578', '679476', '656511', '685756', '2649668', '786388')
            GROUP BY STORE_ID, STORE_NAME
            ),
            previous_month AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND STORE_ID IN ('24752950', '24408689', '653893', '837676', '659866', '31752210', '655297', '2496503', '23987538', '684455', '24752906', '686392', '658837', '1179284', '2444918', '24202462', '837193', '659572', '687002', '24207786', '694960', '653975', '2667151', '684418', '694814', '686979', '679531', '654323', '680274', '653727', '686757', '2663940', '1102150', '837208', '684476', '654943', '657765', '647867', '1102215', '678856', '23000201', '686892', '694186', '684468', '686331', '695465', '1102231', '837666', '659930', '647795', '946258', '720447', '23000258', '695100', '1882630', '23450614', '659492', '677517', '24207837', '659474', '2664004', '655573', '659641', '685609', '1179395', '658616', '695324', '946252', '2400162', '647807', '2108398', '685768', '23701157', '24408834', '687137', '837238', '2400443', '680142', '2650292', '684617', '821321', '946241', '654446', '655819', '1011529', '653737', '23161795', '685633', '2377932', '2731693', '659015', '694587', '694583', '654732', '2109065', '696601', '684918', '687052', '684444', '684978', '1727364', '684546', '837641', '24508148', '2631815', '837656', '655822', '2731118', '687303', '658045', '694453', '786414', '23015471', '653707', '686461', '659888', '655874', '24821039', '23695567', '654860', '656534', '24590476', '684472', '25044832', '1159715', '860550', '658130', '655644', '655827', '2496846', '687989', '2110096', '860644', '24575642', '680394', '687101', '686788', '684491', '654257', '862451', '656457', '684457', '686897', '24277112', '659805', '659500', '674658', '701236', '688065', '659199', '24590418', '659289', '24821020', '685532', '686399', '684628', '694246', '28834090', '656518', '685540', '24530672', '24207864', '24507855', '653763', '684427', '1732200', '24508024', '679533', '1011526', '686685', '656282', '24941763', '23000171', '837652', '1170194', '657012', '680386', '687357', '684429', '946269', '23695622', '1170166', '684634', '694700', '2400535', '860563', '695194', '658813', '647873', '2601637', '23000234', '654674', '23015273', '685073', '647812', '23000270', '2108974', '701506', '659614', '2297300', '695468', '2667134', '786522', '659117', '2732280', '24510688', '2667097', '790716', '655940', '658610', '677499', '687435', '860650', '24507497', '655647', '680384', '24409150', '505344', '2297296', '656284', '680091', '2731379', '659372', '694398', '24661300', '24575626', '27993089', '655934', '23450401', '31430117', '786331', '860595', '656520', '662305', '694110', '694737', '687508', '654018', '653969', '657052', '685071', '653877', '684906', '684559', '655941', '688121', '2400648', '656317', '657905', '2664473', '656600', '685135', '659197', '694265', '662502', '25070220', '946236', '694570', '662301', '2110169', '659406', '659277', '684443', '657312', '22918798', '653528', '686781', '655480', '1753653', '2122176', '24507749', '24122880', '685752', '695172', '684917', '662129', '680307', '658728', '684904', '694596', '694571', '656573', '686273', '684621', '659264', '837189', '653618', '657082', '679529', '653606', '860640', '659674', '23000302', '2110005', '653706', '2399997', '24655482', '1753726', '837211', '2401263', '2664487', '695193', '694440', '24575666', '1544219', '678863', '1102267', '657751', '679532', '658077', '659452', '659518', '656318', '656474', '695044', '680388', '24202476', '655305', '1544237', '656986', '24508144', '658146', '653647', '1898843', '1160043', '679535', '786462', '656507', '655936', '29488956', '655825', '659544', '657157', '684545', '2496264', '23000231', '23015221', '680276', '686933', '694592', '24202561', '22918692', '687850', '677500', '680368', '653819', '686785', '680392', '800214', '657041', '1179489', '685069', '2633556', '694730', '24510603', '687543', '657482', '24821059', '653660', '2608798', '1286121', '655954', '786468', '835522', '24507498', '655292', '24508284', '694578', '679476', '656511', '685756', '2649668', '786388')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND STORE_ID IN ('24752950', '24408689', '653893', '837676', '659866', '31752210', '655297', '2496503', '23987538', '684455', '24752906', '686392', '658837', '1179284', '2444918', '24202462', '837193', '659572', '687002', '24207786', '694960', '653975', '2667151', '684418', '694814', '686979', '679531', '654323', '680274', '653727', '686757', '2663940', '1102150', '837208', '684476', '654943', '657765', '647867', '1102215', '678856', '23000201', '686892', '694186', '684468', '686331', '695465', '1102231', '837666', '659930', '647795', '946258', '720447', '23000258', '695100', '1882630', '23450614', '659492', '677517', '24207837', '659474', '2664004', '655573', '659641', '685609', '1179395', '658616', '695324', '946252', '2400162', '647807', '2108398', '685768', '23701157', '24408834', '687137', '837238', '2400443', '680142', '2650292', '684617', '821321', '946241', '654446', '655819', '1011529', '653737', '23161795', '685633', '2377932', '2731693', '659015', '694587', '694583', '654732', '2109065', '696601', '684918', '687052', '684444', '684978', '1727364', '684546', '837641', '24508148', '2631815', '837656', '655822', '2731118', '687303', '658045', '694453', '786414', '23015471', '653707', '686461', '659888', '655874', '24821039', '23695567', '654860', '656534', '24590476', '684472', '25044832', '1159715', '860550', '658130', '655644', '655827', '2496846', '687989', '2110096', '860644', '24575642', '680394', '687101', '686788', '684491', '654257', '862451', '656457', '684457', '686897', '24277112', '659805', '659500', '674658', '701236', '688065', '659199', '24590418', '659289', '24821020', '685532', '686399', '684628', '694246', '28834090', '656518', '685540', '24530672', '24207864', '24507855', '653763', '684427', '1732200', '24508024', '679533', '1011526', '686685', '656282', '24941763', '23000171', '837652', '1170194', '657012', '680386', '687357', '684429', '946269', '23695622', '1170166', '684634', '694700', '2400535', '860563', '695194', '658813', '647873', '2601637', '23000234', '654674', '23015273', '685073', '647812', '23000270', '2108974', '701506', '659614', '2297300', '695468', '2667134', '786522', '659117', '2732280', '24510688', '2667097', '790716', '655940', '658610', '677499', '687435', '860650', '24507497', '655647', '680384', '24409150', '505344', '2297296', '656284', '680091', '2731379', '659372', '694398', '24661300', '24575626', '27993089', '655934', '23450401', '31430117', '786331', '860595', '656520', '662305', '694110', '694737', '687508', '654018', '653969', '657052', '685071', '653877', '684906', '684559', '655941', '688121', '2400648', '656317', '657905', '2664473', '656600', '685135', '659197', '694265', '662502', '25070220', '946236', '694570', '662301', '2110169', '659406', '659277', '684443', '657312', '22918798', '653528', '686781', '655480', '1753653', '2122176', '24507749', '24122880', '685752', '695172', '684917', '662129', '680307', '658728', '684904', '694596', '694571', '656573', '686273', '684621', '659264', '837189', '653618', '657082', '679529', '653606', '860640', '659674', '23000302', '2110005', '653706', '2399997', '24655482', '1753726', '837211', '2401263', '2664487', '695193', '694440', '24575666', '1544219', '678863', '1102267', '657751', '679532', '658077', '659452', '659518', '656318', '656474', '695044', '680388', '24202476', '655305', '1544237', '656986', '24508144', '658146', '653647', '1898843', '1160043', '679535', '786462', '656507', '655936', '29488956', '655825', '659544', '657157', '684545', '2496264', '23000231', '23015221', '680276', '686933', '694592', '24202561', '22918692', '687850', '677500', '680368', '653819', '686785', '680392', '800214', '657041', '1179489', '685069', '2633556', '694730', '24510603', '687543', '657482', '24821059', '653660', '2608798', '1286121', '655954', '786468', '835522', '24507498', '655292', '24508284', '694578', '679476', '656511', '685756', '2649668', '786388')
            GROUP BY p.STORE_ID
            )
            SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
              COALESCE(cm.month_sales, 0) as month_sales,
              COALESCE(cm.month_orders, 0) as month_orders,
              COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
              COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
              CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
                ELSE 0
              END as wow_sales_delta_percent,
              CASE 
                WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
                ELSE 0
              END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:55:23

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:55:44

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:55:46

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:55:48

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Bear Family Restaurants MCD - 2025-09-25 00:55:51

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:55:53

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:05

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:08

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:10

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Bear Family Restaurants MCD - 2025-09-25 00:56:13

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================

-- query - 2025-09-25 00:56:15

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:17

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- TODC_Campaigns - 2025-09-25 00:56:19

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'true'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
          SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
              ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:56:22

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Corporate_Campaigns - 2025-09-25 00:56:25

        WITH current_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as total_sales,
            SUM(CAST(p.ORDERS AS INT64)) as total_orders,
            AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas,
            COUNT(*) as campaign_days
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-15' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_period AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-08' AND '2025-09-14'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        current_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-09-01' AND '2025-09-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        ),
        previous_month AS (
          SELECT 
            p.CAMPAIGN_NAME,
            p.STORE_NAME,
            SUM(CAST(p.SALES AS FLOAT64)) as prev_month_sales,
            SUM(CAST(p.ORDERS AS INT64)) as prev_month_orders
          FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
          WHERE p.DATE BETWEEN '2025-08-01' AND '2025-08-21'
            AND p.SALES IS NOT NULL
            AND p.SALES != 'null'
            AND p.SALES != ''
            AND p.IS_SELF_SERVE_CAMPAIGN = 'false'
            AND p.STORE_ID IN ('656600')
          GROUP BY p.CAMPAIGN_NAME, p.STORE_NAME
        )
        SELECT 
          c.CAMPAIGN_NAME,
          c.STORE_NAME,
          c.total_sales,
          c.total_orders,
          c.avg_roas,
          c.campaign_days,
          COALESCE(p.prev_sales, 0) as prev_sales,
          COALESCE(p.prev_orders, 0) as prev_orders,
          COALESCE(m.month_sales, 0) as month_sales,
          COALESCE(m.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
            WHEN COALESCE(p.prev_sales, 0) > 0 
            THEN ROUND(((c.total_sales - COALESCE(p.prev_sales, 0)) / COALESCE(p.prev_sales, 0)) * 100, 2)
            ELSE 0 
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 
            THEN ROUND(((COALESCE(m.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100, 2)
            ELSE 0 
          END as mom_sales_delta_percent
        FROM current_period c
        LEFT JOIN previous_period p ON c.CAMPAIGN_NAME = p.CAMPAIGN_NAME AND c.STORE_NAME = p.STORE_NAME
        LEFT JOIN current_month m ON c.CAMPAIGN_NAME = m.CAMPAIGN_NAME AND c.STORE_NAME = m.STORE_NAME
        LEFT JOIN previous_month pm ON c.CAMPAIGN_NAME = pm.CAMPAIGN_NAME AND c.STORE_NAME = pm.STORE_NAME
        ORDER BY c.total_sales DESC
        LIMIT 10
        
================================================================================

-- query - 2025-09-25 00:56:27

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:47

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-25 00:56:50

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-25 00:56:52

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-25 00:56:55

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-25 00:56:57

                SELECT MAX(DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- FAILED_query - 2025-09-25 00:56:57
-- FAILED QUERY: 400 Unrecognized name: DATE at [4:23]; reason: invalidQuery, location: query, message: Unrecognized name: DATE at [4:23]

Location: us-west1
Job ID: 5ce09e68-5cc9-40fd-be00-14639b4aa496


                SELECT MAX(DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:56:57

                SELECT MAX(DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- FAILED_query - 2025-09-25 00:56:58
-- FAILED QUERY: 400 Unrecognized name: DATE at [4:23]; reason: invalidQuery, location: query, message: Unrecognized name: DATE at [4:23]

Location: us-west1
Job ID: aa5a5b99-aa18-4486-8525-f1daaadbfd66


                SELECT MAX(DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.ue_raw_offers_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:57:04

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- WoW_Query - 2025-09-25 00:57:06

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_sales,
            c.current_orders,
            p.prev_sales,
            p.prev_orders,
            CASE 
                WHEN p.prev_sales > 0 THEN ((c.current_sales - p.prev_sales) / p.prev_sales) * 100
            ELSE 0 
          END as sales_delta_percent,
          CASE 
                WHEN p.prev_orders > 0 THEN ((c.current_orders - p.prev_orders) / p.prev_orders) * 100
            ELSE 0 
          END as orders_delta_percent
        FROM current_week c, previous_week p
        
================================================================================

-- query - 2025-09-25 00:57:08

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- MoM_Query - 2025-09-25 00:57:13

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
        )
        SELECT 
            c.current_month_sales,
            c.current_month_orders,
            p.prev_month_sales,
            p.prev_month_orders,
            CASE 
                WHEN p.prev_month_sales > 0 THEN ((c.current_month_sales - p.prev_month_sales) / p.prev_month_sales) * 100
                ELSE 0 
            END as mom_sales_delta_percent,
            CASE 
                WHEN p.prev_month_orders > 0 THEN ((c.current_month_orders - p.prev_month_orders) / p.prev_month_orders) * 100
                ELSE 0 
            END as mom_orders_delta_percent
        FROM current_month c, previous_month p
        
================================================================================

-- query - 2025-09-25 00:57:15

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:57:17

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
================================================================================

-- query - 2025-09-25 00:57:19

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        
================================================================================

-- Store_Level_Data_Bear Family Restaurants MCD - 2025-09-25 00:57:22

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        current_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        previous_month AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
            AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY STORE_ID, STORE_NAME
        ),
        avg_roas AS (
            SELECT 
                CAST(p.STORE_ID AS STRING) as STORE_ID,
                AVG(CAST(p.ROAS AS FLOAT64)) as avg_roas
            FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns` p
            WHERE p.DATE = '2025-09-21'
                AND p.ROAS IS NOT NULL
                AND p.ROAS != 'null'
                AND p.ROAS != ''
                AND p.STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            GROUP BY p.STORE_ID
        )
        SELECT 
            cw.STORE_ID,
            cw.STORE_NAME,
            cw.total_sales,
            cw.total_orders,
            COALESCE(ar.avg_roas, 0) as avg_roas,
            COALESCE(pw.prev_sales, 0) as prev_sales,
            COALESCE(pw.prev_orders, 0) as prev_orders,
          COALESCE(cm.month_sales, 0) as month_sales,
          COALESCE(cm.month_orders, 0) as month_orders,
          COALESCE(pm.prev_month_sales, 0) as prev_month_sales,
          COALESCE(pm.prev_month_orders, 0) as prev_month_orders,
          CASE 
                WHEN COALESCE(pw.prev_sales, 0) > 0 THEN ((cw.total_sales - COALESCE(pw.prev_sales, 0)) / COALESCE(pw.prev_sales, 0)) * 100
            ELSE 0
          END as wow_sales_delta_percent,
          CASE 
            WHEN COALESCE(pm.prev_month_sales, 0) > 0 THEN ((COALESCE(cm.month_sales, 0) - COALESCE(pm.prev_month_sales, 0)) / COALESCE(pm.prev_month_sales, 0)) * 100
            ELSE 0
          END as mom_sales_delta_percent
        FROM current_week cw
        LEFT JOIN previous_week pw ON cw.STORE_ID = pw.STORE_ID
        LEFT JOIN current_month cm ON cw.STORE_ID = cm.STORE_ID
        LEFT JOIN previous_month pm ON cw.STORE_ID = pm.STORE_ID
        LEFT JOIN avg_roas ar ON cw.STORE_ID = ar.STORE_ID
        ORDER BY cw.total_sales DESC
        
================================================================================
