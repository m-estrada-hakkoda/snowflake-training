#Same logic;
;

SELECT
    COUNT(*)
FROM 
    ORDERS
WHERE
    o_orderstatus IN ('P','O');


SELECT
    COUNT(*)
FROM 
    ORDERS
WHERE
    o_orderstatus = 'P'
    OR
    o_orderstatus = 'O';