SELECT (22+47+1184) AS sum,
 'My String' AS comment, CURRENT_TIME() AS time;

INSERT INTO test VALUES (2.00), (2.57), (4.50), (1.22);

SELECT CAST(num AS INTEGER) AS value FROM test;

USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCH_SF1;

SELECT r_regionkey, r_name, r_comment FROM region;

SELECT COUNT(DISTINCT r_name) FROM region;

SELECT DISTINCT r_name FROM region;

SELECT * FROM orders
LIMIT 10;

SELECT DISTINCT o_orderstatus FROM orders;

SELECT COUNT(*) FROM orders WHERE o_orderstatus='P';

SELECT COUNT(*) FROM orders WHERE o_orderstatus IN('P', 'O');

SELECT COUNT(*) FROM orders

WHERE o_orderstatus='P' OR o_orderstatus='O';

SELECT * FROM orders WHERE o_orderdate='1992-07-21';

SELECT * FROM ORDERS WHERE o_custkey =
 (SELECT c_custkey FROM customer WHERE c_acctbal=3942.58);

SELECT o_orderdate, SUM(o_totalprice) FROM orders
WHERE o_orderdate < '1998-01-01'
GROUP BY o_orderdate
ORDER BY o_orderdate DESC;

SELECT MIN(c_acctbal), MAX(c_acctbal), AVG(c_acctbal)
 FROM customer
 GROUP BY c_mktsegment;

CREATE TEMPORARY TABLE BEETLE_DB.PUBLIC.sum_acctbal AS
SELECT s_nationkey AS nationkey, SUM(s_acctbal) AS acctbal
 FROM supplier GROUP BY s_nationkey;

SELECT * FROM BEETLE_DB.PUBLIC.sum_acctbal WHERE acctbal
 > 2000000;
 
SELECT * FROM orders
ORDER BY o_orderpriority, o_totalprice DESC;

SELECT p_container, COUNT(p_container) AS count FROM part
GROUP BY p_container;

SELECT * FROM characters;

SELECT * FROM movies;

SELECT characters.id, characters.name, movies.title 
FROM characters
JOIN movies ON characters.id=movies.id;

SELECT * FROM characters
JOIN movies ON characters.id=movies.num;

SELECT * FROM characters
JOIN movies ON characters.name=movies.title;

SELECT * FROM characters
RIGHT OUTER JOIN movies ON characters.id = movies.num;

SELECT * FROM characters
FULL JOIN movies ON characters.id=movies.num;

USE ROLE TRAINING_ROLE;
USE SCHEMA BEETLE_DB.PUBLIC;
USE WAREHOUSE BEETLE_WH;

SELECT * FROM weekly_sales;

SELECT * FROM weekly_sales
 PIVOT (AVG(amount) FOR name IN ('Fred', 'Mark', 'Rita'));

USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCH_SF1;

SELECT * FROM orders WHERE o_custkey IN
 (SELECT c_custkey FROM customer
 WHERE c_nationkey=20);
 
SELECT * FROM lineitem WHERE l_orderkey IN
(SELECT o_orderkey FROM orders
 WHERE o_custkey = 4 AND o_orderstatus='P');
 
 SELECT * FROM lineitem WHERE l_extendedprice >
(SELECT MIN(price) FROM BEETLE_db.public.my_orders);