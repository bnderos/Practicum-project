
SELECT c.name,
       EXTRACT(MONTH FROM funded_at)
FROM company AS c
LEFT JOIN funding_round AS fr ON c.id=fr.company_id
WHERE category_code = 'social'
        AND raised_amount > 0
        AND funded_at BETWEEN '2010-01-01' AND '2013-12-31'