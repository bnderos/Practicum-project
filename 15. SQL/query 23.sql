
WITH
reg_2011 AS
    (SELECT country_code AS country,
           AVG(funding_total) AS avg_2011
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2011
    GROUP BY country_code),
reg_2012 AS
    (SELECT country_code AS country,
           AVG(funding_total) AS avg_2012
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2012
    GROUP BY country_code),
reg_2013 AS
    (SELECT country_code AS country,
           AVG(funding_total) AS avg_2013
    FROM company
    WHERE EXTRACT(YEAR FROM founded_at) = 2013
    GROUP BY country_code)

SELECT reg_2011.country,
       reg_2011.avg_2011,
       reg_2012.avg_2012,
       reg_2013.avg_2013
FROM reg_2011
JOIN reg_2012 ON reg_2011.country=reg_2012.country
JOIN reg_2013 ON reg_2012.country=reg_2013.country
ORDER BY reg_2011.avg_2011 DESC