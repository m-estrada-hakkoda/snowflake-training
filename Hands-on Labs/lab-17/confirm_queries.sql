SELECT query_id,query_text, warehouse_size,(execution_time / 1000) Time_in_seconds 
FROM TABLE(information_schema.query_history_by_session())
WHERE query_tag = 'BEETLE_WH_Sizing'
AND WAREHOUSE_SIZE IS NOT NULL
AND QUERY_TYPE LIKE 'SELECT' ORDER BY start_time DESC;

SELECT query_id,query_text, warehouse_size,(execution_time / 1000) Time_in_seconds, 
    partitions_total, partitions_scanned,
    bytes_spilled_to_local_storage, bytes_spilled_to_remote_storage,
    query_load_percent
  FROM "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY"
  WHERE query_tag = 'BEETLE_WH_Sizing'
  AND WAREHOUSE_SIZE IS NOT NULL
  AND QUERY_TYPE LIKE 'SELECT' ORDER BY start_time DESC;