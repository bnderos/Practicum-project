# 1. Посчитайте, сколько компаний закрылось.  
  
SELECT COUNT(DISTINCT id)
FROM company
WHERE status = 'closed'
