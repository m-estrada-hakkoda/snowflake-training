CREATE DATABASE BEETLE_CLASSIFIED_DB;

GRANT USAGE ON DATABASE BEETLE_CLASSIFIED_DB
TO ROLE BEETLE_CLASSIFIED;
GRANT USAGE ON ALL SCHEMAS IN DATABASE BEETLE_CLASSIFIED_DB
TO ROLE BEETLE_CLASSIFIED;
GRANT CREATE TABLE ON ALL SCHEMAS IN DATABASE BEETLE_CLASSIFIED_DB 
TO ROLE BEETLE_CLASSIFIED;