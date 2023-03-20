-- 11_테이블 생성.sql

/*
    # CRUD
        
        -   대부분의 프로그램이 가지고 있는 기본적인 데이터 처리를 줄여 표현한 것
        -   Create  (세이브 파일 생성)
        -   Read    (세이브 파일 읽기)
        -   Update (세이브 파일 수정)
        -   Delete  (세이브 파일 삭제)
        
    # DML (Data Manipulate Language, 데이터 조작어)
    
        -   INSERT   :   데이터 추가 쿼리 (DB의 Create)
        -   SELECT  :   데이터 읽는 쿼리 (DB의 Read) 
        -   UPDATE  :   데이터 수정 쿼리 (DB의 Update)
        -   DELETE  :   데이터 삭제 쿼리 (DB의 Delete)
    
    # DDL (Data Definition Language, 데이터 정의어)
    
        -   테이블, 시퀀스, 뷰, 인덱스, DB계정 등 DB 오브젝트를 정의하는 명령어
        -   CREATE :   DB 오브젝트 생성
        -   ALTER   :   DB  오브젝트 수정 (ALTER USER...)
        -   DROP     :   DB 오브젝트 삭제 (휴지통)
        -   TRUNCATE    :   DB 오브젝트 완전 삭제
    
    # DCL (Data Control Language, 데이터 제어 명령어)
        
        -   DB 유저의 권한을 부여하거나 박탈하는 명령어
        -   GRANT   :   권한 부여
        -   REVOKE  :   권한 회수
        
*/

/*
    # 테이블 생성하기
    
        CREATE TABLE 테이블명 (컬럼명1 컬럼타입1, 컬럼명2 컬럼타입2, ....);
*/
CREATE TABLE fruits (
    name       VARCHAR2(30),
    sweet       NUMBER(4,2),
    price        NUMBER(7),
    country_id CHAR(2)
);
-- 데이터 딕셔너리 : tab처럼 DB가 알아서 관리하는 데이터에 대한 데이터 (메타 데이터)
SELECT * FROM tab;
SELECT * FROM all_users;

-- 테이블 삭제 : DROP TABLE 테이블명;
DROP TABLE fruits;

-- DROP TABLE로 삭제한 테이블은 휴지통에 담겨있다.
SHOW recyclebin;
SELECT * FROM recyclebin;

-- 휴지통에 있는 삭제했던 테이블 복구하기
FLASHBACK TABLE fruits TO BEFORE DROP;

SELECT * FROM tab;

-- 휴지통 비우기
PURGE recyclebin;

-- 기존 테이블을 복사하여 새 테이블 생성하기
CREATE TABLE employees2 AS (SELECT * FROM employees);
SELECT * FROM employees2;
DESC employees2;

-- 기존 테이블의 구조만 복사하여 새 테이블 생성하기 (일부러 거짓 조건을 조회)
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0);
SELECT * FROM employees3;
DESC employees3;