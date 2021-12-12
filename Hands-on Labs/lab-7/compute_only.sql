SELECT (22+47+1184), 'My String', CURRENT_TIME();

SELECT (22+47+1184) AS sum, 'My String', CURRENT_TIME();

SELECT
  CASE
     WHEN RANDOM() > 0 THEN 'POSITIVE'
     WHEN RANDOM() < 0 THEN 'NEGATIVE'
     ELSE 'Zero'
   END,
   CASE
      WHEN RANDOM(2) > 0 THEN 'POSITIVE'
      WHEN RANDOM(2) < 0 THEN 'NEGATIVE'
      ELSE 'Zero'
   END;