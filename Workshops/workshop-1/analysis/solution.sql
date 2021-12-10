#Main analysis;

# Unable to perform (missing information):
# (Balance in Deposit Accounts) * (Net Margin between Interest Rates) + (Fees) + (Interest on Loans) - (Cost to serve);

#Extra analysis;

#Analysis by age;
SELECT CONCAT('$',SUM(PILGRIM.PROFIT))::string AS TOTAL_GROUP_PROFIT, 
        MODE(PILGRIM.INC) AS MODE_INCOME, 
        MODE(PILGRIM.DISTRICT) AS REGULAR_DISTRICT, 
        PILGRIM.AGE AS AGE, COUNT(PILGRIM.AGE) AS NUMBER_OF_PEOPLE, 
        CONCAT((SUM(PILGRIM.TERNURE) / COUNT(PILGRIM.TERNURE))::integer, ' days')::string AS TERNURE_AVERAGE 
    FROM "BEETLE_WORKSHOPS"."BEETLE_WORKSHOPS_SCHEMA"."WORKSHOP_1" AS PILGRIM
    GROUP BY AGE
    ORDER BY AGE DESC;