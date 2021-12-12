#Revoking access to database;

revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role SYSADMIN;
revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role USERADMIN;
revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role SYSADMIN;
revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role PUBLIC;
revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role DATA_ENG;
revoke usage on all schemas in database BEETLE_CLASSIFIED_DB from role ACCOUNTADMIN;

revoke usage on schema "BEETLE_CLASSIFIED_DB"."SUPER_PRIVATE" from role TRAINING_ROLE;

grant select on future tables in schema BEETLE_CLASSIFIED_DB.READ_ONLY to role TRAINING_ROLE;
grant select on future views in schema BEETLE_CLASSIFIED_DB.READ_ONLY to role TRAINING_ROLE;
GRANT SELECT ON ALL tables IN SCHEMA BEETLE_CLASSIFIED_DB.READ_ONLY TO ROLE TRAINING_ROLE;
GRANT SELECT ON ALL views IN SCHEMA BEETLE_CLASSIFIED_DB.READ_ONLY TO ROLE TRAINING_ROLE;