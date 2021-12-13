DROP TABLE shipping_by_date;
DROP TABLE avg_shipping_in_days;
DROP TABLE year_month;
DROP TASK insert_shipping_by_date_rows;
DROP TASK average_monthly_shipping;
DROP TASK increment_year_month;
DROP TASK stop_tasks;
DROP SCHEMA BEETLE_TASKS_SCHEMA;
ALTER WAREHOUSE BEETLE_WH SUSPEND;