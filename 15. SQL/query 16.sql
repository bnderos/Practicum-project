/*
16. Посчитайте количество учебных заведений для каждого сотрудника из предыдущего задания. 
При подсчёте учитывайте, что некоторые сотрудники могли окончить одно и то же заведение дважды.
*/

WITH id_company AS 
(SELECT id
 FROM company
 WHERE status = 'closed'
    AND id IN (SELECT company_id
               FROM funding_round
               WHERE is_first_round = 1
                 AND is_last_round = 1))
SELECT DISTINCT 
       p.id,
       COUNT(e.instituition) OVER(PARTITION BY p.id)
FROM people AS p
JOIN education AS e ON p.id=e.person_id
WHERE p.company_id IN (SELECT * 
                     FROM id_company)
