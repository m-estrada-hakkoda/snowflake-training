#🥋 Create a Local Database and Warehouse

#1.1
USE ROLE SYSADMIN;
CREATE DATABASE INTL_DB;
USE SCHEMA INTL_DB.PUBLIC;

#1.2
CREATE WAREHOUSE INTL_WH 
WITH WAREHOUSE_SIZE = 'XSMALL' 
WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 600 
AUTO_RESUME = TRUE;
USE WAREHOUSE INTL_WH;

#🥋 Create a Table and Load Itcurrent section



#🔍 Prepare for a Code Checkpoint

#📓 Learning about Code Checks Using Metadata

#✔️ Code Checkpoint 1

#🥋 Join Shared Data with Local Data

#🎯 Create a Few More Tables and Load Them

#🎯 Create A View

#✔️ Code Checkpoint 2