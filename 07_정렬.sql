-- 07_����.sql

/*
    # ORDER BY
    
        - ���ϴ� �÷� �������� �����Ͽ� ��ȸ�ϴ� ����
        - ORDER BY �÷��� [ASC | DESC]
        - ASC : �������� (Ascending)
        - DESC : �������� (Descending)
*/
-- DESC : ��������
SELECT * FROM employees ORDER BY hire_date DESC;

SELECT * FROM employees ORDER BY salary DESC;

-- ASC : ��������, ��������
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary;

-- null�� �������� �������� ���� ���� �����Ѵ�.
SELECT * FROM employees ORDER BY commission_pct DESC;

--null�� �������� �������� ���� ���߿� �����Ѵ�.
SELECT * FROM employees ORDER BY commission_pct ASC;

-- ���� ������ ������ ������ ���� �ִ�.
-- ex) ��å �������� �������� �����ϵ�, ���� ��å�� ��� �����ȣ ���� �������� ����
SELECT
    employee_id,
    first_name,
    salary,
    job_id
FROM
    employees
ORDER BY
    job_id DESC,
    employee_id;
    
-- ���� 1 : �̸��� i�� ���ԵǾ� �ִ� ������� �� ���� �޴� ������� ��ȸ (�̸��� i�� �����ϴ� ����� ����)
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    lower(first_name) LIKE '%i%'
ORDER BY
    salary DESC;
    
SELECT
    first_name || ' ' || last_name AS full_name,
    salary
FROM
    employees
WHERE
    lower(first_name || ' ' || last_name) LIKE '%i%'
ORDER BY
    salary DESC;
    
-- ���� 2 : ��� ������� last_name �������� �������� ����,
--             ���� last_name�� ��� frist_name���� �������� ����
SELECT
    last_name,
    first_name,
    first_name || ' ' || last_name AS full_name
FROM
    employees
ORDER BY
    last_name,
    first_name;

-- WHERE���� �׷� �Լ��� ������ �ο��Ҽ� ������ HAVING���� �׷� �Լ��� ������ �ο��� �ش�.
SELECT job_id, count(salary) FROM employees WHERE salary <= 3000 GROUP BY job_id HAVING count(salary) >= 10;