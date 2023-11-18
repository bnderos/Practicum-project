
SELECT funding_total
FROM company
WHERE category_code = 'news'
        AND country_code = 'USA'
ORDER by funding_total DESC