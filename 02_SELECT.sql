-- 02_SELECT.sql

/*
    # SELECT 컬럼명 FROM 테이블명;
    
        - 원하는 테이블의 원하는 컬럼을 조회할 수 있는 쿼리문
        - 컬럼명 자리에 *를 쓰는 것은 모든 컬럼을 의미한다.
        - 여러 컬럼을 조회할 때는 ,를 사용해 구분한다.
        - 컬럼명과 테이블명은 대소문자를 구분하지 않는다.
        - 쿼리문과 명령어도 대소문자를 구분하지 않는다.
        - 데이터는 대소문자를 구분한다.
*/

show user
SELECT * FROM tab;

/*
    # HR 계정에 있는 연습용 테이블들
    
        - EMPLOYEES : 사원 정보 테이블
        - DEPARTMENTS : 부서 정보 테이블
        - JOBS : 직급 정보 테이블
        - LOCATIONS : 지역 정보 테이블
        - COUNTRIES : 나라 정보 테이블
*/
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM countries;

SELECT phone_number FROM employees;
SELECT employee_id, first_name, phone_number FROM employees;

-- 연습1 : 존재하는 모든 부서의 부서ID와 부서명을 조회해보세요

SELECT department_id, department_name FROM departments;

-- 연습2 : 모든 사원의 사번/이름/월급/고용일/부서번호를 조회해보세요

SELECT employee_id, first_name, last_name, salary, hire_date, department_id FROM employees;

/*
        # DESC 테이블명
        
            - 해당 테이블의 모든 컬럼 정보를 볼 수 있다.
            
        # NUMBER (n), NUMBER (n,m)
        
            - 숫자 데이터를 저장할 수 있는 컬럼 타입
            - 숫자가 하나만 적혀있으면 정수의 길이를 나타낸다.
            - 숫자가 두 개 적혀있으면 전체의 길이와 소수점 자릿수를 나타낸다.
            
                ex) NUMBER(8)      -> 정수 8자리까지 저장 가능한 컬럼
                      NUMBER(8, 3)  -> 정수 부분은 5자리, 소수 부분은 3자리까지 저장 가능한 컬럼
                      
        # VARCHAR2 (n)
        
            - 가변 길이 문자 데이터를 저장할 수 있는 컬럼 타입
            - 저장되는 데이터의 크기에 맞춰 알맞은 공간을 사용한다.
            - 물리 저장 공간을 효율적으로 사용
            
        # CHAR (n)
        
            - 고정 길이 문자 데이터를 저장할 수 있는 컬럼 타입
            - 데이터 크기에 맞추지 않고 항상 일정한 공간을 차지한다.
            - 해당 컬럼의 성격에 따라 저장 공간 낭비가 심해질 수도 있다.
            
                ex) COUNTRIES 테이블의 국가 코드(COUNTRY_ID) 컬럼
        
        # DATE
        
            - 날짜 및 시간 데이터를 저장할 수 있는 컬럼 타입.
            
                ex) EMPLOYEES 테이블의 채용 날짜(HIRE_DATE) 컬럼
*/
DESC departments;
DESC employees;
DESC countries;

-- 컬럼 조회시 AS를 이용해 컬럼명을 원하는 이름으로 수정하여 조회할 수 있다.
SELECT first_name AS 이름, salary AS 급여 FROM employees;

-- 조회 결과에 산술 연산자를 활용할 수 있다.
SELECT first_name AS 이름, salary * 2 AS 두달치, salary * 5 다섯달치 FROM employees;

-- 컬럼간의 연산도 가능하다 (commission_pct를 활용한 보너스 급여 계산)
SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct AS 보너스,
    salary + nvl(salary * commission_pct, 0) AS "보너스 포함 급여"
FROM
    employees;

--  "" <- 쌍따옴표를 붙여주면 안에 문자 띄어씌기 및 문자 출력이 가능하다
/*
    # nvl(column, value)
    
        - 계산에 사용하는 컬럼에 null값이 있는 경우 null대신 사용할 값을 지정하는 함수
        - 정상적인 데이터와 null을 연산하면 결과는 무조건 null이 되므로 주의해야 한다.
*/


-- 연습 1 : 모든 사원들의 '사번/전체이름/직책/연봉/보너스 적용된 연봉'을 조회해 보세요
SELECT * FROM employees;
SELECT
    employee_id                         AS 사번,
    first_name ||' '|| last_name  AS "전체 이름",
    job_id                                  AS 직책,
    salary * 12                                  AS 연봉,
    salary * 12 + nvl(salary * 12 * commission_pct, 0) AS "보너스 적용된 연봉"
FROM
    employees;
    
-- SELECT DISTINCT : 각 데이터를 한 번씩만 출력한다
-- 존재하는 부서 번호를 한번씩 출력
SELECT DISTINCT department_id FROM employees; 
-- 존재하는 직책을 한번씩 출력
SELECT DISTINCT job_id FROM employees;
-- 겹치는 이름 제거
SELECT DISTINCT first_name FROM employees;