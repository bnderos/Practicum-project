/*
15. Составьте таблицу, куда войдут уникальные пары с номерами сотрудников из предыдущей задачи и учебным заведением, которое окончил сотрудник.
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
       e.instituition
FROM people AS p
JOIN education AS e ON p.id=e.person_id
WHERE p.company_id IN (SELECT * 
                     FROM id_company)
