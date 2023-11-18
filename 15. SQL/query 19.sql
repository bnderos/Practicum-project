/*
19. Составьте таблицу из полей:
 - name_of_fund — название фонда;
 - name_of_company — название компании;
 - amount — сумма инвестиций, которую привлекла компания в раунде.
В таблицу войдут данные о компаниях, в истории которых было больше шести важных этапов, а раунды финансирования проходили с 2012 по 2013 год включительно.
*/

SELECT f.name AS name_of_fund,
       c.name AS name_of_company,
       fr.raised_amount AS amount
FROM  investment AS i
JOIN company AS c ON i.company_id=c.id
JOIN fund AS f ON i.fund_id=f.id
JOIN funding_round AS fr ON i.funding_round_id=fr.id
WHERE c.milestones > 6 
        AND fr.funded_at BETWEEN '2012-01-01' AND '2013-12-31'
