-- 5. Выведите на экран всю информацию о людях, у которых названия аккаунтов в поле network_username содержат подстроку 'money', а фамилия начинается на 'K'.    
        
SELECT *
FROM people
WHERE twitter_username LIKE '%money%'
        AND last_name LIKE 'K%'
