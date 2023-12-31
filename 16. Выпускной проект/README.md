# Проект: "Телекоммуникации"     
## Описание проекта:  
Оператор связи «Ниединогоразрыва.ком» хочет научиться прогнозировать отток клиентов. Если выяснится, что пользователь планирует уйти, ему будут предложены промокоды и специальные условия. Команда оператора собрала персональные данные о некоторых клиентах, информацию об их тарифах и договорах.    
## Цель:   
построить модель для задачи классификации, которая спрогнозирует уход клиента     
**Основная метрика: AUC-ROC.**    
Дополнительная метрика: Accuracy.

**Критерии оценки:**    
•AUC-ROC >= 0.85    
## Описание данных:    
Данные состоят из файлов, полученных из разных источников:   

- contract_new.csv — информация о договоре;   
- personal_new.csv — персональные данные клиента;   
- internet_new.csv — информация об интернет-услугах;   
- phone_new.csv — информация об услугах телефонии.   

Во всех файлах столбец customerID содержит код клиента.  

Информация о договорах актуальна на 1 февраля 2020.    
### Признаки:   

contract_new.csv:    
- customerID - идентифакионный номер покупателя
- BeginDate - дата начала обслуживания 
- EndDate - дата окончания обслуживания
- Type - тип оплаты: месяц, год, два
- PaperlessBilling - безналичный расчет
- PaymentMethod - способ оплаты
- MonthlyCharges - ежемесячные траты на услуги
- TotalCharges - всего потрачено денег на услуги

personal_new.csv:  
- customerID - идентифакионный номер покупателя  
- gender - пол покупателя   
- SeniorCitizen	- наличие пенсионного статуса по возрасту 
- Partner -  наличие супруга(и)
- Dependents - наличие иждивенцев

internet_new.csv:  
- customerID - идентифакионный номер покупателя  
- InternetService - тип подключения
- OnlineSecurity - блокировка небезопасных сайтов 
- OnlineBackup - облачное хранилище файлов для резервного копирования данных
- DeviceProtection - защита устройства  
- TechSupport - линия технической поддержки
- StreamingTV - телевидение  
- StreamingMovies - каталог фильмов

phone_new.csv:
- customerID - идентифакионный номер покупателя  
- MultipleLines - наличие возможности ведения параллельных линий во время звонка
## План работы    

 1. Загрузка и изучение данных.       
    
   проверим:
   - стиль написания столбцов
   - соответствуют ли типы данных
   - дубликаты
   - дубликаты по id
   - пропуски
    
    
 2. Предобработка данных 
   - объединим таблицы по customerID
   - приведём названия столбцов к snake-case
   - создадим новый столбец(таргет) на основании значений EndDate 
   - создадим столбец продолжительности сотрудничества на разнице EndDate и BeginDate
   - заполним появившиеся пропуски
   - изменим типы данных
   - рассмотрим присутствие аномальных значений 
   - проверим признаки на мультиколлинеарность и при её наличии удалим лишние столбцы (в дальнейшем при подготовке данных для обучения моделей)

    
 3. Исследовательский анализ данных
   - визуализируем распределение признаков
   - через библиотеку "phik" посмотрим на корреляцию признаков и значимость коэффициентов
   - (возможно) рассмотрим зависимость таргета от других признаков при помощи сводных таблиц, матрицы корреляции или просто scatter
  
    
 4. Подготовка данных к обучению
   - удалим лишние столбцы (на основе полученных ранее результатов)
   - разобьём данные на выборки
   
    
 5. Обучение моделей
   - при помощи GridSearch подберём гиперпараметры для моделей, используя конвейер, в котором мы закодируем категориальные признаки и масштабируем числовые для некоторых моделей (насколько я помню, у CatBoost и Light встоенный кодировщик)
   - вычислим необходимые метрики
   - выберем лучшую модель

    
 6. Тестирование модели
  - протестируем лучшую модель на тестовой выборке
  - построим матрицу ошибок
  - проверим модель на адекватность
  
    
 7. Выводы
## Отчёт по решению    
### Загрузка и изучение данных    
1. Загрузили необходимые библиотеки т написали окно импортов  
    - там же прописали RANDOM_STATE = 280823
    
    
2. Загрузили данные    


3. Написали функцию для описания и просмотра данных и выяснили, что
   - пропусков нет
   - дубликаты отсутствуют
   - есть необходимость объединить таблицы
   - нужно привести названия столбцов к snake-case
   - нужно изменить тип данных "TotalCharges" на float
   - для исследовательского анализа можно привести типы в столбцах EndDate и BeginDate к дате
### Предобработка данных    
1. Объединили таблицы с помощью  merge с типом объединения "left".
    - проверили правильность объединения      
    
    
2. С помощью библиотеки clean_columns привели названия столбцов к snake-case   


3. Создали новый столбец (таргет) на основании значений EndDate с названием "gone"   
    - если присутствовала дата окончания обслуживания, то значение в целевом признаке ставили 1, в противном случае 0
    - проверили количество значений
    
    
4. Заменили значение "No" в EndDate на дату выгрузки данных, изменим тип данных на datetime и создали столбец продолжительности сотрудничества в днях на разнице дат с названием "collab_day"    


5. В результате слияния таблиц появились пропуски у клиентов, которые не пользуются данными услугами. Их, что логично, мы заполнили значением "No".    


6. При попытке изменения тина данных в столбце "total_charges", обнаружились 11 клиентов, которые только подключились и имели на месте значений пустые строки. Мы заменили значения на 0 и привели столбец к типу данных "float". Также изменили тип "oblect" на "category".
    - проверили корректность совершённых действий
### Исследовательский анализ данных    
На этом этапе работы мы выяснили, что:         


1. Распределение таргета не равномерно 6:1, тех кто не ушёл и тех кто ушёл     
2. Продолжительность сотрудничества зависит от типа договора    
    - дольше всего сотрудничают клиенты и которых тип договора оплаты на два года и меньше всего, у которых договор на ежемесячную оплату

![1](https://github.com/bnderos/Practicum-project/assets/143242792/26dff1ca-783e-4064-abad-314c84a7909f)    
3. В 2019 количество ушедших клиентов сильно увеличилось, видимо нашли более выгодное предложение      
4. Уходили в основном клиенты, которые пришли к оператору связи в самом начале

![2](https://github.com/bnderos/Practicum-project/assets/143242792/0a28e480-e7af-45f0-93f3-ebcdcaa2c6e3)       
5. Также выяснили, что люди состоящие в браке уходят гораздо чаще     
![3](https://github.com/bnderos/Practicum-project/assets/143242792/26b2e0c5-bc38-4ee0-acf0-7643b8fb1dae)      
6. Также выяснили, что среди тех, кто ушёл было много людей с высоким ежемесячным плптежом.      
![4](https://github.com/bnderos/Practicum-project/assets/143242792/772b6b8b-b68b-4940-983d-e8df1255fde7)     
7. С помощью библиотеки phik построили тепловую карту корреляции признаков     
    - перед этим удалили столбец "customer_id"
    - по которой выяснили, что присутствует мультиколлениарность фичей "monthly_charges" с "internet_service", "streaming_tv", "streaming_movies", а также "total_charges" с "collab_day"      
### Подготовка данных к обучению      
1. Мы удалили столбцы 'begin_date', 'end_date', так как на их основе был создан "collab_day". К тому же они не были нужны для анализа, учитывая, что мы не анализируем временные ряды.  


2. С помощью train_test_split разбили данные на выборки X_train, X_test, y_train, y_test с размером тестовой выборки равной 0.25 от начального датафрейма.   
    - проверили правильность разбиения


3. Создали списки категориальных и числовых признаков.

**В итоге для обучения у нас остались следующие признаки:**   

- Type - тип оплаты: месяц, год, два
- PaperlessBilling - безналичный расчет
- PaymentMethod - способ оплаты
- MonthlyCharges - ежемесячные траты на услуги
- TotalCharges - всего потрачено денег на услуги
- gender - пол покупателя   
- SeniorCitizen	- наличие пенсионного статуса по возрасту 
- Partner -  наличие супруга(и)
- Dependents - наличие иждивенцев
- InternetService - тип подключения
- OnlineSecurity - блокировка небезопасных сайтов 
- OnlineBackup - облачное хранилище файлов для резервного копирования данных
- DeviceProtection - защита устройства  
- TechSupport - линия технической поддержки
- StreamingTV - телевидение  
- StreamingMovies - каталог фильмов
- MultipleLines - наличие возможности ведения параллельных линий во время звонка   
- collan_day - столбец продолжительности сотрудничества в днях
### Обучение моделей      
Мы обучили четыре модели:    
+ модель логической регрессии  
+ модель решающего дерева
+ модель ансамбля деревьев    
+ модель градиентного бустинга       

Лучшей себя показала модель градиентного бустинга CatBoost с метрикой ROC-AUC = 0.908625.      
### Тестирование модели    
**На тестировании модель показала следующие результаты:**        
Показатели ROC-AUC модели CatBoost = 0.9148     
Показатели accuracy модели CatBoost = 0.9148       
Полнота = 0.5273    
Точность = 0.8788     
F-1 мера = 0.6591     
![5](https://github.com/bnderos/Practicum-project/assets/143242792/77255a33-8c34-40d1-807c-c3c1e6e13640)        
+ Полнота нашей модели имеет показатель 0.52 и показывает вероятность ухода клиента (доля TP-ответов среди всех, у которых истинная метка 1). 
+ Точность: модель предскажет уход клиента в почти 88% случаев. 
+ Также достигли неплохого результата площади под ROC-кривой — AUC-ROC = 0.9148, что больше 0.85.

**Учитывая тот факт, что нам нужно было спрогнозировать, уйдёт клиент в ближайшее время или нет,  данная модель вполне подойдёт.**     
**Также в дальнейшем для опрератора связи нужно больше обращать внимание на клиентов, которые могут уйти:**    
- у которых договор оплаты на месяц    
- клиенты с большой длительностью сотрудничества    
- состоящие в браке   
- с высоким ежемесячным платежом    
