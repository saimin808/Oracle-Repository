-- 04_����.sql

SELECT * FROM employees WHERE last_name LIKE 'A%';
SELECT * FROM employees WHERE last_name LIKE '%e';

-- INTERSECT  : ������
SELECT * FROM employees WHERE last_name LIKE 'A%'
INTERSECT
SELECT * FROM employees WHERE last_name LIKE '%e';

-- UNION : ������ (�ߺ� ���� O)
SELECT * FROM employees WHERE last_name LIKE 'A%'
UNION
SELECT * FROM employees WHERE last_name LIKE '%e';

-- UNION ALL : ������ (�ߺ� ����X)
SELECT * FROM employees WHERE last_name LIKE 'A%'
UNION ALL
SELECT * FROM employees WHERE last_name LIKE '%e';

-- MINUS : ������
SELECT * FROM employees WHERE last_name LIKE 'A%'
MINUS
SELECT * FROM employees WHERE last_name LIKE '%e';

SELECT * FROM employees WHERE last_name LIKE '%e'
MINUS
SELECT * FROM employees WHERE last_name LIKE 'A%';