SELECT SYMBOL, VOLUME, DATE
    FROM "STOCKS"
    WHERE VOLUME IN
        (select max(volume) over (partition by symbol) from stocks);