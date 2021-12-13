SELECT c_name, UPPER(c_name)
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER";

SELECT  
    o_orderkey,
    o_totalprice,
    o_orderpriority,
    IFF(o_orderpriority like '1-URGENT', o_totalprice * 0.01, o_totalprice * 0.005)::number(16,2)       ShippingCost  
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS";

SELECT (c_salutation || ' ' || c_first_name || ' ' || c_last_name) AS full_name,
    CASE
        WHEN c_preferred_cust_flag LIKE 'Y'
            THEN 'Preferred Customer'
        WHEN c_preferred_cust_flag LIKE 'N'
            THEN 'Not Preferred Customer'
        END AS customer_status
FROM "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."CUSTOMER"
LIMIT 100;

SELECT RANDOM() AS random_variable;
SELECT RANDOM(100) AS random_fixed;

SELECT CURRENT_DATE(), DATE_PART('DAY', CURRENT_DATE()), CURRENT_TIME();

SELECT STRTOK_TO_ARRAY(query_text)
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE query_text LIKE 'select%'
AND query_text NOT LIKE 'select 1%'
LIMIT 5;

SELECT STRTOK_TO_ARRAY(query_text),
       ARRAY_TO_STRING(STRTOK_TO_ARRAY(query_text),'#')
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE query_text LIKE 'select%'
AND query_text NOT LIKE 'select 1%'
LIMIT 5;

SELECT DAYOFMONTH(start_time), start_time, end_time,  warehouse_name, credits_used, SUM(credits_used)
    OVER (PARTITION BY DAYOFMONTH(start_time), warehouse_name
    ORDER BY DAYOFMONTH(start_time), warehouse_name )
AS day_tot_credits
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    ORDER BY warehouse_name;
    
SELECT MONTH(qh.start_time) AS "month", DAYOFMONTH(qh.start_time) AS dom,
qh.warehouse_name,
AVG(qh.total_elapsed_time),
MIN(qh.total_elapsed_time),
MAX(qh.total_elapsed_time),
STDDEV(qh.total_elapsed_time)
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY qh
WHERE query_text LIKE 'select%'
AND query_text NOT LIKE 'select 1%'
GROUP BY "month", dom, qh.warehouse_name
ORDER BY "month", dom, qh.warehouse_name;

SELECT * FROM TABLE(information_schema.query_history
      (DATEADD('hours', -1, CURRENT_TIMESTAMP()), CURRENT_TIMESTAMP()))
ORDER BY start_time;

SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

SHOW TABLES;
SELECT CONCAT('DESC ',"name",';')
FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

SELECT SYSTEM$WHITELIST();

SELECT VALUE:type AS type,
       VALUE:host AS host,
       VALUE:port AS port
FROM TABLE(FLATTEN(INPUT => PARSE_JSON(system$whitelist())));