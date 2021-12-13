ALTER SESSION SET USE_CACHED_RESULT=FALSE;


EXPLAIN
SELECT c_customer_sk,
c_customer_id,
    c_last_name,
    (ca_street_number || ' ' || ca_street_name),
    ca_city,  ca_state
FROM customer, customer_address WHERE c_customer_id = ca_address_id
AND c_customer_sk between 100000 and 600000 ORDER BY ca_city, ca_state
LIMIT 10;


SELECT c_customer_sk,
       c_customer_id,
       c_last_name,
       (ca_street_number || ' ' || ca_street_name),
       ca_city,  ca_state
FROM customer, customer_address
WHERE c_customer_id = ca_address_id
AND c_customer_sk between 100000 and 600000 ORDER BY ca_city, ca_state
LIMIT 10;


EXPLAIN
SELECT c_customer_sk,
        c_customer_id,
        c_last_name,
        (ca_street_number || ' ' || ca_street_name),
ca_city, ca_state
FROM customer, customer_address
WHERE c_customer_id = ca_address_id
AND c_customer_sk between 100000 and 600000 ORDER BY ca_city, ca_state;


SELECT c_customer_sk,
c_customer_id,
c_last_name,
(ca_street_number || ' ' || ca_street_name),
ca_city,  ca_state
FROM customer, customer_address
WHERE c_customer_id = ca_address_id
AND c_customer_sk between 100000 and 600000
ORDER BY ca_city, ca_state;