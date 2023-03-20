-- 06_�׷��Լ�.sql

/*
    # �׷� �Լ�
    
        - ���̺��� ����� Ư�� �÷� �������� �׷�ȭ�Ͽ� ����ϴ� �Լ���
        - �׷��� ������ �Ǵ� �÷��� GROUP BY���� ���� ������ �� �ִ�.
        - �ش� �׷��� ����, ����, ��� ���� ���� �� �ִ�.
        - �׷� �Լ��� ����� �Ϲ� �÷��� �Բ� ����� �� ����.
*/

-- sum(column) : �ش� �÷��� ������ ���ϴ� �׷� �Լ�
SELECT sum(salary) FROM employees;
-- ��å�� ���� ����
SELECT job_id, sum(salary) FROM employees GROUP BY job_id;
-- �μ��� ���� ����
SELECT
    decode(department_id,
        100, 'Sales',
        30, 'Purchasing',
        20, 'Marketing',
             'Not yet') AS department_name,
    SUM(salary)
FROM
    employees
GROUP BY
    department_id;

-- avg(column) : �ش� �÷��� ����� ���ϴ� �׷� �Լ�
SELECT avg(salary) FROM employees;
-- ��å�� ��� ����
SELECT job_id, avg(salary) FROM employees GROUP BY job_id;
--�μ��� ��� ����
SELECT department_id, avg(salary) FROM employees GROUP BY department_id; 

-- count (column) : �ش� �÷��� ������ ���ϴ� �׷� �Լ�
SELECT count(commission_pct) FROM employees;
-- ��å�� Ŀ�̼��� �޴� ��� count
SELECT job_id, count(commission_pct) FROM employees GROUP BY job_id;
-- �μ��� Ŀ�̼��� �޴� ��� count
SELECT department_id, count(commission_pct) FROM employees GROUP BY department_id;

-- max(column) : �ش� �÷��� ���� �� ���� ū ���� ����
-- ���� �ֱٿ� �Ի��� ����
SELECT max(hire_date) FROM employees;
-- ��å�� ���� �ֱ� �Ի��� ����
SELECT job_id, max(hire_date) FROM employees GROUP BY job_id;
-- �μ��� ���� �ֱ� �Ի��� ����
SELECT department_id, max(hire_date) FROM employees GROUP BY department_id;

-- min(column) : �ش� �÷��� ���� �� ���� ���� ���� ����
-- ���� �������� �Ի��� ����
SELECT min(hire_date) FROM employees;
-- ��å�� ���� �������� �Ի��� ����
SELECT job_id, min(hire_date) FROM employees GROUP BY job_id;
-- �μ��� ���� �������� �Ի��� ����
SELECT department_id, min(hire_date) FROM employees GROUP BY department_id;

-- ���� 1 : �� ��å���� ���� �ֱٿ� ����� �Ի��� ��¥�� �������� �Ի��� ��¥�� ����غ�����
SELECT job_id, max(hire_date) AS "��å�� ���� ���", min(hire_date) "��å�� �ְ��� ���"  FROM employees GROUP BY job_id;

-- ���� 2 : �� ��å�� ��� ������ ���غ����� (���� ���� ����)
SELECT job_id, avg(salary*12) AS "��å�� ��� ����" FROM employees GROUP BY job_id;

/*
    - �׷� �Լ��� ����� ���� ������ �����ϰ� ���� ��� WHERE���� �ƴ� HAVING���� ����ؾ� �Ѵ�.
    - WHERE������ �׷� �Լ��� ������ �ʴ´�.
*/
-- SELECT avg(salary*12) AS "��å�� ��� ����" FROM employees WHERE avg(salary) > 10000 GROUP BY job_id; -- X
SELECT job_id, avg(salary*12) AS "��å�� ��� ����" FROM employees GROUP BY job_id HAVING avg(salary) > 10000 ;

-- WHERE���� GROUP BY�� ���̱� ���� ���� �����ؾ� �Ѵ�.
-- ���� 5000�̸��� ������� ��å�� ����� 4000�̻��� ��츸 ���
SELECT job_id, avg(salary) FROM employees WHERE salary < 5000 GROUP BY job_id HAVING avg(salary) >= 4000;

-- ���� 5000�̸��� ������� ��å���� 10�� �̻��� ��츸 ���
SELECT job_id, avg(salary) FROM employees WHERE salary < 5000 GROUP BY job_id HAVING count(job_id) > 10;