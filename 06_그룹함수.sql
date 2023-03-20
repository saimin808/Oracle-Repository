-- 06_그룹함수.sql

/*
    # 그룹 함수
    
        - 테이블의 행들을 특정 컬럼 기준으로 그룹화하여 계산하는 함수들
        - 그룹의 기준이 되는 컬럼을 GROUP BY절을 통해 선택할 수 있다.
        - 해당 그룹의 총합, 개수, 평균 등을 구할 수 있다.
        - 그룹 함수의 결과는 일반 컬럼과 함께 출력할 수 없다.
*/

-- sum(column) : 해당 컬럼의 총합을 구하는 그룹 함수
SELECT sum(salary) FROM employees;
-- 직책별 월급 총합
SELECT job_id, sum(salary) FROM employees GROUP BY job_id;
-- 부서별 월급 총합
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

-- avg(column) : 해당 컬럼의 평균을 구하는 그룹 함수
SELECT avg(salary) FROM employees;
-- 직책별 평균 월급
SELECT job_id, avg(salary) FROM employees GROUP BY job_id;
--부서별 평균 월급
SELECT department_id, avg(salary) FROM employees GROUP BY department_id; 

-- count (column) : 해당 컬럼의 개수를 구하는 그룹 함수
SELECT count(commission_pct) FROM employees;
-- 직책별 커미션을 받는 사원 count
SELECT job_id, count(commission_pct) FROM employees GROUP BY job_id;
-- 부서별 커미션을 받는 사원 count
SELECT department_id, count(commission_pct) FROM employees GROUP BY department_id;

-- max(column) : 해당 컬럼의 값들 중 가장 큰 값을 구함
-- 가장 최근에 입사한 직원
SELECT max(hire_date) FROM employees;
-- 직책별 가장 최근 입사한 직원
SELECT job_id, max(hire_date) FROM employees GROUP BY job_id;
-- 부서별 가장 최근 입사한 직원
SELECT department_id, max(hire_date) FROM employees GROUP BY department_id;

-- min(column) : 해당 컬럼의 값들 중 가장 작은 값을 구함
-- 가장 오래전에 입사한 직원
SELECT min(hire_date) FROM employees;
-- 직책별 가장 오래전에 입사한 직원
SELECT job_id, min(hire_date) FROM employees GROUP BY job_id;
-- 부서별 가장 오래전에 입사한 직원
SELECT department_id, min(hire_date) FROM employees GROUP BY department_id;

-- 연습 1 : 각 직책별로 가장 최근에 사원이 입사한 날짜와 오래전에 입사한 날짜를 출력해보세요
SELECT job_id, max(hire_date) AS "직책별 막내 사원", min(hire_date) "직책별 최고참 사원"  FROM employees GROUP BY job_id;

-- 연습 2 : 각 직책별 평균 연봉을 구해보세요 (월급 말고 연봉)
SELECT job_id, avg(salary*12) AS "직책별 평균 연봉" FROM employees GROUP BY job_id;

/*
    - 그룹 함수의 결과에 대한 조건을 적용하고 싶은 경우 WHERE절이 아닌 HAVING절을 사용해야 한다.
    - WHERE절에는 그룹 함수가 허용되지 않는다.
*/
-- SELECT avg(salary*12) AS "직책별 평균 연봉" FROM employees WHERE avg(salary) > 10000 GROUP BY job_id; -- X
SELECT job_id, avg(salary*12) AS "직책별 평균 연봉" FROM employees GROUP BY job_id HAVING avg(salary) > 10000 ;

-- WHERE절은 GROUP BY로 묶이기 전에 먼저 적용해야 한다.
-- 월급 5000미만인 사원들이 직책별 평균이 4000이상인 경우만 출력
SELECT job_id, avg(salary) FROM employees WHERE salary < 5000 GROUP BY job_id HAVING avg(salary) >= 4000;

-- 월급 5000미만인 사원들이 직책별로 10명 이상인 경우만 출력
SELECT job_id, avg(salary) FROM employees WHERE salary < 5000 GROUP BY job_id HAVING count(job_id) > 10;