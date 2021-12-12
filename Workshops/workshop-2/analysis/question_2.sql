SELECT 
    DAY , 
    (SUM(VOLUME)/COUNT(VOLUME))::integer as average_volume, 
    MAX(VOLUME) as max_volume, 
    MIN(VOLUME) as min_volume, 
    (SUM(OPEN_STOCK)/COUNT(OPEN_STOCK))::integer as average_open, 
    (SUM(CLOSE_STOCK)/COUNT(CLOSE_STOCK))::integer as average_close 
    FROM "STOCKS" 
        group by day 
        order by average_volume  desc;