#Try my role;
;

USE ROLE BEETLE_CLASSIFIED;
SELECT * FROM BEETLE_CLASSIFIED_DB.SUPER_PRIVATE.SUPER_PRIVATE_MESSAGES;
SELECT * FROM "BEETLE_CLASSIFIED_DB"."READ_ONLY"."PILGRIM_AGE_ANALYSIS";

#Try training role;
;

USE ROLE TRAINING_ROLE;
SELECT * FROM BEETLE_CLASSIFIED_DB.SUPER_PRIVATE.SUPER_PRIVATE_MESSAGES;
SELECT * FROM "BEETLE_CLASSIFIED_DB"."READ_ONLY"."PILGRIM_AGE_ANALYSIS";
