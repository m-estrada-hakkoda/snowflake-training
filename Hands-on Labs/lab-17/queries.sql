--> Query;

SELECT cs_bill_customer_sk, cs_order_number, i_product_name, cs_sales_price, 
   SUM(cs_sales_price)
   OVER (PARTITION BY cs_order_number
         ORDER BY i_product_name
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) run_sum
FROM catalog_sales, date_dim, item
WHERE cs_sold_date_sk = d_date_sk
AND cs_item_sk = i_item_sk
AND d_year IN (2000) AND d_moy IN (1,2,3,4,5,6) 
LIMIT 100;

--> 17.5.0  Run a query showing the query history results for these performance tests using the INFORMATION_SCHMEA;


SELECT query_id,query_text, warehouse_size,(execution_time / 1000) Time_in_seconds 
FROM TABLE(information_schema.query_history_by_session())
WHERE query_tag = '[login]_WH_Sizing'
AND WAREHOUSE_SIZE IS NOT NULL
AND QUERY_TYPE LIKE 'SELECT' ORDER BY start_time DESC;