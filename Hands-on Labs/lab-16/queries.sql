CREATE TABLE lineitem_copy AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM;

CREATE TABLE lineitem_clone
CLONE lineitem_copy;

SELECT COUNT(*) FROM lineitem_copy;

SELECT COUNT(*) FROM lineitem_clone;

INSERT INTO lineitem_copy (l_comment, l_shipdate) values

('Insert 1 into COPY', '2020-01-01'),
('Insert 2 into COPY', '2020-01-02'),
('Insert 3 into COPY', '2020-01-03'),
('Insert 4 into COPY', '2020-01-04'),
('Insert 5 into COPY', '2020-01-05');

SELECT l_comment, l_shipdate
FROM lineitem_copy
WHERE l_shipdate > '2019-12-31';

SELECT l_comment, l_shipdate
FROM lineitem_copy
WHERE l_shipdate > '2019-12-31';

INSERT INTO lineitem_clone (l_comment, l_shipdate) values 
('Insert 6 into CLONE', '2020-01-01'),
('Insert 7 into CLONE', '2020-01-02'),
('Insert 8 into CLONE', '2020-01-03'),
('Insert 9 into CLONE', '2020-01-04'),
('Insert 10 into CLONE', '2020-01-05');

SELECT l_comment, l_shipdate 
FROM lineitem_clone
WHERE l_shipdate > '2019-12-31';

SELECT l_comment, l_shipdate FROM lineitem_copy
WHERE l_shipdate > '2019-12-31';

SELECT l_comment, l_shipdate
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1LINEITEM 
WHERE l_shipdate > '2019-12-31';

SELECT a.l_comment AS comment_copy, a.l_shipdate AS shipdate_copy,

b.l_comment AS comment_clone, b.l_shipdate AS shipdate_clone 
FROM lineitem_copy a
JOIN lineitem_clone b ON a.l_shipdate=b.l_shipdate 
WHERE a.l_shipdate > '2019-12-30';

