--> Set context;
;
--> Set session;
;

SELECT *
FROM TABLE(INFORMATION_SCHEMA.WAREHOUSE_METERING_HISTORY
   (DATEADD('DAYS', -5, CURRENT_DATE())));

SELECT warehouse_name, SUM(credits_used) FROM
TABLE(INFORMATION_SCHEMA.WAREHOUSE_METERING_HISTORY
(DATEADD('DAYS', -5, CURRENT_DATE())))
GROUP BY warehouse_name
ORDER BY SUM(credits_used) DESC;

SELECT * FROM TABLE(INFORMATION_SCHEMA.WAREHOUSE_METERING_HISTORY
(DATEADD('DAYS', -7, CURRENT_DATE())));

SHOW PARAMETERS IN SESSION;

SHOW PARAMETERS LIKE 'DATE_OUTPUT_FORMAT' IN SESSION;

SELECT CURRENT_DATE();

SELECT CURRENT_DATE();

SELECT *
FROM TABLE (information_schema.database_storage_usage_history
(DATEADD('days', -5, CURRENT_DATE()), CURRENT_DATE()));

SELECT
    usage_date,
    SUM(average_database_bytes) average_database_bytes, 
    SUM(average_failsafe_bytes) average_failsafe_bytes
FROM TABLE(information_schema.database_storage_usage_history 
   (dateadd('days',-5,current_date()),current_date()))

GROUP BY usage_date 
ORDER BY usage_date;

SELECT *
FROM TABLE (information_schema.stage_storage_usage_history
(DATEADD
(DAYS,-5,CURRENT_DATE()),CURRENT_DATE()));

SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
WHERE usage_date >= DATEADD('DAYS',-7,CURRENT_DATE()) 
ORDER BY usage_date;

SELECT *
FROM TABLE(INFORMATION_SCHEMA.STAGE_STORAGE_USAGE_HISTORY 
(DATE_RANGE_START=>'YYYY-MM-DD'));

SELECT *
FROM TABLE(information_schema.warehouse_metering_history 
(date_range_start=>date_trunc(month, current_date), 
date_range_end=>dateadd(month,1,date_trunc(month, current_date)),'BEETLE_WH')) 
ORDER BY start_time;

SELECT *
FROM TABLE(information_schema.database_storage_usage_history 
(dateadd('days',-3,current_date()),current_date(), 
'BEETLE_db'));

SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'WEATHER'
ORDER BY bytes DESC;

SELECT distinct r.grantee,
   r.role_name,
   r.role_owner,
   d.database_name,
   d.database_owner
FROM information_schema.applicable_roles r 
JOIN information_schema.databases d ON
d.database_owner=r.role_name 
WHERE r.grantee = '[login]';

SELECT user_name,
SUM(IFF(is_success = 'NO', 1, 0)) AS failed_logins,
COUNT(*) AS logins,
SUM(IFF(is_success = 'NO', 1,0)) / nullif(count(*), 0)
AS login_failure_rate
FROM SNOWFLAKE.ACCOUNT_USAGE.login_history
WHERE event_timestamp > date_trunc(month, current_date)
GROUP BY 1
ORDER BY 4 DESC;

SELECT warehouse_name, COUNT(*) AS number_of_jobs
FROM SNOWFLAKE.ACCOUNT_USAGE.query_history
WHERE start_time >= date_trunc(month, current_date)
  AND warehouse_name IS NOT NULL
GROUP BY 1 ORDER BY 2 DESC;

--> First set;
;

SELECT date_trunc(day, start_time) AS usage_day,
SUM(coalesce(credits_used, 0.00)) AS total_credits,
SUM($compute_price * coalesce(credits_used, 0.00))
  AS billable_warehouse_usage
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
WHERE start_time >= date_trunc(day, dateadd(day, -3,current_timestamp))
  AND start_time < date_trunc(day, current_timestamp)
GROUP BY 1;

--> Second set;
;

SELECT date_trunc(day, usage_date) AS usage_day,
ROUND(AVG(storage_bytes)/power(1024, 4), 3)
  AS billable_database_tb, ROUND(AVG(failsafe_bytes)/power(1024, 4), 3)
  AS billable_failsafe_tb, ROUND(AVG(stage_bytes)/power(1024, 4), 3)
  AS billable_stage_tb, $storage_price *
  (billable_database_tb + billable_failsafe_tb + billable_stage_tb)
  AS total_billable_storage_usd
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
WHERE usage_date >= date_trunc(day, dateadd(day, -3, current_timestamp))
AND usage_date < date_trunc(day, current_timestamp)
GROUP BY 1;