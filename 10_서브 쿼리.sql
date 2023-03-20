-- 10_���� ����.sql

/*
    # ���� ����
    
        - �ϳ��� SELECT�� ���ο� ���Ե� �� �ϳ��� SELECT��
        - ���� ������ �����ϰ� �ִ� ������ ���� ������� �Ѵ�.
        - ���� ����� ���� ���� �� ���� ������ ���� �� ���� ������ �з��Ѵ�.
        
    # ���� �� ���� ����
    
        - ���� ������ ����� �ϳ��� ���� ���� ����
        - ���� ������ ���ϴ� �Ϲ� �����ڸ� ����� �� �ִ�. (=, >, <, ...)
    
    # ���� �� ���� ����
    
        - ���� ������ ����� 2�� �̻��� ���� ����
        - ���� �� �����ڿ� �Բ� ����ؾ� �Ѵ� (IN, ANY, SOME, ALL, EXISTS ...)
*/

-- ���� �� ���� ����
SELECT
    *
FROM
    employees
WHERE
    salary >= (SELECT salary FROM employees WHERE employee_id = 150);
    
SELECT salary FROM employees WHERE employee_id = 150;

-- ���� �� ���� ����

-- IN : ���� �� ���� ������ ��� �� ��ġ�ϴ� ���� �ϳ��� ������ true
SELECT
    *
FROM
    employees
WHERE
    last_name IN (SELECT last_name FROM employees WHERE job_id = 'SA_REP')
ORDER BY
    employee_id;

-- ANY, SOME : ���� �� ���� ������ ���� ���� �� �ϳ� �̻��� ������Ű�� true
SELECT
    *
FROM
    employees
WHERE
    salary < ANY (SELECT salary FROM employees WHERE job_id = 'IT_PROG');
-- IT_PROG�� �� ���� ������ ������� ���� ���� ������� ��ȸ
-- �ݴ�� �ϸ� ���� �߹��� ������� �� ���� ������� ��ȸ

SELECT salary FROM employees WHERE job_id = 'IT_PROG';

-- ALL : ���� �� ���� ������ ��ȸ�� ��� ����� �������Ѿ� true
SELECT
    *
FROM
    employees
WHERE
    salary > ALL (SELECT salary FROM employees WHERE job_id = 'IT_PROG');
-- IT_PROG�� �� ���� �� ���� ������� ���� ���� ������� ��ȸ
-- �ݴ���ϸ� IT_PROG�� �� ���� �� ���� ������� �� �� ���� ������� ��ȸ

-- EXISTS : ���� ������ ����� �����ϸ� true

-- departments�� manager_id�� �����ϴ� ���ø� ���� ���� ��
SELECT
    city
FROM
    locations l
WHERE
    EXISTS (SELECT manager_id FROM departments d WHERE l.location_id = d.location_id);




SELECT
    city
FROM
    locations l
WHERE
    EXISTS (SELECT department_id FROM departments d WHERE l.location_id = d.location_id);

SELECT DISTINCT city FROM locations l, departments d WHERE l.location_id = d.location_id;

-- ���� 1 : job_title�� manager�� ���ԵǴ� ��� ������� ��ȭ��ȣ�� ��ȸ
SELECT
    first_name,
    phone_number,
    job_id
FROM
    employees
WHERE
    job_id IN (SELECT job_id FROM jobs WHERE job_title LIKE '%Manager%');
    
SELECT
    first_name,
    phone_number,
    job_title
FROM
    employees INNER JOIN jobs USING (job_id)
WHERE
    job_title LIKE '%Manager';
    
-- ���� 2 : �Ҽӵ� ����� �������� �ʴ� �μ��� ��� ������ ��ȸ

SELECT
    *
FROM
    departments
WHERE
    department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);

SELECT
    *
FROM
    departments
WHERE
    manager_id IS NULL;