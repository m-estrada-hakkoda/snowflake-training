CREATE OR REPLACE TASK insert_shipping_by_date_rows
    WAREHOUSE = 'BEETLE_WH'
    SCHEDULE = 'USING CRON 0-59 0-23 * * * America/Chicago'
AS    
    INSERT INTO BEETLE_DB.BEETLE_TASKS_SCHEMA.SHIPPING_BY_DATE (ORDERDATE, SHIPDATE, DAYSTOSHIP)
    SELECT 
        O_ORDERDATE
        , L_SHIPDATE
        , L_SHIPDATE - O_ORDERDATE AS FULFILL_DATE
    FROM
        TRAINING_DB.TPCH_SF1.ORDERS O LEFT JOIN TRAINING_DB.TPCH_SF1.LINEITEM L ON O.O_ORDERKEY = L.L_ORDERKEY     
    WHERE 
        YEAR(O_ORDERDATE) = (SELECT yr FROM BEETLE_db.BEETLE_tasks_schema.year_month WHERE ID = (select MAX(ID) from year_month))
        AND 
        MONTH(O_ORDERDATE)= (SELECT mon FROM BEETLE_db.BEETLE_tasks_schema.year_month WHERE ID = (select MAX(ID) from year_month));

CREATE OR REPLACE TASK average_monthly_shipping
    WAREHOUSE = 'BEETLE_WH'
    AFTER insert_shipping_by_date_rows
AS  
    INSERT INTO BEETLE_DB.BEETLE_TASKS_SCHEMA.AVG_SHIPPING_IN_DAYS(yr, mon, avg_shipping_days)
    SELECT
        YEAR(orderdate) AS yr
      , MONTH(orderdate) AS mon
      , AVG(daystoship) AS avg_shipping_days
    FROM
        BEETLE_DB.BEETLE_TASKS_SCHEMA.SHIPPING_BY_DATE
    WHERE
        yr = (SELECT yr FROM BEETLE_db.BEETLE_tasks_schema.year_month WHERE ID = (select MAX(ID) from year_month))
        AND
        mon = (SELECT mon FROM BEETLE_db.BEETLE_tasks_schema.year_month WHERE ID = (select MAX(ID) from year_month))
    GROUP BY 
        YEAR(orderdate)
      , MONTH(orderdate);

CREATE OR REPLACE TASK increment_year_month
    WAREHOUSE = 'BEETLE_WH'
    AFTER average_monthly_shipping
AS   
    INSERT INTO year_month (yr, mon)
    SELECT DISTINCT
        IFF(mon=12, yr+1, yr) AS YR
        , IFF(mon=12, 1, mon+1) AS MON
    FROM year_month
    WHERE ID = (select MAX(ID) from year_month);

CREATE OR REPLACE PROCEDURE stop_tasks()
 RETURNS string
 LANGUAGE javascript
 STRICT
AS
$$
    var r='continue';
    var mon = snowflake.createStatement({sqlText: 'SELECT mon FROM BEETLE_db.BEETLE_tasks_schema.year_month WHERE ID = (select MAX(ID) from year_month);'});

    var result = mon.execute();
    result.next();
    var x = result.getColumnValue(1);
 
    if (x>=11) {

    var killstmt1 = snowflake.createStatement({sqlText: 'ALTER TASK insert_shipping_by_date_rows SUSPEND;'});
    var killstmt2 = snowflake.createStatement({sqlText: 'ALTER TASK average_monthly_shipping SUSPEND;'});
    var killstmt3 = snowflake.createStatement({sqlText: 'ALTER TASK increment_year_month SUSPEND;'});
                            
    killstmt1.execute();
    killstmt2.execute();
    killstmt3.execute();
                            
    r = 'stopped'
    }
 return r;

$$;

CREATE OR REPLACE TASK stop_tasks
    WAREHOUSE = 'BEETLE_WH'
    AFTER increment_year_month
AS
    CALL stop_tasks();