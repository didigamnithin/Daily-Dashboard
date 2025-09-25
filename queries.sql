
-- query - 2025-09-25 22:51:41

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_NAME = '5579'
        
================================================================================

-- query - 2025-09-25 22:51:45

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_ID = '5579'
        
================================================================================

-- MoM_Query - 2025-09-25 22:51:47

        WITH current_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_month_sales,
                COUNT(*) as current_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
        ),
        previous_month AS (
            SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- query - 2025-09-25 22:51:50

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                
================================================================================

-- query - 2025-09-25 22:51:53

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_ID = '5579'
        
================================================================================

-- Operator_Bear Family Restaurants MCD - 2025-09-25 22:51:55

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24207786', '655940', '653706', '2664487', '654860', '2664473', '2663940', '659372', '656282', '653975', '655936', '655573', '653819', '653877', '656986', '656600', '24207864', '656284', '655954', '24207837', '2650292', '655292', '2667097', '2667134', '2667151', '654732', '23450401', '23450614', '656317', '659264')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_RJ Nelson Enterprise MCD - 2025-09-25 22:51:58

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653969', '657041', '657312', '654446', '656534')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Hugh O’Reilly MCD - 2025-09-25 22:52:01

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2649668', '786522', '1732200')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2649668', '786522', '1732200')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_SSM Inc MCD - 2025-09-25 22:52:04

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('695193', '695468', '696601', '786462', '24507498')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Third Gen Management  - 2025-09-25 22:52:07

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1753653', '786331', '24530672', '24821059', '659474', '24821039', '23695567', '24507749', '24821020', '1753726', '658610', '24277112')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Third Gen Management / Glennhaven - 2025-09-25 22:52:10

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24507855')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24507855')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24507855')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_JKK Enterprises - 2025-09-25 22:52:12

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('687357', '687002', '23987538', '686331')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_QSC Enterprises - 2025-09-25 22:52:15

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('686399', '686979', '686785', '686788', '687052', '687303', '687101', '27993089', '29488956')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Kinney QSR - 2025-09-25 22:52:18

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('680276', '23161795', '1727364', '680274')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Alpha Management  - 2025-09-25 22:52:21

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23695622', '22918692', '694730', '22918798', '686897', '694571', '1011526', '694246', '1011529', '674658')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Goodman Group Restaurants - 2025-09-25 22:52:24

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('837189', '837641', '837193', '860550', '860650', '837652', '2731693', '2731379', '837656', '837208', '860644', '860640', '837211', '837666', '821321', '860595', '800214', '860563', '837676', '2732280', '2731118', '837238')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Clark Management  - 2025-09-25 22:52:26

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Herb's Place Inc - 2025-09-25 22:52:29

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655647', '658045')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655647', '658045')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655647', '658045')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Clone & Buck - 2025-09-25 22:52:32

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24202462', '1179395', '695172', '659866', '2109065', '656520', '2108974', '24202476', '658616', '24202561', '24510688', '659199')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Kory Management - 2025-09-25 22:52:34

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('662502', '654018', '653763', '653528', '655297', '694596', '655305', '2608798', '24408689', '24408834', '2444918', '24409150')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Arc Limited Group - 2025-09-25 22:52:38

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('654674', '653727', '656573', '790716', '659452', '835522', '680091', '659614', '653707', '653737', '1898843', '654943', '1882630', '662301', '655480', '31430117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_QSR Executive Enterprises - 2025-09-25 22:52:40

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Big Gee Ent LLC - 2025-09-25 22:52:43

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657157', '946258', '659406', '946269', '946236', '946241', '1544237', '946252', '1544219')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_P.R. Pernecky Management - 2025-09-25 22:52:46

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659888', '656518', '657082', '656457', '656474', '657765', '694398', '656507', '656511', '658728', '662305')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Wiseman LLC - 2025-09-25 22:52:48

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('657751', '655819', '658837', '659015', '694570', '659197')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_West Mount 23719, LLC - 2025-09-25 22:52:52

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('505344', '647807', '647795', '647812', '647867', '647873')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Ricely Group - 2025-09-25 22:52:54

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2631815', '24575666', '24575626', '24575642', '2633556')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_L3 Restaurants Inc - 2025-09-25 22:52:58

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1102215', '655644', '1102231', '1102150', '2377932', '24510603')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Knoth Management Group - 2025-09-25 22:53:00

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1160043', '2664004', '1159715')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('1160043', '2664004', '1159715')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_O'Keefe Family McDonald's - 2025-09-25 22:53:03

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659518', '24122880', '655941', '656318', '653606', '659277')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Upchurch Management  - 2025-09-25 22:53:06

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684427', '677517', '685073', '685633', '680386', '680368', '687543', '684468', '685069', '684472', '684918', '687850', '684457', '684443', '684429', '684444', '688121', '680307', '684491', '686273', '684476', '680384', '680392', '684559', '680394', '684906', '684917', '684904', '684455', '684546', '685071')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_LAZ II, Inc - 2025-09-25 22:53:09

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('24508284', '2400162', '2400535', '2400648', '2399997', '2401263', '2400443')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Marks Management  - 2025-09-25 22:53:12

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('694960', '786414', '694110', '24508144', '658077', '862451', '658813', '659117')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Mao Enterprises LLC - 2025-09-25 22:53:15

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655934', '654257', '657052', '654323', '658130')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Divine Favor, LLC - 2025-09-25 22:53:17

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('23015273', '685540', '23015221', '684545', '685532')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Kipco Restaurants LLC - 2025-09-25 22:53:20

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('653647', '657905', '659500', '662129', '653660', '701506', '658146', '694737', '657012', '720447', '653893')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Grayco Mgt - 2025-09-25 22:53:23

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('25044832', '679476', '685752', '686892', '694583', '679533', '685756', '680388', '687435', '679535', '679532', '679529', '685135', '684628', '687989', '684621', '688065', '684617', '684418', '677499', '680142', '694186', '684634', '686392', '686461', '24661300', '685768', '679531', '24655482', '686757', '694578', '23701157', '684978', '2297300', '1286121', '25070220', '1102267', '694814', '687508', '28834090', '678856', '786468', '678863', '694587', '695044')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_DMD Restaurants - 2025-09-25 22:53:25

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('659930', '659289', '659492', '655874')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Alamo Family LLC - 2025-09-25 22:53:29

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('2601637', '1179489', '687137', '695100', '24941763', '695194', '695465', '677500', '2496264', '694265', '2496503', '1179284', '694440', '694453', '686685', '786388', '686781', '694700', '24508148', '2496846', '31752210')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Operator_Bican Family Restaurants Inc - 2025-09-25 22:53:31

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655822', '655827', '655825')
        ),
        previous_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_sales,
                COUNT(*) as prev_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-08' AND '2025-09-14'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            current_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as month_sales,
                COUNT(*) as month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-01' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('655822', '655827', '655825')
            ),
            previous_month AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as prev_month_sales,
                COUNT(*) as prev_month_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-08-01' AND '2025-08-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- query - 2025-09-25 22:53:34

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- query - 2025-09-25 22:53:36

        WITH current_week AS (
              SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684978', '659452', '662305', '684472', '684491', '946241', '22918692', '655644', '23000231', '1179284', '657012', '659500', '657751', '677517', '31752210', '1732200', '860640', '680394', '28834090', '656520', '23000234', '2664004', '31430117', '694578', '655573', '1102231', '862451', '686273', '24507855', '686685', '653737', '1544219', '659199', '658077', '1179395', '653969', '24207864', '24408834', '24575642', '837211', '654732', '684457', '1286121', '694587', '694440', '685756', '24575626', '1102215', '655822', '24202561', '24661300', '24821039', '24508024', '684918', '659015', '24277112', '2377932', '687989', '24510688', '23000171', '685752', '686933', '654018', '655825', '684904', '656282', '658837', '687052', '687435', '686897', '860563', '679532', '658045', '653618', '654943', '1544237', '679529', '656317', '680392', '659372', '694596', '654323', '1160043', '24507749', '657157', '654446', '22918798', '2496264', '695172', '655305', '684634', '2400162', '837656', '1170166', '695468', '656573', '1898843', '647867', '680307', '653660', '686781', '860650', '656518', '658616', '786468', '655940', '658813', '946252', '684621', '790716', '657312', '837676', '837652', '1179489', '686331', '695324', '1159715', '23161795', '687357', '505344', '653727', '662502', '647807', '2631815', '23695567', '23000270', '685609', '694571', '687101', '687543', '687850', '24590476', '2650292', '653647', '2109065', '837238', '837208', '656457', '677499', '659197', '694453', '2731118', '24207786', '860644', '659518', '1882630', '786331', '1011526', '659614', '656318', '694110', '1102267', '679535', '694700', '24821020', '23701157', '653819', '680276', '684906', '685073', '2400443', '686785', '24507498', '653877', '680274', '684427', '659888', '684917', '1753653', '653528', '659264', '2400535', '24510603', '647795', '24408689', '659492', '2667151', '24207837', '662301', '1011529', '659930', '2108974', '24508148', '686979', '655297', '786414', '24821059', '655954', '695100', '653606', '656474', '655941', '679476', '1170194', '662129', '24752906', '837641', '800214', '680388', '686892', '24530672', '2297300', '680386', '684476', '2664473', '24202476', '680091', '659674', '658610', '860550', '654674', '685540', '657482', '687303', '695193', '24752950', '23987538', '694265', '653706', '24409150', '680368', '674658', '657082', '2731693', '653707', '685532', '2663940', '2108398', '653893', '694960', '2297296', '655874', '2110169', '685071', '654860', '684546', '656986', '837193', '694592', '694737', '684429', '23000201', '946236', '23450614', '685768', '2664487', '24202462', '685069', '678856', '653975', '786462', '2731379', '655292', '27993089', '694246', '647873', '23695622', '25070220', '29488956', '2110005', '2400648', '657052', '821321', '679533', '688121', '687137', '659277', '25044832', '694814', '23015221', '24655482', '655647', '686757', '24575666', '658130', '946258', '684559', '24590418', '835522', '655936', '701506', '2110096', '23000258', '684444', '656600', '657765', '659544', '687508', '684443', '695044', '684468', '24122880', '23000302', '687002', '23015471', '685633', '659289', '2399997', '2667097', '1753726', '837189', '656507', '655819', '1727364', '686461', '678863', '837666', '684617', '684628', '685135', '684455', '658728', '680142', '24507497', '656284', '659117', '694583', '647812', '656511', '654257', '2732280', '659474', '2122176', '655827', '24941763', '679531', '2444918', '655934', '655480', '694730', '677500', '24508284', '701236', '2496846', '696601', '658146', '1102150', '684418', '24508144', '694186', '694398', '659406', '2667134', '2601637', '695194', '659572', '23450401', '657041', '2649668', '786522', '2608798', '659641', '688065', '2496503', '694570', '680384', '23015273', '695465', '659805', '786388', '657905', '684545', '860595', '686788', '686399', '946269', '2401263', '653763', '656534', '659866', '720447', '2633556', '686392')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684978', '659452', '662305', '684472', '684491', '946241', '22918692', '655644', '23000231', '1179284', '657012', '659500', '657751', '677517', '31752210', '1732200', '860640', '680394', '28834090', '656520', '23000234', '2664004', '31430117', '694578', '655573', '1102231', '862451', '686273', '24507855', '686685', '653737', '1544219', '659199', '658077', '1179395', '653969', '24207864', '24408834', '24575642', '837211', '654732', '684457', '1286121', '694587', '694440', '685756', '24575626', '1102215', '655822', '24202561', '24661300', '24821039', '24508024', '684918', '659015', '24277112', '2377932', '687989', '24510688', '23000171', '685752', '686933', '654018', '655825', '684904', '656282', '658837', '687052', '687435', '686897', '860563', '679532', '658045', '653618', '654943', '1544237', '679529', '656317', '680392', '659372', '694596', '654323', '1160043', '24507749', '657157', '654446', '22918798', '2496264', '695172', '655305', '684634', '2400162', '837656', '1170166', '695468', '656573', '1898843', '647867', '680307', '653660', '686781', '860650', '656518', '658616', '786468', '655940', '658813', '946252', '684621', '790716', '657312', '837676', '837652', '1179489', '686331', '695324', '1159715', '23161795', '687357', '505344', '653727', '662502', '647807', '2631815', '23695567', '23000270', '685609', '694571', '687101', '687543', '687850', '24590476', '2650292', '653647', '2109065', '837238', '837208', '656457', '677499', '659197', '694453', '2731118', '24207786', '860644', '659518', '1882630', '786331', '1011526', '659614', '656318', '694110', '1102267', '679535', '694700', '24821020', '23701157', '653819', '680276', '684906', '685073', '2400443', '686785', '24507498', '653877', '680274', '684427', '659888', '684917', '1753653', '653528', '659264', '2400535', '24510603', '647795', '24408689', '659492', '2667151', '24207837', '662301', '1011529', '659930', '2108974', '24508148', '686979', '655297', '786414', '24821059', '655954', '695100', '653606', '656474', '655941', '679476', '1170194', '662129', '24752906', '837641', '800214', '680388', '686892', '24530672', '2297300', '680386', '684476', '2664473', '24202476', '680091', '659674', '658610', '860550', '654674', '685540', '657482', '687303', '695193', '24752950', '23987538', '694265', '653706', '24409150', '680368', '674658', '657082', '2731693', '653707', '685532', '2663940', '2108398', '653893', '694960', '2297296', '655874', '2110169', '685071', '654860', '684546', '656986', '837193', '694592', '694737', '684429', '23000201', '946236', '23450614', '685768', '2664487', '24202462', '685069', '678856', '653975', '786462', '2731379', '655292', '27993089', '694246', '647873', '23695622', '25070220', '29488956', '2110005', '2400648', '657052', '821321', '679533', '688121', '687137', '659277', '25044832', '694814', '23015221', '24655482', '655647', '686757', '24575666', '658130', '946258', '684559', '24590418', '835522', '655936', '701506', '2110096', '23000258', '684444', '656600', '657765', '659544', '687508', '684443', '695044', '684468', '24122880', '23000302', '687002', '23015471', '685633', '659289', '2399997', '2667097', '1753726', '837189', '656507', '655819', '1727364', '686461', '678863', '837666', '684617', '684628', '685135', '684455', '658728', '680142', '24507497', '656284', '659117', '694583', '647812', '656511', '654257', '2732280', '659474', '2122176', '655827', '24941763', '679531', '2444918', '655934', '655480', '694730', '677500', '24508284', '701236', '2496846', '696601', '658146', '1102150', '684418', '24508144', '694186', '694398', '659406', '2667134', '2601637', '695194', '659572', '23450401', '657041', '2649668', '786522', '2608798', '659641', '688065', '2496503', '694570', '680384', '23015273', '695465', '659805', '786388', '657905', '684545', '860595', '686788', '686399', '946269', '2401263', '653763', '656534', '659866', '720447', '2633556', '686392')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684978', '659452', '662305', '684472', '684491', '946241', '22918692', '655644', '23000231', '1179284', '657012', '659500', '657751', '677517', '31752210', '1732200', '860640', '680394', '28834090', '656520', '23000234', '2664004', '31430117', '694578', '655573', '1102231', '862451', '686273', '24507855', '686685', '653737', '1544219', '659199', '658077', '1179395', '653969', '24207864', '24408834', '24575642', '837211', '654732', '684457', '1286121', '694587', '694440', '685756', '24575626', '1102215', '655822', '24202561', '24661300', '24821039', '24508024', '684918', '659015', '24277112', '2377932', '687989', '24510688', '23000171', '685752', '686933', '654018', '655825', '684904', '656282', '658837', '687052', '687435', '686897', '860563', '679532', '658045', '653618', '654943', '1544237', '679529', '656317', '680392', '659372', '694596', '654323', '1160043', '24507749', '657157', '654446', '22918798', '2496264', '695172', '655305', '684634', '2400162', '837656', '1170166', '695468', '656573', '1898843', '647867', '680307', '653660', '686781', '860650', '656518', '658616', '786468', '655940', '658813', '946252', '684621', '790716', '657312', '837676', '837652', '1179489', '686331', '695324', '1159715', '23161795', '687357', '505344', '653727', '662502', '647807', '2631815', '23695567', '23000270', '685609', '694571', '687101', '687543', '687850', '24590476', '2650292', '653647', '2109065', '837238', '837208', '656457', '677499', '659197', '694453', '2731118', '24207786', '860644', '659518', '1882630', '786331', '1011526', '659614', '656318', '694110', '1102267', '679535', '694700', '24821020', '23701157', '653819', '680276', '684906', '685073', '2400443', '686785', '24507498', '653877', '680274', '684427', '659888', '684917', '1753653', '653528', '659264', '2400535', '24510603', '647795', '24408689', '659492', '2667151', '24207837', '662301', '1011529', '659930', '2108974', '24508148', '686979', '655297', '786414', '24821059', '655954', '695100', '653606', '656474', '655941', '679476', '1170194', '662129', '24752906', '837641', '800214', '680388', '686892', '24530672', '2297300', '680386', '684476', '2664473', '24202476', '680091', '659674', '658610', '860550', '654674', '685540', '657482', '687303', '695193', '24752950', '23987538', '694265', '653706', '24409150', '680368', '674658', '657082', '2731693', '653707', '685532', '2663940', '2108398', '653893', '694960', '2297296', '655874', '2110169', '685071', '654860', '684546', '656986', '837193', '694592', '694737', '684429', '23000201', '946236', '23450614', '685768', '2664487', '24202462', '685069', '678856', '653975', '786462', '2731379', '655292', '27993089', '694246', '647873', '23695622', '25070220', '29488956', '2110005', '2400648', '657052', '821321', '679533', '688121', '687137', '659277', '25044832', '694814', '23015221', '24655482', '655647', '686757', '24575666', '658130', '946258', '684559', '24590418', '835522', '655936', '701506', '2110096', '23000258', '684444', '656600', '657765', '659544', '687508', '684443', '695044', '684468', '24122880', '23000302', '687002', '23015471', '685633', '659289', '2399997', '2667097', '1753726', '837189', '656507', '655819', '1727364', '686461', '678863', '837666', '684617', '684628', '685135', '684455', '658728', '680142', '24507497', '656284', '659117', '694583', '647812', '656511', '654257', '2732280', '659474', '2122176', '655827', '24941763', '679531', '2444918', '655934', '655480', '694730', '677500', '24508284', '701236', '2496846', '696601', '658146', '1102150', '684418', '24508144', '694186', '694398', '659406', '2667134', '2601637', '695194', '659572', '23450401', '657041', '2649668', '786522', '2608798', '659641', '688065', '2496503', '694570', '680384', '23015273', '695465', '659805', '786388', '657905', '684545', '860595', '686788', '686399', '946269', '2401263', '653763', '656534', '659866', '720447', '2633556', '686392')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
                AND STORE_ID IN ('684978', '659452', '662305', '684472', '684491', '946241', '22918692', '655644', '23000231', '1179284', '657012', '659500', '657751', '677517', '31752210', '1732200', '860640', '680394', '28834090', '656520', '23000234', '2664004', '31430117', '694578', '655573', '1102231', '862451', '686273', '24507855', '686685', '653737', '1544219', '659199', '658077', '1179395', '653969', '24207864', '24408834', '24575642', '837211', '654732', '684457', '1286121', '694587', '694440', '685756', '24575626', '1102215', '655822', '24202561', '24661300', '24821039', '24508024', '684918', '659015', '24277112', '2377932', '687989', '24510688', '23000171', '685752', '686933', '654018', '655825', '684904', '656282', '658837', '687052', '687435', '686897', '860563', '679532', '658045', '653618', '654943', '1544237', '679529', '656317', '680392', '659372', '694596', '654323', '1160043', '24507749', '657157', '654446', '22918798', '2496264', '695172', '655305', '684634', '2400162', '837656', '1170166', '695468', '656573', '1898843', '647867', '680307', '653660', '686781', '860650', '656518', '658616', '786468', '655940', '658813', '946252', '684621', '790716', '657312', '837676', '837652', '1179489', '686331', '695324', '1159715', '23161795', '687357', '505344', '653727', '662502', '647807', '2631815', '23695567', '23000270', '685609', '694571', '687101', '687543', '687850', '24590476', '2650292', '653647', '2109065', '837238', '837208', '656457', '677499', '659197', '694453', '2731118', '24207786', '860644', '659518', '1882630', '786331', '1011526', '659614', '656318', '694110', '1102267', '679535', '694700', '24821020', '23701157', '653819', '680276', '684906', '685073', '2400443', '686785', '24507498', '653877', '680274', '684427', '659888', '684917', '1753653', '653528', '659264', '2400535', '24510603', '647795', '24408689', '659492', '2667151', '24207837', '662301', '1011529', '659930', '2108974', '24508148', '686979', '655297', '786414', '24821059', '655954', '695100', '653606', '656474', '655941', '679476', '1170194', '662129', '24752906', '837641', '800214', '680388', '686892', '24530672', '2297300', '680386', '684476', '2664473', '24202476', '680091', '659674', '658610', '860550', '654674', '685540', '657482', '687303', '695193', '24752950', '23987538', '694265', '653706', '24409150', '680368', '674658', '657082', '2731693', '653707', '685532', '2663940', '2108398', '653893', '694960', '2297296', '655874', '2110169', '685071', '654860', '684546', '656986', '837193', '694592', '694737', '684429', '23000201', '946236', '23450614', '685768', '2664487', '24202462', '685069', '678856', '653975', '786462', '2731379', '655292', '27993089', '694246', '647873', '23695622', '25070220', '29488956', '2110005', '2400648', '657052', '821321', '679533', '688121', '687137', '659277', '25044832', '694814', '23015221', '24655482', '655647', '686757', '24575666', '658130', '946258', '684559', '24590418', '835522', '655936', '701506', '2110096', '23000258', '684444', '656600', '657765', '659544', '687508', '684443', '695044', '684468', '24122880', '23000302', '687002', '23015471', '685633', '659289', '2399997', '2667097', '1753726', '837189', '656507', '655819', '1727364', '686461', '678863', '837666', '684617', '684628', '685135', '684455', '658728', '680142', '24507497', '656284', '659117', '694583', '647812', '656511', '654257', '2732280', '659474', '2122176', '655827', '24941763', '679531', '2444918', '655934', '655480', '694730', '677500', '24508284', '701236', '2496846', '696601', '658146', '1102150', '684418', '24508144', '694186', '694398', '659406', '2667134', '2601637', '695194', '659572', '23450401', '657041', '2649668', '786522', '2608798', '659641', '688065', '2496503', '694570', '680384', '23015273', '695465', '659805', '786388', '657905', '684545', '860595', '686788', '686399', '946269', '2401263', '653763', '656534', '659866', '720447', '2633556', '686392')
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
                AND STORE_ID IN ('684978', '659452', '662305', '684472', '684491', '946241', '22918692', '655644', '23000231', '1179284', '657012', '659500', '657751', '677517', '31752210', '1732200', '860640', '680394', '28834090', '656520', '23000234', '2664004', '31430117', '694578', '655573', '1102231', '862451', '686273', '24507855', '686685', '653737', '1544219', '659199', '658077', '1179395', '653969', '24207864', '24408834', '24575642', '837211', '654732', '684457', '1286121', '694587', '694440', '685756', '24575626', '1102215', '655822', '24202561', '24661300', '24821039', '24508024', '684918', '659015', '24277112', '2377932', '687989', '24510688', '23000171', '685752', '686933', '654018', '655825', '684904', '656282', '658837', '687052', '687435', '686897', '860563', '679532', '658045', '653618', '654943', '1544237', '679529', '656317', '680392', '659372', '694596', '654323', '1160043', '24507749', '657157', '654446', '22918798', '2496264', '695172', '655305', '684634', '2400162', '837656', '1170166', '695468', '656573', '1898843', '647867', '680307', '653660', '686781', '860650', '656518', '658616', '786468', '655940', '658813', '946252', '684621', '790716', '657312', '837676', '837652', '1179489', '686331', '695324', '1159715', '23161795', '687357', '505344', '653727', '662502', '647807', '2631815', '23695567', '23000270', '685609', '694571', '687101', '687543', '687850', '24590476', '2650292', '653647', '2109065', '837238', '837208', '656457', '677499', '659197', '694453', '2731118', '24207786', '860644', '659518', '1882630', '786331', '1011526', '659614', '656318', '694110', '1102267', '679535', '694700', '24821020', '23701157', '653819', '680276', '684906', '685073', '2400443', '686785', '24507498', '653877', '680274', '684427', '659888', '684917', '1753653', '653528', '659264', '2400535', '24510603', '647795', '24408689', '659492', '2667151', '24207837', '662301', '1011529', '659930', '2108974', '24508148', '686979', '655297', '786414', '24821059', '655954', '695100', '653606', '656474', '655941', '679476', '1170194', '662129', '24752906', '837641', '800214', '680388', '686892', '24530672', '2297300', '680386', '684476', '2664473', '24202476', '680091', '659674', '658610', '860550', '654674', '685540', '657482', '687303', '695193', '24752950', '23987538', '694265', '653706', '24409150', '680368', '674658', '657082', '2731693', '653707', '685532', '2663940', '2108398', '653893', '694960', '2297296', '655874', '2110169', '685071', '654860', '684546', '656986', '837193', '694592', '694737', '684429', '23000201', '946236', '23450614', '685768', '2664487', '24202462', '685069', '678856', '653975', '786462', '2731379', '655292', '27993089', '694246', '647873', '23695622', '25070220', '29488956', '2110005', '2400648', '657052', '821321', '679533', '688121', '687137', '659277', '25044832', '694814', '23015221', '24655482', '655647', '686757', '24575666', '658130', '946258', '684559', '24590418', '835522', '655936', '701506', '2110096', '23000258', '684444', '656600', '657765', '659544', '687508', '684443', '695044', '684468', '24122880', '23000302', '687002', '23015471', '685633', '659289', '2399997', '2667097', '1753726', '837189', '656507', '655819', '1727364', '686461', '678863', '837666', '684617', '684628', '685135', '684455', '658728', '680142', '24507497', '656284', '659117', '694583', '647812', '656511', '654257', '2732280', '659474', '2122176', '655827', '24941763', '679531', '2444918', '655934', '655480', '694730', '677500', '24508284', '701236', '2496846', '696601', '658146', '1102150', '684418', '24508144', '694186', '694398', '659406', '2667134', '2601637', '695194', '659572', '23450401', '657041', '2649668', '786522', '2608798', '659641', '688065', '2496503', '694570', '680384', '23015273', '695465', '659805', '786388', '657905', '684545', '860595', '686788', '686399', '946269', '2401263', '653763', '656534', '659866', '720447', '2633556', '686392')
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

-- query - 2025-09-25 22:53:39

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                
================================================================================

-- query - 2025-09-25 22:56:04

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                
================================================================================

-- query - 2025-09-25 22:56:07

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                
================================================================================

-- query - 2025-09-25 22:56:09

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Store_Level_Data_Clark Management  - 2025-09-25 22:56:12

        WITH current_week AS (
          SELECT 
                STORE_ID,
                STORE_NAME,
                SUM(CAST(SUBTOTAL AS FLOAT64)) as total_sales,
                COUNT(*) as total_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
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
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
            AND STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
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
                AND p.STORE_ID IN ('653618', '659641', '24752906', '24752950', '695324', '659544', '657482', '659572', '659674', '659805')
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

-- query - 2025-09-25 22:56:15

                SELECT MAX(PARSE_DATE('%Y-%m-%d', DATE)) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_promotion_campaigns`
                WHERE DATE IS NOT NULL
                
                
================================================================================
