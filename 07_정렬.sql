-- 07_정렬.sql

/*
    # ORDER BY
    
        - 원하는 컬럼 기준으로 정렬하여 조회하는 문법
        - ORDER BY 컬럼명 [ASC | DESC]
        - ASC : 오름차순 (Ascending)
        - DESC : 내림차순 (Descending)
*/
-- DESC : 내림차순
SELECT * FROM employees ORDER BY hire_date DESC;

SELECT * FROM employees ORDER BY salary DESC;

-- ASC : 오름차순, 생략가능
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary;

-- null은 내림차순 기준으로 가장 먼저 등장한다.
SELECT * FROM employees ORDER BY commission_pct DESC;

--null은 오름차순 기준으로 가장 나중에 등장한다.
SELECT * FROM employees ORDER BY commission_pct ASC;

-- 정렬 기준을 여러개 설정할 수도 있다.
-- ex) 직책 기준으로 내림차순 정렬하되, 같은 직책인 경우 사원번호 기준 오름차순 정렬
SELECT
    employee_id,
    first_name,
    salary,
    job_id
FROM
    employees
ORDER BY
    job_id DESC,
    employee_id;
    
-- 연습 1 : 이름에 i가 포함되어 있는 사원들을 돈 많이 받는 순서대로 조회 (이름이 i로 시작하는 사원도 포함)
SELECT
    first_name,
    salary
FROM
    employees
WHERE
    lower(first_name) LIKE '%i%'
ORDER BY
    salary DESC;
    
SELECT
    first_name || ' ' || last_name AS full_name,
    salary
FROM
    employees
WHERE
    lower(first_name || ' ' || last_name) LIKE '%i%'
ORDER BY
    salary DESC;
    
-- 연습 2 : 모든 사원들을 last_name 기준으로 오름차순 정렬,
--             같은 last_name인 경우 frist_name기준 오름차순 정렬
SELECT
    last_name,
    first_name,
    first_name || ' ' || last_name AS full_name
FROM
    employees
ORDER BY
    last_name,
    first_name;

-- WHERE절은 그룹 함수에 조건을 부여할수 없으니 HAVING절로 그룹 함수에 조건을 부여해 준다.
SELECT job_id, count(salary) FROM employees WHERE salary <= 3000 GROUP BY job_id HAVING count(salary) >= 10;