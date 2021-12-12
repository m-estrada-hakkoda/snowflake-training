SELECT 
    * , 
    (HIGH_STOCK - LOW_STOCK)::float as volatility 
    FROM "STOCKS" 
        where symbol = 'AMZN' 
        order by volatility 
        DESC LIMIT 1;