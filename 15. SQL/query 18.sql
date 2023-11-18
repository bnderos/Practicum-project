/*
18. Напишите похожий запрос: выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники Facebook.
*/

WITH id_facebook AS 
(SELECT id
 FROM company
 WHERE name = 'Facebook')
  
SELECT AVG(inst_cnt)
FROM
(SELECT DISTINCT 
       p.id,
       COUNT(e.instituition) OVER(PARTITION BY p.id) AS inst_cnt
FROM people AS p
JOIN education AS e ON p.id=e.person_id
WHERE p.company_id IN (SELECT * 
                       FROM id_facebook)) AS id_inst_cnt
