USE ROLE TRAINING_ROLE;
CREATE WAREHOUSE IF NOT EXISTS BEETLE_WH;
USE WAREHOUSE BEETLE_WH;
CREATE DATABASE IF NOT EXISTS BEETLE_DB;
USE BEETLE_DB.PUBLIC;

ALTER SESSION SET USE_CACHED_RESULT = FALSE;