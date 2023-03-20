-- 03_WHERE.sql

/*
    # SELECT �÷��� FROM ���̺�� WHERE ������;
    
        - SELECT�� �ڿ� WHERE���� �߰��Ͽ� �ش� ������ �����ϴ� �ุ ��ȸ�� �� �ִ�.
        - ����Ŭ�� �� �����ڸ� Ȱ���� �������� ���� �� �ִ�.
        
    # �� ������
    
        =                    : ������ true
        <, >, <=, >=    : ��
        !=                   : �ٸ��� true
        
    # �� ������
    
        AND, OR, NOT
        
*/


-- ���� Ÿ�� ��
SELECT * FROM employees WHERE salary >= 10000;

-- ���� Ÿ�� ��
SELECT * FROM employees WHERE job_id = 'SA_MAN';
SELECT * FROM employees WHERE job_id = 'IT_PROG';
SELECT * FROM employees WHERE last_name > 'R';
SELECT * FROM employees WHERE last_name < 'E';

-- ��¥ Ÿ�� ��
SELECT * FROM employees WHERE hire_Date < '2005/05/05';
SELECT * FROM employees WHERE hire_Date > '2005/05/05';

-- AND, OR, NOT
SELECT * FROM employees WHERE job_id = 'SH_CLERK' AND salary >= 3000;

SELECT * FROM employees WHERE job_id = 'SH_CLERK' OR job_id = 'IT_PROG' AND salary > 4000;

SELECT * FROM employees WHERE hire_date <'2005/01/01' AND NOT job_id = 'ST_MAN';

-- ���� 1�� : ������ 2000���� 3000������ ������� �̸�, ����, ��å�� ��ȸ�غ�����

SELECT
    first_name || ' ' || last_name AS �̸�,
    salary       AS ����,
    job_id      AS ��å
FROM
    employees
WHERE
        salary >= 2000 AND salary <= 3000;

-- ���� 2�� : 30, 60, 90�� �μ��� ���� ������� �̸�, ��ȭ��ȣ, �μ���ȣ�� ��ȸ�غ�����

SELECT * FROM employees;

SELECT
    first_name || ' ' || last_name  AS �̸�,
    phone_number  AS ��ȭ��ȣ,
    department_id AS �μ���ȣ
FROM
    employees
WHERE
    department_id = 30 OR department_id = 60 OR department_id = 90;

-- null�� ũ�� �񱳰� �Ұ����ϱ� ������ �Ϲ� �� �����ڸ�  ����ϸ� ������ false�� ���´�.
SELECT * FROM employees WHERE NOT commission_pct = null;

-- null���� �� �����ڰ� �ƴ� 'is'�� ���� ���ؾ� �Ѵ�.
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is NOT null;

-- �÷��� BETWEEN A AND B : �ش� �÷� ���� A�� B������ ��� true
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000;
SELECT * FROM employees WHERE hire_date BETWEEN '2005/01/01' AND '2005/12/31';
SELECT * FROM employees WHERE first_name BETWEEN 'D' AND 'J';

-- �÷��� IN (A,B,C,...) : ()���� ���뿡 ���� ������ true
SELECT first_name, department_id FROM employees WHERE department_id IN (30, 60, 90);
SELECT first_name, job_id FROM employees WHERE job_id IN ('FI_ACCOUNT', 'SH_CLERK');

-- SQL������ %���� ��� mod(a, b) �Լ��� ����ؾ� �Ѵ�.
-- ¦�� ��°�� ��ȸ
SELECT * FROM employees WHERE mod(employee_id, 2) = 0;
-- Ȧ�� ��°�� ��ȸ
SELECT * FROM employees WHERE mod(employee_id, 2) = 1;

/*
    # LIKE�� ���ϵ�ī�� (%,_) �� ��ȸ�ϱ�
    
        - �������� �Ϻκ��� ��ġ�ϴ� ������ ��ȸ�� �� �ִ�
        - % : ���� ���� ���� �ƹ� ���ڳ� �͵� �Ǵ� �ڸ�
        - _ : �ϳ��� �ƹ� ���ڰ� �;��ϴ� �ڸ�
*/
SELECT * FROM employees WHERE first_name LIKE 'K%';
SELECT * FROM employees WHERE first_name LIKE '%y';
SELECT * FROM employees WHERE first_name LIKE '%v%';
SELECT * FROM employees WHERE first_name LIKE '%d%';

SELECT * FROM employees WHERE first_name LIKE '%t_';
SELECT * FROM employees WHERE first_name LIKE '_a%';

/*
    ���� 1 : first_name�� �ڿ��� �� ��° ���ڰ� a�� ��� ������� Ǯ������ ��ȸ
    
    ���� 2 : �̸��� e�� �� �� �̻� ���Ե� ������� Ǯ������ ��ȸ
    
    ���� 3 : �̸��� �ټ� �����̸鼭 r�� ������ ������� Ǯ������ ��ȸ
    
    ���� 4 : 8���� �Ի��� ������� �̸���, ��ȭ��ȣ, ������� ��ȸ
*/

-- ���� 1 : first_name�� �ڿ��� �� ��° ���ڰ� a�� ��� ������� Ǯ������ ��ȸ
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '__a%';

-- ���� 2 : �̸��� n�� �� �� �̻� ���Ե� ������� Ǯ������ ��ȸ
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '%n%n%';

-- ���� 3 : �̸��� �ټ� �����̸鼭 r�� ������ ������� Ǯ������ ��ȸ
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '____r';

-- ���� 4 : 8���� �Ի��� ������� �̸���, ��ȭ��ȣ, ������� ��ȸ
SELECT email, phone_number, hire_date FROM employees WHERE hire_date LIKE '%/08/%';

-- lower(col), upper(col) : ���޵� ���� �ҹ���(�빮��)�� �����Ѵ�.
SELECT lower(first_name || ' ' || last_name) FROM employees;
SELECT upper(first_name || ' ' || last_name) FROM employees;

SELECT first_name, job_id FROM employees WHERE lower(first_name) LIKE '%a%a%';
