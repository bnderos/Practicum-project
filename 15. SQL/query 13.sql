
SELECT DISTINCT name
FROM company
WHERE status = 'closed'
        AND id IN (SELECT company_id
                   FROM funding_round
                   WHERE is_first_round = 1
                      AND is_last_round = 1)