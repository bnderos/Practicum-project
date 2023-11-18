
SELECT f.name AS name_of_fund,
       c.name AS name_of_company,
       fr.raised_amount AS amount
FROM  investment AS i
JOIN company AS c ON i.company_id=c.id
JOIN fund AS f ON i.fund_id=f.id
JOIN funding_round AS fr ON i.funding_round_id=fr.id
WHERE c.milestones > 6 
        AND fr.funded_at BETWEEN '2012-01-01' AND '2013-12-31'