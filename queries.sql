
-- Orchestrator_query - 2025-09-26 01:31:34

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 01:31:55

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 01:31:58

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 01:32:11

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 01:32:14

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:02:57

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- WoW_query - 2025-09-26 02:03:00

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- MoM_query - 2025-09-26 02:03:00

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_ID = '5579'
        
================================================================================

-- MoM_MoM_Query - 2025-09-26 02:03:03

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

-- WoW_WoW_Query - 2025-09-26 02:03:03

        WITH current_week AS (
          SELECT 
                SUM(CAST(SUBTOTAL AS FLOAT64)) as current_sales,
                COUNT(*) as current_orders
            FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
            WHERE TIMESTAMP_UTC_DATE BETWEEN '2025-09-15' AND '2025-09-21'
                AND SUBTOTAL IS NOT NULL
                AND FINAL_ORDER_STATUS = 'Delivered'
                AND TRANSACTION_TYPE = 'Order'
                AND BUSINESS_ID = '5579'
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

-- Orchestrator_query - 2025-09-26 02:03:06

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Operator_query - 2025-09-26 02:03:08

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        AND BUSINESS_ID = '5579'
        
================================================================================

-- Operator_Operator_Bear Family Restaurants MCD - 2025-09-26 02:03:11

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

-- Operator_Operator_RJ Nelson Enterprise MCD - 2025-09-26 02:03:13

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

-- Operator_Operator_Hugh O’Reilly MCD - 2025-09-26 02:03:16

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

-- Operator_Operator_SSM Inc MCD - 2025-09-26 02:03:18

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

-- Operator_Operator_Third Gen Management  - 2025-09-26 02:03:21

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

-- Operator_Operator_Third Gen Management / Glennhaven - 2025-09-26 02:03:23

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

-- Operator_Operator_JKK Enterprises - 2025-09-26 02:03:25

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

-- Operator_Operator_QSC Enterprises - 2025-09-26 02:03:28

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

-- Operator_Operator_Kinney QSR - 2025-09-26 02:03:30

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

-- Operator_Operator_Alpha Management  - 2025-09-26 02:03:32

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

-- Operator_Operator_Goodman Group Restaurants - 2025-09-26 02:03:35

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

-- Operator_Operator_Clark Management  - 2025-09-26 02:03:37

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

-- Operator_Operator_Herb's Place Inc - 2025-09-26 02:03:40

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

-- Operator_Operator_Clone & Buck - 2025-09-26 02:03:42

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

-- Operator_Operator_Kory Management - 2025-09-26 02:03:44

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

-- Operator_Operator_Arc Limited Group - 2025-09-26 02:03:46

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

-- Operator_Operator_QSR Executive Enterprises - 2025-09-26 02:03:49

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

-- Operator_Operator_Big Gee Ent LLC - 2025-09-26 02:03:51

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

-- Operator_Operator_Wiseman LLC - 2025-09-26 02:03:53

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

-- Operator_Operator_West Mount 23719, LLC - 2025-09-26 02:03:55

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

-- Operator_Operator_Ricely Group - 2025-09-26 02:03:58

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

-- Operator_Operator_L3 Restaurants Inc - 2025-09-26 02:04:00

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

-- Operator_Operator_Knoth Management Group - 2025-09-26 02:04:03

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

-- Operator_Operator_O'Keefe Family McDonald's - 2025-09-26 02:04:05

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

-- Operator_Operator_Upchurch Management  - 2025-09-26 02:04:07

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

-- Operator_Operator_LAZ II, Inc - 2025-09-26 02:04:10

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

-- Operator_Operator_Marks Management  - 2025-09-26 02:04:12

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

-- Orchestrator_query - 2025-09-26 02:04:15

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:04:39

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:04:42

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Store_query - 2025-09-26 02:04:44

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Store_Store_Level_Data_QSR Executive Enterprises - 2025-09-26 02:04:47

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
            AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
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
            AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
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
            AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
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
            AND STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
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
                AND p.STORE_ID IN ('2122176', '1170166', '2108398', '24590418', '23000258', '2297296', '23000201', '23000171', '1170194', '23000270', '24590476', '2110096', '24507497', '685609', '23015471', '24508024', '2110005', '701236', '23000234', '23000231', '694592', '2110169', '23000302', '686933')
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

-- Orchestrator_query - 2025-09-26 02:04:50

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:04:57

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:05:00

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Campaign_query - 2025-09-26 02:05:02

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Campaign_query - 2025-09-26 02:05:02

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Campaign_TODC_Campaigns - 2025-09-26 02:05:05

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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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

-- Campaign_Corporate_Campaigns - 2025-09-26 02:05:05

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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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
            AND p.STORE_ID IN ('685609')
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

-- Orchestrator_query - 2025-09-26 02:05:07

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:05:21

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:05:24

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Store_query - 2025-09-26 02:05:26

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Store_Store_Level_Data_Clark Management  - 2025-09-26 02:05:28

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

-- Orchestrator_query - 2025-09-26 02:05:31

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:05:41

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Orchestrator_query - 2025-09-26 02:05:43

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================

-- Campaign_query - 2025-09-26 02:05:45

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Campaign_query - 2025-09-26 02:05:45

        SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
        FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
        WHERE BUSINESS_ID = '5579'
        AND TRANSACTION_TYPE = 'Order'
        AND FINAL_ORDER_STATUS = 'Delivered'
        AND SUBTOTAL IS NOT NULL
        
================================================================================

-- Campaign_Corporate_Campaigns - 2025-09-26 02:05:48

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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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

-- Campaign_TODC_Campaigns - 2025-09-26 02:05:48

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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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
            AND p.STORE_ID IN ('659805')
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

-- Orchestrator_query - 2025-09-26 02:05:51

                SELECT MAX(TIMESTAMP_UTC_DATE) as max_date
                FROM `todc-marketing.merchant_portal_upload.dd_raw_financials_detailed_transactions_us`
                WHERE TIMESTAMP_UTC_DATE IS NOT NULL
                
================================================================================
