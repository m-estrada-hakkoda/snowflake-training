SELECT SYMBOL, VOLUME, DATE
    FROM "STOCKS"
    WHERE VOLUME IN
        (select avg(volume) over (partition by symbol) from stocks);

SELECT SYMBOL, VOLUME, DATE
    FROM "STOCKS"
    WHERE VOLUME IN
        (select min(volume) over (partition by symbol) from stocks);

SELECT SYMBOL, VOLUME, DATE
    FROM "STOCKS"
    WHERE VOLUME IN
        (select max(volume) over (partition by symbol) from stocks);