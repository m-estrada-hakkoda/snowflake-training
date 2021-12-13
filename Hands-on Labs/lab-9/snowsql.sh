#Using direct SnowSQL
snowsql -a ht48847.canada-central.azure -u miguel_estrada_sbx;

GET @%region file:////Users/miguelestradam36/Documents;

REMOVE @%region;

SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."REGION" AS r JOIN "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."NATION" AS n ON r.r_regionkey = n.n_regionkey;

CREATE OR REPLACE STAGE BEETLE_STAGE;

COPY INTO @BEETLE_STAGE FROM (SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."REGION" AS r JOIN "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."NATION" AS n ON r.r_regionkey = n.n_regionkey);

LIST @BEETLE_STAGE;

GET @BEETLE_STAGE file:///Users/miguelestradam36/Documents;

REMOVE @BEETLE_STAGE;

DROP STAGE BEETLE_STAGE;