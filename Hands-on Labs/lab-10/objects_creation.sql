CREATE OR REPLACE TABLE AVG_SHIPPING_IN_DAYS
(yr INTEGER, 
mon INTEGER, 
avg_shipping_days DECIMAL(18,2));

CREATE OR REPLACE TABLE SHIPPING_BY_DATE 
(orderdate DATE, 
shipdate DATE, 
daystoship DECIMAL(18,2));

CREATE OR REPLACE TABLE year_month(id integer autoincrement(1,1), yr INTEGER, mon INTEGER);
INSERT INTO year_month(yr, mon) VALUES (1992, 1);
SELECT * FROM year_month;