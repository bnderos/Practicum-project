
SELECT *,
       CASE
           WHEN invested_companies < 20 THEN 'low_activity'
           WHEN invested_companies >= 20 AND invested_companies <= 100 THEN 'middle_activity'
           ELSE 'high_activity'
       END
FROM fund;  