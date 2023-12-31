# Исследование надежности заемщиков.
## Описание проекта
Заказчик — кредитный отдел банка. Нужно разобраться, влияет ли семейное положение и количество детей клиента на факт погашения кредита в срок. Входные данные от банка — статистика о платёжеспособности клиентов.    
Результаты исследования будут учтены при построении модели кредитного скоринга — специальной системы, которая оценивает способность потенциального заёмщика вернуть кредит банку.
## Инструменты
<code>Python, Pandas</code>
## Описание данных     
+ children — количество детей в семье
+ days_employed — общий трудовой стаж в днях
+ dob_years — возраст клиента в годах
+ education — уровень образования клиента
+ education_id — идентификатор уровня образования
+ family_status — семейное положение
+ family_status_id — идентификатор семейного положения
+ gender — пол клиента
+ income_type — тип занятости
+ debt — имел ли задолженность по возврату кредитов
+ total_income — ежемесячный доход
+ purpose — цель получения кредита
## Общий вывод    
В общем какие выводы можно сделать? Сильно болших просадок в показателях не выявлено.Но при совмещении двух и более категорий мохно делать оценку о выдаче кредита. То есть человеку в гражданском браке с 4 детьми, зарплатой ниже 30000, кредит на образование или автомобиль лучше не давать. А вдовцу/вдове без детей с зарплатой 30000-50000 на покупку жилья - вариант неплохой. Я имею ввиду, что чем больше категорий совпадет - тем точнее будет оценка.
