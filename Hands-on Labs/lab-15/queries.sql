#1.0;
;

SELECT * FROM isd_2019_total
LIMIT 10;

#1.1;
;

SELECT v, key, value FROM isd_2019_total w,
LATERAL FLATTEN (input => w.v)
LIMIT 10;

#1.1.1;
;

Apply here last query description;
;

#1.2;
;

SELECT v:data.observations[0].dt AS time,
       v:station.name AS station,
       v:station.country AS country,
       v:station.elev AS elevation,
       v:data.observations[0].air.temp AS temp_celsius,
       v:data.observations[0].air."dew-point" AS dew_point,
       v:data.observations[0].wind."speed-rate" AS wind_speed
FROM weather.isd_2019_total
LIMIT 10;

#1.3;
;

SELECT v:data.observations[0].dt AS time,
       v:station.name AS station,
       v:station.country AS country,
       v:station.elev AS elevation,
       v:data.observations[0].air.temp AS temp_celsius,
       v:data.observations[0].air."dew-point" AS dew_point,
       v:data.observations[0].wind."speed-rate" AS wind_speed
FROM weather.isd_2019_total
LIMIT 10;

Apply here last query description;
;

SELECT v:station.name::VARCHAR AS station,
       v:station.country::VARCHAR AS country,
       v:data.observations[0].air.temp::NUMBER(38,1) AS temp_celsius
FROM weather.isd_2019_total
WHERE country = 'FR';

SELECT v:station.name::VARCHAR AS station,
       v:station.country::VARCHAR AS country,
       v:data.observations[0].air.temp::NUMBER(38,1) AS temp_celsius
FROM weather.isd_2019_total
WHERE country = 'FR' 
AND v:data.observations[0].air."temp-quality-code" = '1';

SELECT v:data.observations[0].air.temp::NUMBER(38,1) AS temp_celsius,
       v:data.observations[0].dt::DATE AS date
FROM weather.isd_2019_total
WHERE date >= to_date('2019-08-14') AND date <= to_date('2019-08-21')
    AND v:data.observations[0].air."temp-quality-code" = '1'
ORDER BY date;

SELECT v:station.country::VARCHAR AS country,
       v:station.name::VARCHAR AS station,
       MAX(v:data.observations[0].air.temp)::NUMBER(38,1) AS max_celsius
FROM weather.isd_2019_total
WHERE v:data.observations[0].dt::date >= to_date('2019-08-14')
    AND v:data.observations[0].dt::date <= to_date('2019-08-16')
    AND v:data.observations[0].air."temp-quality-code" = '1'
GROUP BY country, station;

SELECT v:station.country::VARCHAR AS country,
       v:station.name::VARCHAR AS station,
       MAX(v:data.observations[0].air.temp) AS max_celsius,
       (MAX(v:data.observations[0].air.temp) * 9/5 + 32) AS max_fahrenheit
FROM weather.isd_2019_total
WHERE v:data.observations[0].dt::date >= to_date('2019-08-14')
    AND v:data.observations[0].dt::date <= to_date('2019-08-16')
    AND v:data.observations[0].air."temp-quality-code" = '1'
GROUP BY country, station;

SELECT * FROM isd_2019_daily
LIMIT 10;

SELECT t, v:station.name, v AS variant
FROM weather.isd_2019_daily
LIMIT 10;

SELECT weather.t as date,
       weather.v:station.name::VARCHAR AS station,
       weather.v:station.country::VARCHAR AS country,
       observations.value:air.temp::NUMBER(38,1) AS temp_celsius,
       observations.value:dt::timestamp_ntz AS time
FROM weather.isd_2019_daily weather,
LATERAL FLATTEN(input => v:data.observations) observations
LIMIT 100;

SELECT weather.t as date,
       weather.v:station.name::VARCHAR AS station,
       weather.v:station.country::VARCHAR AS country,
       AVG(observations.value:air.temp)::NUMBER(38,1) as avg_temp_c,
       MIN(observations.value:air.temp) as min_temp_c,
       MAX(observations.value:air.temp) as max_temp_c,
       (AVG(observations.value:air.temp) * 9/5 + 32)::NUMBER(38,1) as avg_temp_f,
       (MIN(observations.value:air.temp) * 9/5 + 32) as min_temp_f,
       (MAX(observations.value:air.temp) * 9/5 + 32) as max_temp_f
FROM weather.isd_2019_daily weather,
LATERAL FLATTEN(input => v:data.observations) observations
WHERE observations.value:air."temp-quality-code" = '1'
    AND date >= to_date('2019-08-14') AND date <= to_date('2019-08-21')
GROUP BY country, date, station;