SELECT r_regionkey, r_name, r_comment FROM region;

SELECT COUNT(r_name) FROM (SELECT DISTINCT r_name FROM region);

#Select distintc values;
;

SELECT DISTINCT r_name FROM region;

#Same results in this context;
;

SELECT * FROM ORDERS LIMIT 10;
SELECT TOP 10 * FROM ORDERS;

SELECT
    *
FROM 
    ORDERS
WHERE
    o_orderdate = '1992-07-21';