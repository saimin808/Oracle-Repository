-- 08_JOIN.sql

/*
     # 기본키 (Primary Key, PK)
     
        - 한 테이블에서 하나의 행을 유일하게 구분할 수 있는 컬럼
        - 각 테이블에 기본키는 하나밖에 설정할 수 없다.
        - 기본키로 설정된 컬럼에는 중복값을 넣을 수 없다. (UNIQUE)
        - 기본키로 설정된 컬럼에는 NULL값을 넣을 수 없다 (NOT NULL)
     
     # 후보키 (Candidate Key)
     
        - 기본키가 될 자격을 갖추었지만 기본키로 설정되지는 않은 컬럼
     
     # 외래키 (Foreign Key, FK)
     
        - 다른 테이블에서는 기본키(또는 후보키)지만 해당 테이블에서는 중복되는 값인 컬럼
            ex) employees의 department_id는 외래키
                  departments의 department_id는 기본키
        - 어떤 테이블의 기본키(또는 후보키)가 해당 테이블의 외래키로 설정되면
            두 테이블 간에는 1 : N 관계가 형성되었다고 볼 수 있다.
            
    # 개체 간 관계
    
        - 1:1 관계 : 같은 테이블 안에 넣으면 됨
        - 1:N 관계 : 부서 : 사원, 브랜드 : 체인점, 게시글 : 댓글 
        - N:N 관계 : 학생 : 전공 (복수 전공), 교수 : 과목 (여러 과목을 여러 교수가 가르침)
        
    # 테이블 간의 JOIN
    
        - 기본키와 외래키로 관계가 형성되어 있는 경우 테이블의 정보를 종합하여 조회하는 것
        
        - CROSS JOIN
        - EQUI JOIN
        - SELF JOIN
        - ...
     
*/

/*
    # CROSS JOIN
       
        - 조인에 사용되는 테이블들의 데이터를 조합하여 나올 수 있는 모든 경우를 출력하는 JOIN
        - 그냥 모든 행을 순서대로 조합하는 쓸데없는 정보
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
    employees.department_id,    -- 양 테이블에 이름이 겹치는 컬럼이 있는 경우
    departments.department_id,  -- 어느 테이블의 값인지 확실하게 구분해줘야 한다.
    department_name
FROM
    employees,
    departments; -- 107 * 27 = 2889 rows
    
/*
    # EQUI JOIN
    
        - 두 테이블에서 서로 동일한 값을 지닌 컬럼(주로 기본키와 외래키)을 이용하여
            CROSS JOIN으로부터 의미있는 데이터를 걸러내는 JOIN
        - 두 테이블에서 같은 이름을 가진 컬럼이 있는 경우 반드시 테이블명을 이용해 구분해줘야 한다.
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
    
-- 연습1 : 모든 사원들의 사번/이름/부서명을 조회해보세요

SELECT
    employees.department_id AS employee_id,
    first_name || ' ' || last_name AS full_name,
    department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;

-- 연습2 : job_id가 IT_PROG인 사원들의 이름/직책/부서명을 조회해보세요.

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


-- 연습3 : 커미션을 받는 사원들의 사번/이름/소속도시를 조회해 보세요.
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

-- 연습4 : Seattle에서 근무하는 사원들의 이름/직책명(job_title)/급여/소속도시를 조회해 보세요.

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

-- ※ EMP_DETAILS_VIEW 쓰면 0점
-- EMP_DETAILS_VIEW : 테이블이 아니라 미리 조인을 다 해놓은 뷰
SELECT * FROM emp_details_view;
SELECT * FROM user_views;

/*
    # SELF JOIN
    
        - 하나의 테이블내에서 자기 자신과 JOIN하여 원하는 데이터를 얻어내는 방식
        - 해당 테이블의 기본키를 다른 컬럼에서 외래키로 사용하는 경우
            ex) employees의 manager_id, 회원정보 테이블의 추천인
*/
SELECT
    e1.employee_id,
    e1.first_name AS "사원명",
    e1.manager_id AS "매니저 ID",
    e2.employee_id AS "매니저 본인 ID",
    e2.first_name || ' ' || e2.last_name AS "매니저 이름"
FROM
    employees e1, employees e2
WHERE
    e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;
    
-- 연습 1 : 매니저의 first_name에 e가 포함되는 모든 사원들의 "사번/이름/직책명/매니저 이름"을 조회 

SELECT
    e1.employee_id AS "사번",
    e1.first_name || ' ' || e1.last_name AS "사원 이름",
    j.job_title AS "직책명",
    e2.first_name || ' ' || e2.last_name AS "매니저 이름"
FROM
    employees e1,
    employees e2,
    jobs j
WHERE
    e1.manager_id = e2.employee_id
    AND e1.job_id = j.job_id
    AND e2.first_name LIKE '%e%';

-- 연습 2 : first_name이 Curtis인 사원과 동일한 부서인 사원들을 셀프 조인을 이용하여 모두 조회

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
   (1)  1 : N 관계로 설정할 수 있는 실제 사례들을 생각해 보세요
   
        - 1 : 스포츠팀            N : 부서, 후원사, 소속 선수들, 소속 스태프들.....

   (2)  1 : N 관계로 설정한 각 개체를 테이블 형태로 설계해 보세요
         (테이블 명, 컬럼 명, 각 컬럼 타입...)
         
         -  테이블 명 : 아스널 FC (부서)
            컬럼 명 : 부서 번호(숫자), 부서 이름(문자), 총 인원 수(숫자)...
         
         -  테이블 명 : 아스널 FC 소속 (성인팀) 선수들
            컬럼 명 : 등번호(숫자), 포지션(문자), 이름(문자), 국적(문자),
                        생년월일(DATE), 입단날짜(DATE), 부상 여부(Boolean), 담당 스태프(문자), 부서 번호(숫자)...
         
         -  테이블 명 : 아스널 FC 소속 스태프
            컬럼 명 : 이름(문자), 국적(문자), 직책(문자), 담당 선수(문자), 생년월일(DATE), 입단날짜(DATE),
                          부서 번호(숫자)....
         
   (3)  어떤 컬럼이 기본키와 외래키 역할을 할지 생각해보세요
        - 기본키&외래키 : 부서 번호(숫자)
        
*/

/*
        # OUTER JOIN
        
            - JOIN 조건을 만족하지 못해 등장하지 못하는 행을 확인할 수 있는 JOIN
            - (+)를 붙인 쪽에 null을 추가해서 등장하지 못했던 행들을 확인할 수 있다.
*/
SELECT count(*) FROM employees;
SELECT count(department_id) FROM employees;
SELECT count(manager_id) FROM employees;

-- Kimberely는 부서가 없어서 부서 ID를 활용한 조인 조건을 만족하지 못하여 등장하지 못한다.
SELECT
    first_name,
    department_name
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id(+); -- (+)를 붙여서 억지로라도 출력하게 해준다 (OUTER JOIN)
    
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
    
-- (+)를 departments 쪽에 붙이면 소속된 부서가 없는 사원을 조회
-- (+)를 employees 쪽에 붙이면 소속된 사원이 없는 부서를 조회
    
SELECT * FROM departments;
    
SELECT * FROM employees WHERE department_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NULL;

/*
    연습 1 : 모든 사원들의 "이름/월급/매니저이름"을 조회하되 매니저가 없는 사원도 함께 조회해보세요.
    
    연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해 보세요.
    
    연습 3 : 소속된 사원이 없는 부서만 조회해보세요.
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

--  연습 2 : "부서번호/부서명/주소/도시"를 조회하되 소속된 부서가 없는 도시도 함께 조회해 보세요.

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
    
-- 연습 3 : 소속된 사원이 없는 부서만 조회해보세요.

SELECT
    employee_id,
    d.*
FROM
    employees e,
    departments d
WHERE
    d.department_id = e.employee_id(+)
    AND employee_id IS NULL;
