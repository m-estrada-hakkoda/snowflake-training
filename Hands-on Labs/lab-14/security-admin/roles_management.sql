


CREATE ROLE BEETLE_CLASSIFIED;
CREATE ROLE BEETLE_GENERAL;


GRANT ROLE BEETLE_CLASSIFIED, BEETLE_GENERAL TO ROLE SYSADMIN;
GRANT ROLE BEETLE_CLASSIFIED, BEETLE_GENERAL TO USER BEETLE;