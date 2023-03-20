-- 09_ANSI JOIN.sql

/*
        # ANSI JOIN
        
            - ANSI (American National Standard Institute) : 미국 국제 표준 단체
            - ANSI에서 지정한 JOIN 표준 문법
            - 다른 데이터베이스에서도 사용할 수 있는 문법
*/

-- ANSI CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

-- ANSI INNER JOIN : 조건을 충족하는  행만 등장하는 JOIN (WHERE 대신 ON)
SELECT * FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;

-- 조인 조건에 사용되는 두 컬럼의 이름이 같다면 USING을 사용해 간편하게 조인할 수 있다.
SELECT * FROM employees e INNER JOIN departments d USING (department_id);
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp INNER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id(+);

/*
    ANSI JOIN 사용
     연습 1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요.
    
    연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해 보세요.
    
    연습 3 : 소속된 사원이 없는 부서만 조회해보세요.
*/
-- 연습 1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요.
SELECT
    emp.first_name,
    emp.salary,
    mgr.first_name
FROM
    employees emp INNER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id(+);

-- 연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해 보세요.

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

-- 연습 3 : 소속된 사원이 없는 부서만 조회해보세요.
    
SELECT
    employee_id,
    department_name
FROM
    departments dept INNER JOIN employees emp
ON
    dept.department_id = emp.department_id(+)
    AND employee_id IS NULL;
    
/*
    ANSI OUTER JOIN : 조건을 충족하지 못하는 행도 등장하는 JOIN
        
        1. LEFT OUTER JOIN : 오른쪽 테이블에 (+)를 추가하는 효과
        
        2. RIGHT OUTER JOIN : 왼쪽 테이블에 (+)를 추가하는 효과
        
        3. FULL OUTER JOIN : 양쪽 모두에 (+)를 추가하는 효과
*/
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp LEFT OUTER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id;

--ANSI JOIN을 사용해 풀것

-- 연습 1 : 모든 사원들의 사번/이름/부서명을 조회해보세요.
SELECT
    emp.department_id,
    emp.first_name || ' ' || emp.last_name AS employee_name,
    dept.department_name
FROM
    employees emp INNER JOIN departments dept
ON
    emp.department_id = dept.department_id;
    
-- 연습 2 : job_id가 IT_PROG인 사원들의 이름/직책/부서명을 조회해보세요.
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
    
-- 연습3 : 커미션을 받는 사원들의 사번/이름/소속도시를 조회해보세요.
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

-- ANSI OUTER JOIN을 사용해 풀기
--  연습 1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요.
SELECT
    emp.first_name || ' ' || emp.last_name AS employee_name,
    emp.salary,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM
    employees emp LEFT OUTER JOIN employees mgr
ON
    emp.manager_id = mgr.employee_id;
-- 연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해 보세요.
SELECT
    department_id,
    department_name,
    street_address,
    city
FROM
    departments RIGHT OUTER JOIN locations USING (location_id)
ORDER BY
    department_id ASC;
    
-- 연습 3 : 소속된 사원이 없는 부서만 조회해보세요.
SELECT
    department_id,
    department_name
FROM
    departments LEFT OUTER JOIN employees USING (department_id)
WHERE
    employee_id IS NULL;    


SELECT * FROM departments;