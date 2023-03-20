-- 02_SELECT.sql

/*
    # SELECT �÷��� FROM ���̺��;
    
        - ���ϴ� ���̺��� ���ϴ� �÷��� ��ȸ�� �� �ִ� ������
        - �÷��� �ڸ��� *�� ���� ���� ��� �÷��� �ǹ��Ѵ�.
        - ���� �÷��� ��ȸ�� ���� ,�� ����� �����Ѵ�.
        - �÷���� ���̺���� ��ҹ��ڸ� �������� �ʴ´�.
        - �������� ��ɾ ��ҹ��ڸ� �������� �ʴ´�.
        - �����ʹ� ��ҹ��ڸ� �����Ѵ�.
*/

show user
SELECT * FROM tab;

/*
    # HR ������ �ִ� ������ ���̺��
    
        - EMPLOYEES : ��� ���� ���̺�
        - DEPARTMENTS : �μ� ���� ���̺�
        - JOBS : ���� ���� ���̺�
        - LOCATIONS : ���� ���� ���̺�
        - COUNTRIES : ���� ���� ���̺�
*/
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM countries;

SELECT phone_number FROM employees;
SELECT employee_id, first_name, phone_number FROM employees;

-- ����1 : �����ϴ� ��� �μ��� �μ�ID�� �μ����� ��ȸ�غ�����

SELECT department_id, department_name FROM departments;

-- ����2 : ��� ����� ���/�̸�/����/�����/�μ���ȣ�� ��ȸ�غ�����

SELECT employee_id, first_name, last_name, salary, hire_date, department_id FROM employees;

/*
        # DESC ���̺��
        
            - �ش� ���̺��� ��� �÷� ������ �� �� �ִ�.
            
        # NUMBER (n), NUMBER (n,m)
        
            - ���� �����͸� ������ �� �ִ� �÷� Ÿ��
            - ���ڰ� �ϳ��� ���������� ������ ���̸� ��Ÿ����.
            - ���ڰ� �� �� ���������� ��ü�� ���̿� �Ҽ��� �ڸ����� ��Ÿ����.
            
                ex) NUMBER(8)      -> ���� 8�ڸ����� ���� ������ �÷�
                      NUMBER(8, 3)  -> ���� �κ��� 5�ڸ�, �Ҽ� �κ��� 3�ڸ����� ���� ������ �÷�
                      
        # VARCHAR2 (n)
        
            - ���� ���� ���� �����͸� ������ �� �ִ� �÷� Ÿ��
            - ����Ǵ� �������� ũ�⿡ ���� �˸��� ������ ����Ѵ�.
            - ���� ���� ������ ȿ�������� ���
            
        # CHAR (n)
        
            - ���� ���� ���� �����͸� ������ �� �ִ� �÷� Ÿ��
            - ������ ũ�⿡ ������ �ʰ� �׻� ������ ������ �����Ѵ�.
            - �ش� �÷��� ���ݿ� ���� ���� ���� ���� ������ ���� �ִ�.
            
                ex) COUNTRIES ���̺��� ���� �ڵ�(COUNTRY_ID) �÷�
        
        # DATE
        
            - ��¥ �� �ð� �����͸� ������ �� �ִ� �÷� Ÿ��.
            
                ex) EMPLOYEES ���̺��� ä�� ��¥(HIRE_DATE) �÷�
*/
DESC departments;
DESC employees;
DESC countries;

-- �÷� ��ȸ�� AS�� �̿��� �÷����� ���ϴ� �̸����� �����Ͽ� ��ȸ�� �� �ִ�.
SELECT first_name AS �̸�, salary AS �޿� FROM employees;

-- ��ȸ ����� ��� �����ڸ� Ȱ���� �� �ִ�.
SELECT first_name AS �̸�, salary * 2 AS �δ�ġ, salary * 5 �ټ���ġ FROM employees;

-- �÷����� ���굵 �����ϴ� (commission_pct�� Ȱ���� ���ʽ� �޿� ���)
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct AS ���ʽ�,
    salary + nvl(salary * commission_pct, 0) AS "���ʽ� ���� �޿�"
FROM
    employees;

--  "" <- �ֵ���ǥ�� �ٿ��ָ� �ȿ� ���� ���� �� ���� ����� �����ϴ�
/*
    # nvl(column, value)
    
        - ��꿡 ����ϴ� �÷��� null���� �ִ� ��� null��� ����� ���� �����ϴ� �Լ�
        - �������� �����Ϳ� null�� �����ϸ� ����� ������ null�� �ǹǷ� �����ؾ� �Ѵ�.
*/


-- ���� 1 : ��� ������� '���/��ü�̸�/��å/����/���ʽ� ����� ����'�� ��ȸ�� ������
SELECT * FROM employees;
SELECT
    employee_id                         AS ���,
    first_name ||' '|| last_name  AS "��ü �̸�",
    job_id                                  AS ��å,
    salary * 12                                  AS ����,
    salary * 12 + nvl(salary * 12 * commission_pct, 0) AS "���ʽ� ����� ����"
FROM
    employees;
    
-- SELECT DISTINCT : �� �����͸� �� ������ ����Ѵ�
-- �����ϴ� �μ� ��ȣ�� �ѹ��� ���
SELECT DISTINCT department_id FROM employees; 
-- �����ϴ� ��å�� �ѹ��� ���
SELECT DISTINCT job_id FROM employees;
-- ��ġ�� �̸� ����
SELECT DISTINCT first_name FROM employees;