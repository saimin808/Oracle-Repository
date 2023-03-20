-- 09_ANSI JOIN.sql

/*
        # ANSI JOIN
        
            - ANSI (American National Standard Institute) : �̱� ���� ǥ�� ��ü
            - ANSI���� ������ JOIN ǥ�� ����
            - �ٸ� �����ͺ��̽������� ����� �� �ִ� ����
*/

-- ANSI CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

-- ANSI INNER JOIN : ������ �����ϴ�  �ุ �����ϴ� JOIN (WHERE ��� ON)
SELECT * FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;

-- ���� ���ǿ� ���Ǵ� �� �÷��� �̸��� ���ٸ� USING�� ����� �����ϰ� ������ �� �ִ�.
SELECT * FROM employees e INNER JOIN departments d USING (department_id);
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp INNER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id(+);

/*
    ANSI JOIN ���
     ���� 1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����.
    
    ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�� ������.
    
    ���� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.
*/
-- ���� 1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����.
SELECT
    emp.first_name,
    emp.salary,
    mgr.first_name
FROM
    employees emp INNER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id(+);

-- ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�� ������.

SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments dept INNER JOIN locations locs
ON
    dept.location_id(+) = locs.location_id
ORDER BY
    department_id;

-- ���� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.
    
SELECT
    employee_id,
    department_name
FROM
    departments dept INNER JOIN employees emp
ON
    dept.department_id = emp.department_id(+)
    AND employee_id IS NULL;
    
/*
    ANSI OUTER JOIN : ������ �������� ���ϴ� �൵ �����ϴ� JOIN
        
        1. LEFT OUTER JOIN : ������ ���̺� (+)�� �߰��ϴ� ȿ��
        
        2. RIGHT OUTER JOIN : ���� ���̺� (+)�� �߰��ϴ� ȿ��
        
        3. FULL OUTER JOIN : ���� ��ο� (+)�� �߰��ϴ� ȿ��
*/
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp LEFT OUTER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id;

--ANSI JOIN�� ����� Ǯ��

-- ���� 1 : ��� ������� ���/�̸�/�μ����� ��ȸ�غ�����.
SELECT
    emp.department_id,
    emp.first_name || ' ' || emp.last_name AS employee_name,
    dept.department_name
FROM
    employees emp INNER JOIN departments dept
ON
    emp.department_id = dept.department_id;
    
-- ���� 2 : job_id�� IT_PROG�� ������� �̸�/��å/�μ����� ��ȸ�غ�����.
SELECT
    first_name || ' ' || last_name AS employee_name,
    job_id,
    job_title,
    department_name
FROM
    employees INNER JOIN jobs USING (job_id)
    INNER JOIN departments USING (department_id)
WHERE
    job_id = 'IT_PROG';
    
-- ����3 : Ŀ�̼��� �޴� ������� ���/�̸�/�Ҽӵ��ø� ��ȸ�غ�����.
SELECT 
    employee_id,
    first_name,
    city
FROM
    employees
    INNER JOIN departments USING (department_id)
    INNER JOIN locations USING (location_id)
WHERE
    employees.commission_pct IS NOT NULL;

-- ANSI OUTER JOIN�� ����� Ǯ��
--  ���� 1 : ��� ������� "�̸�/����/�Ŵ����̸�"�� ��ȸ�ϵ� �Ŵ����� ���� ����� �Բ� ��ȸ�غ�����.
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    emp.salary,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp LEFT OUTER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id;
-- ���� 2 : "�μ���ȣ/�μ���/�ּ�/����"�� ��ȸ�ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�� ������.
SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments RIGHT OUTER JOIN locations USING (location_id)
ORDER BY
    department_id ASC;
    
-- ���� 3 : �Ҽӵ� ����� ���� �μ��� ��ȸ�غ�����.
SELECT
    department_id,
    department_name
FROM
    departments LEFT OUTER JOIN employees USING (department_id)
WHERE
    employee_id IS NULL;    


SELECT * FROM departments;