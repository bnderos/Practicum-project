
WITH
com_ing AS
    (SELECT a.id,
            c.name AS com_acquiring,
            a.price_amount AS purchase_price
    FROM acquisition AS a
    LEFT JOIN company AS c ON a.acquiring_company_id=c.id
    WHERE a.price_amount > 0),
com_red AS
    (SELECT a.id,
           c.name AS com_acquired,
           c.funding_total AS invest_amount
    FROM acquisition AS a
    LEFT JOIN company AS c ON a.acquired_company_id=c.id
    WHERE c.funding_total > 0)
    
SELECT com_ing.com_acquiring,
       com_ing.purchase_price,
       com_red.com_acquired,
       com_red.invest_amount,
       ROUND(com_ing.purchase_price / com_red.invest_amount) AS times
FROM com_ing
JOIN com_red ON com_ing.id=com_red.id
ORDER BY com_ing.purchase_price DESC, com_red.com_acquired
LIMIT 10;