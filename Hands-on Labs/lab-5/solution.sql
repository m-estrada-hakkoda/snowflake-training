# Query that uses Metadata Cache
;

SELECT MIN(l_orderkey), MAX(l_orderkey), COUNT(*) FROM lineitem;

# Query that does not uses Metadata Cache
;

SELECT l_returnflag, l_linestatus,
    SUM(l_quantity) AS sum_qty,
    SUM(l_extendedprice) AS sum_base_price,
    SUM(l_extendedprice * (l_discount)) AS sum_disc_price, SUM(l_extendedprice * (l_discount) * (1+l_tax))
   AS sum_charge,
    AVG(l_quantity) AS avg_qty,
    AVG(l_extendedprice) AS avg_price,
    AVG(l_discount) AS avg_disc,
    COUNT(*) as count_order
FROM lineitem
WHERE l_shipdate <= dateadd(day, 90, to_date('1998-12-01'))
GROUP BY l_returnflag, l_linestatus
ORDER BY l_returnflag, l_linestatus;

#Other queries used with different warehouses.
#Slightly different between them.
#---
;

SELECT l_returnflag, l_linestatus,
    SUM(l_quantity) AS sum_qty,
    SUM(l_extendedprice) AS sum_base_price,
    SUM(l_extendedprice * (l_discount)) AS sum_disc_price, SUM(l_extendedprice * (l_discount) * (1+l_tax))
    AS sum_charge,
    AVG(l_quantity) AS avg_qty,
    AVG(l_extendedprice) AS avg_price,
    AVG(l_discount) AS avg_disc,
    COUNT(*) as count_order
FROM lineitem
WHERE l_shipdate <= dateadd(day, 90, to_date('1998-12-01'))and l_extendedprice <= 20000
GROUP BY l_returnflag, l_linestatus
ORDER BY l_returnflag, l_linestatus;

#---
;

SELECT l_orderkey,
SUM(l_extendedprice*(l_discount)) AS revenue,
o_orderdate, o_shippriority
FROM customer, orders, lineitem
WHERE C_mktsegment = 'BUILDING'
  AND c_custkey = o_custkey
  AND l_orderkey = o_orderkey
  AND o_orderdate < to_date('1995-03-15')
  AND l_shipdate > to_date('1995-03-15')
GROUP BY l_orderkey, o_orderdate, o_shippriority
ORDER BY 2 DESC, o_orderdate
LIMIT 10;

#---
;