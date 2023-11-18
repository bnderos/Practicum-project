/*
22. Отберите данные по месяцам с 2010 по 2013 год, когда проходили инвестиционные раунды. 
Сгруппируйте данные по номеру месяца и получите таблицу, в которой будут поля:
 - номер месяца, в котором проходили раунды;
 - количество уникальных названий фондов из США, которые инвестировали в этом месяце;
 - количество компаний, купленных за этот месяц;
 - общая сумма сделок по покупкам в этом месяце.
*/

WITH 
cnt_fund_usa AS
    (SELECT EXTRACT(MONTH FROM fr.funded_at) AS month,
            COUNT(DISTINCT f.name) AS cnt_fund
    FROM funding_round AS fr
    LEFT JOIN investment AS i ON fr.id=i.funding_round_id
    LEFT JOIN fund AS f ON i.fund_id=f.id
    WHERE f.country_code = 'USA'
            AND fr.funded_at BETWEEN '2010-01-01' AND '2013-12-31'
    GROUP BY month),
cnt_com AS
    (SELECT EXTRACT(MONTH FROM acquired_at) AS month,
           COUNT(acquired_company_id) AS cnt_acqrd,
           SUM(price_amount) AS total_amount
    FROM acquisition
    WHERE acquired_at BETWEEN '2010-01-01' AND '2013-12-31'
    GROUP BY month)

SELECT cnt_fund_usa.month,
       cnt_fund_usa.cnt_fund,
       cnt_com.cnt_acqrd,
       cnt_com.total_amount
FROM cnt_fund_usa
JOIN cnt_com ON cnt_fund_usa.month=cnt_com.month
