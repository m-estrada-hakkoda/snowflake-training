SELECT
(m.firstname || ' ' || m.lastname) as Name,
m.age,
m.state,
m.city,
m.started_date,
m.points_balance
FROM BASIC.members AS m;