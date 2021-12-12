CREATE VIEW orders_view(status, date, price) AS
  SELECT status, date, SUM(price) FROM my_orders
  GROUP BY status, date;
  
CREATE SECURE VIEW s_orders_view(status, date, price) AS
  SELECT status, date, SUM(price) FROM my_orders
  GROUP BY status, date;
  
CREATE MATERIALIZED VIEW m_orders_view(status, date, price) AS
  SELECT status, date, SUM(price) FROM my_orders
GROUP BY status, date;

CREATE SECURE MATERIALIZED VIEW sm_view
  AS SELECT first_name, last_name FROM BEETLE_SCHEMA.members;