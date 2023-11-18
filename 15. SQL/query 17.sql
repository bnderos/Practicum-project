
WITH id_comp_close AS 
(SELECT id
 FROM company
 WHERE status = 'closed'
    AND id IN (SELECT company_id
               FROM funding_round
               WHERE is_first_round = 1
                 AND is_last_round = 1))
  
SELECT AVG(inst_cnt)
FROM
(SELECT DISTINCT 
       p.id,
       COUNT(e.instituition) OVER(PARTITION BY p.id) AS inst_cnt
FROM people AS p
JOIN education AS e ON p.id=e.person_id
WHERE p.company_id IN (SELECT * 
                       FROM id_comp_close)) AS id_inst_cnt