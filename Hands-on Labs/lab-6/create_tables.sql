CREATE TABLE permanent (id INT, first VARCHAR(20), last VARCHAR(30));
CREATE TEMPORARY TABLE temp
(id INT, first VARCHAR(20), last VARCHAR(30));
CREATE TRANSIENT TABLE transient
(id INT, first VARCHAR(20), last VARCHAR(30));

SHOW TABLES;

DROP TABLE transient;

INSERT INTO permanent
VALUES (1, 'Jarit', 'Johnson'),
(2, 'Shayla', 'Nguyen'),
(3, 'Peewee', 'Herman');

ALTER TABLE permanent
ADD COLUMN comments STRING;

DESCRIBE TABLE permanent;

ALTER TABLE permanent
MODIFY COLUMN comments
SET DATA TYPE VARCHAR(1000);

ALTER TABLE permanent DROP COLUMN comments;
ALTER TABLE permanent ADD COLUMN comments VARCHAR(1000);

CREATE TABLE my_orders AS
SELECT $1 AS key, $3 AS status, $4 AS price, $5 AS date, $6 AS priority
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS;

SELECT * FROM my_orders
LIMIT 10;

CREATE TABLE like_orders LIKE SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.ORDERS;

SELECT * FROM like_orders;
DROP TABLE like_orders;

CREATE OR REPLACE TABLE autoincDefault_demo 
(part_num integer AUTOINCREMENT, 
part_name varchar(30), 
restocking_fee number(8,2) DEFAULT 5.50 );


INSERT INTO autoincDefault_demo (part_name) values ('Wheel'), ('Tires');

CREATE TABLE members (
  id INT, first_name VARCHAR(20),
  last_name VARCHAR(30),
  member_since DATE,
  level VARCHAR(6));

INSERT INTO BEETLE_SCHEMA.members
VALUES (103, 'Barbra', 'Streisand', '10/05/2019', 'silver'), 
(95, 'Ray', 'Bradbury', '06/06/2006', 'bronze'),
(111, 'Daenerys', 'Targaryen', '2/4/2019', 'gold'),
(87, 'Homer', 'Simpson', '3/1/1998', 'gold');
