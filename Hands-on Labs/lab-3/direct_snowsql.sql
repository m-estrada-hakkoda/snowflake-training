#Select Warehouse
;

USE WAREHOUSE "BEETLE_WH";

#Try to create database
;

CREATE DATABASE IF NOT EXISTS BEETLE_DB;
USE DATABASE BEETLE_DB;

#Renew table BEETLE_TBL 
;

CREATE OR REPLACE TABLE BEETLE_DB.PUBLIC.BEETLE_TBL (
id NUMBER(38,0),
name STRING(10),
country VARCHAR(20),
order_date DATE);

#Using snowSQL to insert data
;

INSERT INTO [avatar]_TBL VALUES(2, 'A','UK', '11/02/2005');
INSERT INTO [avatar]_TBL VALUES(4, 'C','SP', '11/02/2005');
INSERT INTO [avatar]_TBL VALUES(3, 'C','DE', '11/02/2005');

#Doing query with order by
;

SELECT * FROM BEETLE_TBL ORDER BY id;

#Usage of the BEETLE_SCHEMA
;

INSERT INTO BEETLE_SCHEMA.members
VALUES(103, 'Barbra', 'Streisand', '10/05/2019', 'silver'),
      (95, 'Ray', 'Bradbury', '06/06/2006', 'bronze'),
      (111, 'Daenerys', 'Targaryen', '2/4/2019', 'gold'),
      (87, 'Homer', 'Simpson', '3/1/1998', 'gold');

#Confirm inserted data
;

SELECT * FROM BEETLE_SCHEMA.members;

#How to exit SnowSQL ?
;

!exit