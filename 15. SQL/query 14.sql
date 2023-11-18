/*
14. Составьте список уникальных номеров сотрудников, которые работают в компаниях, отобранных в предыдущем задании.
*/

WITH id_company AS 
(SELECT id
 FROM company
 WHERE status = 'closed'
    AND id IN (SELECT company_id
               FROM funding_round
               WHERE is_first_round = 1
                 AND is_last_round = 1))
SELECT id
FROM people
WHERE company_id IN (SELECT * 
                     FROM id_company)
