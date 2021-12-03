#🥋 Create a Local Database and Warehouse

#1.0
USE ROLE SYSADMIN;
CREATE DATABASE INTL_DB;
USE SCHEMA INTL_DB.PUBLIC;

#1.1
CREATE WAREHOUSE INTL_WH 
WITH WAREHOUSE_SIZE = 'XSMALL' 
WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 600 
AUTO_RESUME = TRUE;
USE WAREHOUSE INTL_WH;

#🥋 Create a Table and Load Itcurrent section

#1.0

CREATE OR REPLACE TABLE INTL_DB.PUBLIC.INT_STDS_ORG_3661 
(ISO_COUNTRY_NAME varchar(100), 
 COUNTRY_NAME_OFFICIAL varchar(200), 
 SOVEREIGNTY varchar(40), 
 ALPHA_CODE_2DIGIT varchar(2), 
 ALPHA_CODE_3DIGIT varchar(3), 
 NUMERIC_COUNTRY_CODE integer,
 ISO_SUBDIVISION varchar(15), 
 INTERNET_DOMAIN_CODE varchar(10)
);

#1.1

CREATE OR REPLACE FILE FORMAT INTL_DB.PUBLIC.PIPE_DBLQUOTE_HEADER_CR 
  TYPE = 'CSV' 
  COMPRESSION = 'AUTO' 
  FIELD_DELIMITER = '|' 
  RECORD_DELIMITER = '\r' 
  SKIP_HEADER = 1 
  FIELD_OPTIONALLY_ENCLOSED_BY = '\042' 
  TRIM_SPACE = FALSE 
  ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
  ESCAPE = 'NONE' 
  ESCAPE_UNENCLOSED_FIELD = '\134'
  DATE_FORMAT = 'AUTO' 
  TIMESTAMP_FORMAT = 'AUTO' 
  NULL_IF = ('\\N');

#📓 Learning about Code Checks Using Metadata

#1.0

SELECT count(*) as FOUND, '249' as EXPECTED 
FROM INTL_DB.PUBLIC.INT_STDS_ORG_3661; 

#1.1

select row_count
from <database name>.INFORMATION_SCHEMA.TABLES 
where table_schema=<schema name> 
and table_name= <table name>;

#1.2

select count(*) as OBJECTS_FOUND
from INTL_DB.INFORMATION_SCHEMA.TABLES 
where table_schema='PUBLIC'
and table_name= 'INT_STDS_ORG_3661';

#✔️ Code Checkpoint 1

#1.0

SELECT 
 'SMEW01_ISO_TABLE_EXISTS' as step
 ,(select count(*) from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'INT_STDS_ORG_3661') as actual
 ,1 as expected
 ,'Check if table exists.' as description
UNION ALL
SELECT 
  'SMEW02_ISO_TABLE_HAS_ROWS' as step
 ,(select row_count from INTL_DB.INFORMATION_SCHEMA.TABLES where table_name = 'INT_STDS_ORG_3661') as actual
 ,249 as expected
 ,'Check if table has the correct number of rows.' as description 

#🥋 Join Shared Data with Local Data

#1.0

SELECT  
    iso_country_name, 
    country_name_official,
    alpha_code_2digit,
    r_name as region
FROM INTL_DB.PUBLIC.INT_STDS_ORG_3661 i
LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION n
ON UPPER(i.iso_country_name)=n.n_name
LEFT JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION r
ON n_regionkey = r_regionkey;

#🎯 Create a Few More Tables and Load Them

#1.0

CREATE TABLE INTL_DB.PUBLIC.CURRENCIES 
(
  CURRENCY_ID INTEGER, 
  CURRENCY_CHAR_CODE varchar(3), 
  CURRENCY_SYMBOL varchar(4), 
  CURRENCY_DIGITAL_CODE varchar(3), 
  CURRENCY_DIGITAL_NAME varchar(30)
)
  COMMENT = 'Information about currencies including character codes, symbols, digital codes, etc.';

#1.1

CREATE TABLE INTL_DB.PUBLIC.COUNTRY_CODE_TO_CURRENCY_CODE 
  (
    COUNTRY_CHAR_CODE Varchar(3), 
    COUNTRY_NUMERIC_CODE INTEGER, 
    COUNTRY_NAME Varchar(100), 
    CURRENCY_NAME Varchar(100), 
    CURRENCY_CHAR_CODE Varchar(3), 
    CURRENCY_NUMERIC_CODE INTEGER
  ) 
  COMMENT = 'Many to many code lookup table';
  
#1.2

CREATE FILE FORMAT INTL_DB.PUBLIC.CSV_COMMA_LF_HEADER
  TYPE = 'CSV'
  COMPRESSION = 'AUTO' 
  FIELD_DELIMITER = ',' 
  RECORD_DELIMITER = '\n' 
  SKIP_HEADER = 1 
  FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' 
  TRIM_SPACE = FALSE 
  ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
  ESCAPE = 'NONE' 
  ESCAPE_UNENCLOSED_FIELD = '\134' 
  DATE_FORMAT = 'AUTO' 
  TIMESTAMP_FORMAT = 'AUTO' 
  NULL_IF = ('\\N');

#🎯 Create A View

#1.0

SELECT COUNTRY_CHAR_CODE AS CITY_CODE, CURRENCY_CHAR_CODE AS CUR_CODE FROM"INTL_DB"."PUBLIC"."COUNTRY_CODE_TO_CURRENCY_CODE";

#1.1

SELECT * FROM SIMPLE_CURRENCY;

#✔️ Code Checkpoint 2

#1.0

select 'iso table' as "Table or View Checked", count(*) from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'INT_STDS_ORG_3661'
UNION ALL
select 'currencies table', count(*) from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'CURRENCIES'
UNION ALL
select 'code to code table', count(*) from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'COUNTRY_CODE_TO_CURRENCY_CODE'
UNION ALL
select 'nations+iso view', count(*) from INTL_DB.INFORMATION_SCHEMA.VIEWS where table_schema = 'PUBLIC' and table_name = 'NATIONS_SAMPLE_PLUS_ISO'
UNION ALL
select 'simple currency view', count(*) from INTL_DB.INFORMATION_SCHEMA.VIEWS where table_schema = 'PUBLIC' and table_name = 'SIMPLE_CURRENCY'
;

#1.1

select 'iso table - 249 expected' as "Table or View - Count Expected", row_count from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'INT_STDS_ORG_3661'
UNION ALL
select 'currencies table - 151 expected', row_count from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'CURRENCIES'
UNION ALL
select 'code to code table - 265 expected ', row_count from INTL_DB.INFORMATION_SCHEMA.TABLES where table_schema = 'PUBLIC' and table_name = 'COUNTRY_CODE_TO_CURRENCY_CODE'
UNION ALL
select 'nations+iso view - 249 expected', count(*) from INTL_DB.PUBLIC.NATIONS_SAMPLE_PLUS_ISO 
UNION ALL
select 'simple currency view - 265 expected', count(*) from INTL_DB.PUBLIC.SIMPLE_CURRENCY 
;

#
# Finished
#