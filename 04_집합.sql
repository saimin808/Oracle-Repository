-- 04_집합.sql

SELECT * FROM employees WHERE last_name LIKE 'A%';
SELECT * FROM employees WHERE last_name LIKE '%e';

-- INTERSECT  : 교집합
SELECT * FROM employees WHERE last_name LIKE 'A%'
INTERSECT
SELECT * FROM employees WHERE last_name LIKE '%e';

-- UNION : 합집합 (중복 제거 O)
SELECT * FROM employees WHERE last_name LIKE 'A%'
UNION
SELECT * FROM employees WHERE last_name LIKE '%e';

-- UNION ALL : 합집합 (중복 제거X)
SELECT * FROM employees WHERE last_name LIKE 'A%'
UNION ALL
SELECT * FROM employees WHERE last_name LIKE '%e';

-- MINUS : 차집합
SELECT * FROM employees WHERE last_name LIKE 'A%'
MINUS
SELECT * FROM employees WHERE last_name LIKE '%e';

SELECT * FROM employees WHERE last_name LIKE '%e'
MINUS
SELECT * FROM employees WHERE last_name LIKE 'A%';