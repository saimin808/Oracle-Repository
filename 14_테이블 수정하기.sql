-- 14_테이블 수정하기.sql

/*
        # 테이블에 새 컬럼 추가하기
        
            - ALTER TABLE 테이블명 ADD (컬럼명 컬럼타입 [제약조건], ...);
            - 새 컬럼을 추가할 때는 기존 행들의 추가 컬럼 값이 NULL이 된다.
            - DEFAULT를 설정해 놓으면 새로운 컬럼의 값을 DEFAULT로 하여 추가한다.
*/
ALTER TABLE fruits ADD (
    grade VARCHAR2(2)
        CONSTRAINT fruit_grade_chk CHECK (regexp_like (grade, '[ABCDF]?[+- ]?')) -- regexp_like () : 정규표현식
);
ALTER TABLE fruits DROP CONSTRAINT fruit_grade_chk;
ALTER TABLE fruits ADD CONSTRAINT fruit_grade_chk CHECK (regexp_like (apple_grade, '[ABCDF][+]?'));
-- 연습 1 : fruits 테이블의 country_id에 올바른 외래키 제약조건을 설정해보세요
--             (countries 테이블을 복사한 countries2 테이블로 진행할 것)

-- (1) countries 테이블을 복사한 countries2 테이블을 만든다
CREATE TABLE countries2 AS (SELECT * FROM countries);

-- (2) countries2 테이블에 primary key를 설정한다.
ALTER TABLE countries2 ADD CONSTRAINT country_id_pk PRIMARY KEY (country_id);
SELECT * FROM countries2;

UPDATE fruits SET country_id = null;

-- (3) fruits 테이블에 countries2 테이블의 기본키(country_id)를 참조한 외래키를 설정한다.
ALTER TABLE fruits ADD CONSTRAINT fruits_counid_fk FOREIGN KEY (country_id)
                REFERENCES countries2(country_id);

-- (*) fruits 테이블에 이미 행이 존재한다면 전부 지워주고 (3)을 진행한다
SELECT * FROM fruits;
DELETE FROM fruits;

DESC countries2;
SELECT * FROM user_constraints;

INSERT INTO fruits VALUES('apple', 13.33, 1300, 'AU', 'A+');
INSERT INTO fruits VALUES('apple', 13.33, 1300, 'AU', 'Az');
INSERT INTO fruits VALUES('banana', 12.22, 1200, 'CA', 'A_');

UPDATE fruits SET grade = 'A-';

SELECT regexp_like(' ', 'A-') FROM dual;
SELECT * FROM dual;

DESC fruits;
SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS';

/*
    # 테이블 컬럼 삭제하기
    
        - ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/

ALTER TABLE fruits DROP COLUMN grade;

SELECT * FROM fruits;

/*
    # 테이블 컬럼 이름 변경하기
    
        - ALTER TABLE 테이블명 RENAME COLUMN 현재이름 TO 바꿀이름;
*/
ALTER TABLE fruits RENAME COLUMN grade TO fruit_grade;
ALTER TABLE fruits RENAME COLUMN fruit_grade TO apple_grade;

SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS';

/*
    # 테이블 제약조건 이름 변경하기
    
        - ALTER TABLE 테이블명 RENAME CONSTRAINT 제약조건명 TO 바꿀이름;
*/
ALTER TABLE fruits RENAME CONSTRAINT fruit_grade_chk TO fruit_apple_grade_chk;

/*
    # 테이블 이름 변경하기
    
        - RENAME 테이블명 TO 바꿀이름;
*/
RENAME coffees5 TO coffeesFive;

SELECT * FROM user_tables;

/*
    # 컬럼 수정하기
    
        - ALTER TABLE 테이블명 MODIFY (컬럼명 컬럼타입 [제약조건], ...);
        - 이미 존재하는 컬럼의 여러 가지 정보들을 수정할 때 사용
        - 컬럼 크기를 수정할 수도 있다.
        - 새로운 제약 조건을 설정할 수도 있다.
        - NOT NULL, CHECK, DEFAULT는 이것을 통해 추가해야 한다. 
*/

SELECT * FROM coffeesfive;
DESC coffees;

ALTER TABLE coffeesFive MODIFY (
    coffee_id NUMBER(10),
        CONSTRAINT c5_id_pk PRIMARY KEY (coffee_id)
);

