DROP TABLE "BEETLE_WORKSHOPS"."BEETLE_WORKSHOPS_SCHEMA"."WORKSHOP_2";
CREATE OR REPLACE TABLE "STOCKS" LIKE "BEETLE_WORKSHOPS"."BEETLE_WORKSHOPS_SCHEMA"."WORKSHOP_2_ANALYSIS";
DROP TABLE "BEETLE_WORKSHOPS"."BEETLE_WORKSHOPS_SCHEMA"."WORKSHOP_2_ANALYSIS";


CREATE OR REPLACE SEQUENCE uniqueIDseq1;
ALTER TABLE "STOCKS" ADD COLUMN id int DEFAULT uniqueIDseq1.nextval;

INSERT INTO STOCKS (SYMBOL, DATE, DAY, OPEN_STOCK, LOW_STOCK, HIGH_STOCK, CLOSE_STOCK, VOLUME)
  SELECT
    SYMBOL, DATE, DAY, OPEN_STOCK, LOW_STOCK, HIGH_STOCK, CLOSE_STOCK, VOLUME
  FROM "BEETLE_WORKSHOPS"."BEETLE_WORKSHOPS_SCHEMA"."WORKSHOP_2_ANALYSIS";

SELECT * FROM STOCKS;