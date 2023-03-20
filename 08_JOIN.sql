-- 08_JOIN.sql

/*
     # �⺻Ű (Primary Key, PK)
     
        - �� ���̺��� �ϳ��� ���� �����ϰ� ������ �� �ִ� �÷�
        - �� ���̺� �⺻Ű�� �ϳ��ۿ� ������ �� ����.
        - �⺻Ű�� ������ �÷����� �ߺ����� ���� �� ����. (UNIQUE)
        - �⺻Ű�� ������ �÷����� NULL���� ���� �� ���� (NOT NULL)
     
     # �ĺ�Ű (Candidate Key)
     
        - �⺻Ű�� �� �ڰ��� ���߾����� �⺻Ű�� ���������� ���� �÷�
     
     # �ܷ�Ű (Foreign Key, FK)
     
        - �ٸ� ���̺����� �⺻Ű(�Ǵ� �ĺ�Ű)���� �ش� ���̺����� �ߺ��Ǵ� ���� �÷�
            ex) employees�� department_id�� �ܷ�Ű
                  departments�� department_id�� �⺻Ű
        - � ���̺��� �⺻Ű(�Ǵ� �ĺ�Ű)�� �ش� ���̺��� �ܷ�Ű�� �����Ǹ�
            �� ���̺� ������ 1 : N ���谡 �����Ǿ��ٰ� �� �� �ִ�.
            
    # ��ü �� ����
    
        - 1:1 ���� : ���� ���̺� �ȿ� ������ ��
        - 1:N ���� : �μ� : ���, �귣�� : ü����, �Խñ� : ��� 
        - N:N ���� : �л� : ���� (���� ����), ���� : ���� (���� ������ ���� ������ ����ħ)
        
    # ���̺� ���� JOIN
    
        - �⺻Ű�� �ܷ�Ű�� ���谡 �����Ǿ� �ִ� ��� ���̺��� ������ �����Ͽ� ��ȸ�ϴ� ��
        
        - CROSS JOIN
        - EQUI JOIN
        - SELF JOIN
        - ...
     
*/

/*
    # CROSS JOIN
       
        - ���ο� ���Ǵ� ���̺���� �����͸� �����Ͽ� ���� �� �ִ� ��� ��츦 ����ϴ� JOIN
        - �׳� ��� ���� ������� �����ϴ� �������� ����
*/
SELECT
    *
FROM
    employees; -- 107 rows
SELECT
    *
FROM
    departments; -- 27 rows
SELECT
    employee_id,
    first_name,
    employees.department_id,    -- �� ���̺� �̸��� ��ġ�� �÷��� �ִ� ���
    departments.department_id,  -- ��� ���̺��� ������ Ȯ���ϰ� ��������� �Ѵ�.
    department_name
FROM
    employees,
    departments; -- 107 * 27 = 2889 rows
    
/*
    # EQUI JOIN
    
        - �� ���̺��� ���� ������ ���� ���� �÷�(�ַ� �⺻Ű�� �ܷ�Ű)�� �̿��Ͽ�
            CROSS JOIN���κ��� �ǹ��ִ� �����͸� �ɷ����� JOIN
        - �� ���̺��� ���� �̸��� ���� �÷��� �ִ� ��� �ݵ�� ���̺���� �̿��� ��������� �Ѵ�.
*/
SELECT
    employee_id,
    first_name,
    job_id,
    employees.department_id,
    departments.department_id,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;
    
-- ����1 : ��� ������� ���/�̸�/�μ����� ��ȸ�غ�����

SELECT
    employees.department_id AS employee_id,
    first_name || ' ' || last_name AS full_name,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

-- ����2 : job_id�� IT_PROG�� ������� �̸�/��å/�μ����� ��ȸ�غ�����.

SELECT
    first_name || ' ' || last_name AS full_name,
    job_id,
    department_name
FROM
    employees emp,
    departments dpt
WHERE
    emp.department_id = dpt.department_id
    AND JOB_ID = 'IT_PROG';


-- ����3 : Ŀ�̼��� �޴� ������� ���/�̸�/�Ҽӵ��ø� ��ȸ�� ������.
SELECT
    employees.department_id,
    first_name || ' ' || last_name AS full_name,
    city
FROM
    employees, departments, locations
WHERE
    employees.department_id = departments.department_id
    AND departments.location_id = locations.location_id
    AND commission_pct IS NOT NULL;

SELECT * FROM employees;
SELECT * FROM departments;

-- ����4 : Seattle���� �ٹ��ϴ� ������� �̸�/��å��(job_title)/�޿�/�Ҽӵ��ø� ��ȸ�� ������.

SELECT
    first_name || ' ' || last_name AS full_name,
    job_title,
    salary,
    city
FROM
    employees e, departments d, jobs j, locations l
WHERE
    e.department_id = d.department_id
    AND e.job_id = j.job_id
    AND d.location_id = l.location_id
    AND city = 'Seattle';

-- �� EMP_DETAILS_VIEW ���� 0��
-- EMP_DETAILS_VIEW : ���̺��� �ƴ϶� �̸� ������ �� �س��� ��
SELECT * FROM emp_details_view;
SELECT * FROM user_views;

/*
    # SELF JOIN
    
        - �ϳ��� ���̺����� �ڱ� �ڽŰ� JOIN�Ͽ� ���ϴ� �����͸� ���� ���
        - �ش� ���̺��� �⺻Ű�� �ٸ� �÷����� �ܷ�Ű�� ����ϴ� ���
            ex) employees�� manager_id, ȸ������ ���̺��� ��õ��
*/
SELECT
    e1.employee_id,
    e1.first_name AS "�����",
    e1.manager_id AS "�Ŵ��� ID",
    e2.employee_id AS "�Ŵ��� ���� ID",
    e2.first_name || ' ' || e2.last_name AS "�Ŵ��� �̸�"
FROM
    employees e1, employees e2
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;
    
-- ���� 1 : �Ŵ����� first_name�� e�� ���ԵǴ� ��� ������� "���/�̸�/��å��/�Ŵ��� �̸�"�� ��ȸ 

SELECT
    e1.employee_id AS "���",
    e1.first_name || ' ' || e1.last_name AS "��� �̸�",
    j.job_title AS "��å��",
    e2.first_name || ' ' || e2.last_name AS "�Ŵ��� �̸�"
FROM
    employees e1,
    employees e2,
    jobs j
WHERE
    e1.manager_id = e2.employee_id
    AND e1.job_id = j.job_id
    AND e2.first_name LIKE '%e%';

-- ���� 2 : first_name�� Curtis�� ����� ������ �μ��� ������� ���� ������ �̿��Ͽ� ��� ��ȸ

SELECT
    e2.*
FROM
    employees e1,
    employees e2
WHERE
    e1.department_id = e2.department_id
    AND e1.first_name = 'Curtis'
    AND e2.first_name <> 'Curtis'
ORDER BY
    e2.employee_id;
    
    
/*    
   (1)  1 : N ����� ������ �� �ִ� ���� ��ʵ��� ������ ������
   
        - 1 : ��������            N : �μ�, �Ŀ���, �Ҽ� ������, �Ҽ� ��������.....

   (2)  1 : N ����� ������ �� ��ü�� ���̺� ���·� ������ ������
         (���̺� ��, �÷� ��, �� �÷� Ÿ��...)
         
         -  ���̺� �� : �ƽ��� FC (�μ�)
            �÷� �� : �μ� ��ȣ(����), �μ� �̸�(����), �� �ο� ��(����)...
         
         -  ���̺� �� : �ƽ��� FC �Ҽ� (������) ������
            �÷� �� : ���ȣ(����), ������(����), �̸�(����), ����(����),
                        �������(DATE), �Դܳ�¥(DATE), �λ� ����(Boolean), ��� ������(����), �μ� ��ȣ(����)...
         
         -  ���̺� �� : �ƽ��� FC �Ҽ� ������
            �÷� �� : �̸�(����), ����(����), ��å(����), ��� ����(����), �������(DATE), �Դܳ�¥(DATE),
                          �μ� ��ȣ(����)....
         
   (3)  � �÷��� �⺻Ű�� �ܷ�Ű ������ ���� �����غ�����
        - �⺻Ű&�ܷ�Ű : �μ� ��ȣ(����)
        
*/

/*
        # OUTER JOIN
        
            - JOIN ������ �������� ���� �������� ���ϴ� ���� Ȯ���� �� �ִ� JOIN
            - (+)�� ���� �ʿ� null�� �߰��ؼ� �������� ���ߴ� ����� Ȯ���� �� �ִ�.
*/
SELECT count(*) FROM employees;
SELECT count(department_id) FROM employees;
SELECT count(manager_id) FROM employees;

-- Kimberely�� �μ��� ��� �μ� ID�� Ȱ���� ���� ������ �������� ���Ͽ� �������� ���Ѵ�.
SELECT
    first_name,
    department_name
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id(+); -- (+)�� �ٿ��� �����ζ� ����ϰ� ���ش� (OUTER JOIN)
    
SELECT
    first_name,
    email,
    e.department_id,
    department_name,
    location_id
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id(+);
    
-- (+)�� departments �ʿ� ���̸� �Ҽӵ� �μ��� ���� ����� ��ȸ
-- (+)�� employees �ʿ� ���̸� �Ҽӵ� ����� ���� �μ��� ��ȸ
    
SELECT * FROM departments;
    
SELECT * FROM employees WHERE department_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NULL;

/*
    ���� 1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����.
    
    ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�� ������.
    
    ���� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.
*/
SELECT * FROM employees;

SELECT DISTINCT
    emp.first_name,
    emp.salary,
    mng.first_name
FROM
    employees emp,
    employees mng
WHERE
    emp.manager_id = mng.employee_id(+);

--  ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�� ������.

SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments d,
    locations l
WHERE
    d.location_id(+) = l.location_id
ORDER BY
    department_id;
    
-- ���� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.

SELECT
    employee_id,
    d.*
FROM
    employees e,
    departments d
WHERE
    d.department_id = e.employee_id(+)
    AND employee_id IS NULL;
