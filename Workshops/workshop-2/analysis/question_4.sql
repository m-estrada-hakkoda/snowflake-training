#Risk perspective;
;
SELECT SYMBOL,
    SUM(VOLUME) AS TOTAL_VOLUME, 
    AVG(VOLUME) AS AVG_VOLUME, 
    MAX(VOLUME) AS MAX_VOLUME, 
    MIN(VOLUME) AS MIN_VOLUME, 
    (SUM(OPEN_STOCK)/COUNT(OPEN_STOCK))::float AS AVERGAE_OPEN_STOCK, 
    (SUM(CLOSE_STOCK)/COUNT(CLOSE_STOCK))::float AS AVERGAE_CLOSE_STOCK, 
    ((SUM(HIGH_STOCK)/COUNT(HIGH_STOCK)) - (SUM(LOW_STOCK)/COUNT(LOW_STOCK)))::float AS VOLATILITY
    FROM "STOCKS"
    WHERE DATE >= '2014-01-02'::timestamp_ltz AND DATE <= '2017-12-29'::timestamp_ltz
    GROUP BY SYMBOL
    ORDER BY VOLATILITY ASC, TOTAL_VOLUME ASC;
;

#Getting information for calculus;
;

SELECT * FROM "BEETLE_WORKSHOPS"."PUBLIC"."STOCKS"
    WHERE DATE IN ('2017-12-29'::timestamp_ltz, '2014-01-02'::timestamp_ltz) AND SYMBOL = 'HBAN';
