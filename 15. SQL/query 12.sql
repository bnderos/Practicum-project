/*
12. Для каждой компании найдите количество учебных заведений, которые окончили её сотрудники. 
Выведите название компании и число уникальных названий учебных заведений. Составьте топ-5 компаний по количеству университетов.
*/
SELECT c.name AS name_company,
       COUNT(DISTINCT e.instituition)
FROM company AS c
LEFT JOIN people AS p ON c.id=p.company_id
LEFT JOIN education AS e ON p.id=e.person_id
GROUP BY c.id
ORDER BY COUNT(DISTINCT e.instituition) DESC
LIMIT 5;
