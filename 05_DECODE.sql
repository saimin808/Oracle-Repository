-- 05_DECODE.sql

/*
    # DECODE
        
        - decode (column, case1, value1, case2, value2 ...)
        - swith-case와 유사함
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
    연습 1 : 직책에 따라 급여를 인상하여 출력해보세요
    
        IT_PROG         : 5% 인상
        FI_ACCOUNT  : 3% 인상
        모든 CLERK    : 2% 인상
    
    "이름/직책/원래급여/인상된 급여"를 출력
    원래의 급여는 before_salary라는 이름으로 출력
    인상된 급여는 after_salary라는 이름으로 출력
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
    
        - DECODE는 정확하게 해당 컬럼값과 일치하는 값만 사용 할 수 있지만
            CASE 문법은 조건을 사용할 수 있다.
            
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