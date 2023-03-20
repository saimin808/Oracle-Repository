-- 03_WHERE.sql

/*
    # SELECT 컬럼명 FROM 테이블명 WHERE 조건절;
    
        - SELECT문 뒤에 WHERE절을 추가하여 해당 조건을 만족하는 행만 조회할 수 있다.
        - 오라클의 비교 연산자를 활용해 조건절을 만들 수 있다.
        
    # 비교 연산자
    
        =                    : 같으면 true
        <, >, <=, >=    : 비교
        !=                   : 다르면 true
        
    # 논리 연산자
    
        AND, OR, NOT
        
*/


-- 숫자 타입 비교
SELECT * FROM employees WHERE salary >= 10000;

-- 문자 타입 비교
SELECT * FROM employees WHERE job_id = 'SA_MAN';
SELECT * FROM employees WHERE job_id = 'IT_PROG';
SELECT * FROM employees WHERE last_name > 'R';
SELECT * FROM employees WHERE last_name < 'E';

-- 날짜 타입 비교
SELECT * FROM employees WHERE hire_Date < '2005/05/05';
SELECT * FROM employees WHERE hire_Date > '2005/05/05';

-- AND, OR, NOT
SELECT * FROM employees WHERE job_id = 'SH_CLERK' AND salary >= 3000;

SELECT * FROM employees WHERE job_id = 'SH_CLERK' OR job_id = 'IT_PROG' AND salary > 4000;

SELECT * FROM employees WHERE hire_date <'2005/01/01' AND NOT job_id = 'ST_MAN';

-- 연습 1번 : 월급이 2000에서 3000사이인 사원들의 이름, 월급, 직책을 조회해보세요

SELECT
    first_name || ' ' || last_name AS 이름,
    salary       AS 월급,
    job_id      AS 직책
FROM
    employees
WHERE
        salary >= 2000 AND salary <= 3000;

-- 연습 2번 : 30, 60, 90번 부서에 속한 사원들의 이름, 전화번호, 부서번호로 조회해보세요

SELECT * FROM employees;

SELECT
    first_name || ' ' || last_name  AS 이름,
    phone_number  AS 전화번호,
    department_id AS 부서번호
FROM
    employees
WHERE
    department_id = 30 OR department_id = 60 OR department_id = 90;

-- null은 크기 비교가 불가능하기 때문에 일반 비교 연산자를  사용하면 무조건 false가 나온다.
SELECT * FROM employees WHERE NOT commission_pct = null;

-- null값은 비교 연산자가 아닌 'is'를 통해 비교해야 한다.
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is NOT null;

-- 컬럼명 BETWEEN A AND B : 해당 컬럼 값이 A와 B사이인 경우 true
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000;
SELECT * FROM employees WHERE hire_date BETWEEN '2005/01/01' AND '2005/12/31';
SELECT * FROM employees WHERE first_name BETWEEN 'D' AND 'J';

-- 컬럼명 IN (A,B,C,...) : ()안의 내용에 값이 있으면 true
SELECT first_name, department_id FROM employees WHERE department_id IN (30, 60, 90);
SELECT first_name, job_id FROM employees WHERE job_id IN ('FI_ACCOUNT', 'SH_CLERK');

-- SQL에서는 %연산 대신 mod(a, b) 함수를 사용해야 한다.
-- 짝수 번째만 조회
SELECT * FROM employees WHERE mod(employee_id, 2) = 0;
-- 홀수 번째만 조회
SELECT * FROM employees WHERE mod(employee_id, 2) = 1;

/*
    # LIKE와 와일드카드 (%,_) 로 조회하기
    
        - 데이터의 일부분이 일치하는 내용을 조회할 수 있다
        - % : 길이 제한 없이 아무 문자나 와도 되는 자리
        - _ : 하나의 아무 문자가 와야하는 자리
*/
SELECT * FROM employees WHERE first_name LIKE 'K%';
SELECT * FROM employees WHERE first_name LIKE '%y';
SELECT * FROM employees WHERE first_name LIKE '%v%';
SELECT * FROM employees WHERE first_name LIKE '%d%';

SELECT * FROM employees WHERE first_name LIKE '%t_';
SELECT * FROM employees WHERE first_name LIKE '_a%';

/*
    연습 1 : first_name의 뒤에서 세 번째 글자가 a인 모든 사원들의 풀네임을 조회
    
    연습 2 : 이름에 e가 두 개 이상 포함된 사원들의 풀네임을 조회
    
    연습 3 : 이름이 다섯 글자이면서 r로 끝나는 사원들의 풀네임을 조회
    
    연습 4 : 8월에 입사한 사원들의 이메일, 전화번호, 고용일을 조회
*/

-- 연습 1 : first_name의 뒤에서 세 번째 글자가 a인 모든 사원들의 풀네임을 조회
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '__a%';

-- 연습 2 : 이름에 n이 두 개 이상 포함된 사원들의 풀네임을 조회
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '%n%n%';

-- 연습 3 : 이름이 다섯 글자이면서 r로 끝나는 사원들의 풀네임을 조회
SELECT first_name || ' ' || last_name AS FULL_NAME FROM employees WHERE first_name LIKE '____r';

-- 연습 4 : 8월에 입사한 사원들의 이메일, 전화번호, 고용일을 조회
SELECT email, phone_number, hire_date FROM employees WHERE hire_date LIKE '%/08/%';

-- lower(col), upper(col) : 전달된 값을 소문자(대문자)로 변경한다.
SELECT lower(first_name || ' ' || last_name) FROM employees;
SELECT upper(first_name || ' ' || last_name) FROM employees;

SELECT first_name, job_id FROM employees WHERE lower(first_name) LIKE '%a%a%';
