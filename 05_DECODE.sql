-- 05_DECODE.sql

/*
    # DECODE
        
        - decode (column, case1, value1, case2, value2 ...)
        - swith-case�� ������
        - code -> display name
    
*/

SELECT * FROM employees;
SELECT * FROM departments;

SELECT
    first_name,
    job_id,
    department_id,
    decode( department_id,
    10,'Administration',
    20, 'Marketing',
    30, 'Purchasing',
    90, 'Executive',
    60, 'IT',
    'Not yet implemented') AS department_name
FROM
    employees;
    
/*
    ���� 1 : ��å�� ���� �޿��� �λ��Ͽ� ����غ�����
    
        IT_PROG         : 5% �λ�
        FI_ACCOUNT  : 3% �λ�
        ��� CLERK    : 2% �λ�
    
    "�̸�/��å/�����޿�/�λ�� �޿�"�� ���
    ������ �޿��� before_salary��� �̸����� ���
    �λ�� �޿��� after_salary��� �̸����� ���
*/
SELECT job_id FROM employees;
SELECT
    first_name || ' ' || last_name       AS full_name,
    job_id,
    salary             AS before_salary,
    salary * decode(job_id, 'IT_PROG', 1.05, 'FI_ACCOUNT', 1.03, 'ST_CLERK', 1.02, 'SH_CLERK', 1.02, 'PU_CLERK', 1.02, 1) AS after_salary
FROM
    employees;
    
SELECT DISTINCT job_id FROM employees WHERE job_id LIKE '%_CLERK';

SELECT
    first_name,
    job_id,
    salary AS before_salary,
    decode(job_id,
    'IT_PROG', salary * 1.05,
    'FI_ACCOUNT', salary * 1.03,
    salary) AS After_salary
FROM
    employees
WHERE
    job_id NOT LIKE '%_CLERK'
UNION
SELECT
    first_name,
    job_id,
    salary AS before_salary,
    salary * 1.02 AS after_salary
FROM
    employees
WHERE
    job_id LIKE '%_CLERK';
    
/*

    # CASE
    
        - DECODE�� ��Ȯ�ϰ� �ش� �÷����� ��ġ�ϴ� ���� ��� �� �� ������
            CASE ������ ������ ����� �� �ִ�.
            
*/
SELECT
    first_name || ' ' || last_name AS "full_name",
    job_id,
    salary AS before_salary,
    CASE
        WHEN job_id = 'IT_PROG' THEN salary * 1.05
        WHEN job_id = 'FI_ACCOUNT' THEN salary * 1.03
        WHEN job_id LIKE '%_CLERK' THEN salary * 1.02
        ELSE salary
    END AS after_salary
FROM
    employees;