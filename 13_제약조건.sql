-- 13_제약조건.sql

/*
    # 무결성
    
        - 결함이 없는 성질
        - 데이터를 올바르게 유지, 관리하기 위해서는 다양한 종류의 무결성을 충족시켜야 한다.
        - 데이터베이스는 제약 조건을 통해 여러 무결성들을 보장한다.
        
    # 데이터 무결성
    
        - 데이터가 정확성, 일관성, 유효성을 유지하는 것
    
    # 개체 무결성
    
        - 테이블의 데이터는 반드시 하나의 개체를 선택 할 수 있어야 한다.
        - 관계형 데이터베이스는 개체 무결성을 지키기 위해 제약조건으로 기본키 (PK)를 사용한다.
    
    # 참조 무결성
    
        - 참조 관계에 있는 데이터는 유효한 데이터를 참조해야 한다.
        - 참조 무결성을 지키기 위해 제약 조건으로 외래키(FK)를 사용한다.
    
    # 도메인 무결성
    
        - 하나의 도메인(컬럼)을 구성하는 개체들은 모두 같은 타입이어야 한다.
        - 컬럼 타입 및 CHECK 제약 조건을 통해 도메인 무결성을 유지 할 수 있다.
        
    # DB의 제약 조건들
    
        - NOT NULL : 해당 도메인에 NULL을 허용하지 않음
        - UNIQUE : 해당 도메인에 중복되는 값을 허용하지 않음
        - PRIMARY KEY : 해당 도메인을 기본키로 설정 (NOT NULL + UNIQUE)
        - FOREIGN KEY : 해당 도메인을 외래키로 설정
        - CHECK : 원하는 조건을 만족한 개체만 추가 가능
*/

/*
    # 데이터 딕셔너리 (Data Dictionary)
    
        - 데이터에 대한 데이터 (메타 데이터)
        - 현재 DB의 상황에 대한 DB가 알아서 관리하는 데이터
        - 사용자는 데이터 딕셔너리를 직접 수정할 수 없다.
        
    # 데이터 딕셔너리 뷰
    
        - 데이터 딕셔너리를 사용자가 확인할 수 있도록 제공하는 뷰 (View)
        ※ View - DB 오브젝트 중 하나로 테이블처럼 조회는 가능하나 수정은 마음대로 할 수 없는 것
        - 앞에 user_가 붙으면 해당 계정의 데이터 딕셔너리를 확인할 수 있다.
        - 앞에 all_이 붙으면 모든 계정의 데이터 딕셔너리를 확인할 수 있다.
*/
show user;

-- 테이블 데이터 딕셔너리 뷰
SELECT * FROM user_tables;
SELECT * FROM all_tables;

-- 제약조건 데이터 딕셔너리 뷰
SELECT * FROM user_constraints;
SELECT * FROM all_constraints;

-- employees 테이블의 제약조건 보기
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';
/*
    # Constraints_type
    
        - P : Primary Key
        - R : References (Foreign Key)
        - C : Check, Not Null
        - U : Unique
*/

/*
    1. 테이블 생성과 동시에 제약조건 추가하기
    
        - 컬럼명 컬럼타입 제약조건 (제약조건 이름이 자동생성되기 때문에 파악이 힘들어짐)
        - 컬럼명 컬럼타입 CONSTRAINT 제약조건명 제약조건
*/
CREATE TABLE coffees (
    coffee_id          NUMBER(10)       CONSTRAINT coffee_id_pk PRIMARY KEY,
    coffee_name    VARCHAR2(50)    CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price     NUMBER(5)         CONSTRAINT coffee_price_nn NOT NULL,
    coffee_size      VARCHAR2(6)     CONSTRAINT coffee_size_chk CHECK (coffee_size IN ('Tall','Grande','Venti'))
                                                     CONSTRAINT coffee_size_nn NOT NULL
);

SELECT * FROM coffees;

SELECT * FROM user_constraints WHERE table_name = 'COFFEES';

INSERT INTO coffees VALUES(1, 'Americano', 5000, 'Tall');
INSERT INTO coffees VALUES(2, 'Americano', 6000, 'Grande');
INSERT INTO coffees VALUES(3, 'Americano', 7000, 'Granda');
INSERT INTO coffees VALUES(4, 'Americano', 8000, null);
-- 테이블을 삭제하는 경우 제약조건들도 함께 사라진다.
DROP TABLE coffees;
PURGE recyclebin;

/*
    2. 테이블 생성 후에 제약조건 추가하기
    
        - ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 (대상 컬럼);
        - NOT NULL, CHECK, DEFAULT는 MODIFY로 컬럼 자체를 수정해야 한다.
*/
CREATE TABLE coffees2 (
    coffee_id           NUMBER(10),
    coffee_name     VARCHAR2(50),
    coffee_price      NUMBER(5),
    coffee_size       VARCHAR2(6)
);
-- coffee2 테이블의 coffee2_id_pk 라는 이름의 coffee_id 컬럼을 기본키로 만드는 제약조건을 추가한다.
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_id_pk PRIMARY KEY (coffee_id);
-- coffee2 테이블에 coffee2_price_uk 라는 이름의 coffee_price를 UNIQUE키로 만드는 제약조건을 추가한다.
ALTER TABLE coffees2 ADD CONSTRAINT coffee2_price_uk UNIQUE (coffee_price);

-- NOT NULL, CHECK, DEFAULT (CREATE TABLE과 문법이 같다)
ALTER TABLE coffees2 MODIFY (
    coffee_name     VARCHAR2(66) DEFAULT 'Espresso'
            CONSTRAINT coffee2_name_nn NOT NULL
);

ALTER TABLE coffees2 MODIFY (
        coffee_size VARCHAR2 (10)
            CONSTRAINT coffee2_size_chk
                CHECK (lower(coffee_size) IN ('tall', 'grande', 'venti'))
            CONSTRAINT coffee2_size_nn NOT NULL
);

INSERT INTO coffees2 VALUES(1, 'Americano', 3000, 'ABC');
INSERT INTO coffees2(coffee_id, coffee_price, coffee_size) VALUES(2, 2000, 'Abc');

UPDATE coffees2 SET coffee_size = 'ABC';

SELECT * FROM user_constraints WHERE table_name = 'COFFEES2';
SELECT * FROM coffees2;
DESC coffees2;

/*
    3. 테이블 레벨 방식으로 제약조건 추가하기
    
        - 컬럼을 먼저 선언한 후 테이블 제약조건을 후술하는 방식
        - DEFAULT와 NOT NULL은 테이블 레벨에서 정의할 수 없다.
*/
CREATE TABLE coffees3 (
    cid         NUMBER(3),
    cname   VARCHAR2(30),
    cprice    NUMBER(5)
        CONSTRAINT c3_price_nn NOT NULL,
    ccode   CHAR(2),
        CONSTRAINT c3_id_pk PRIMARY KEY (cid),
        CONSTRAINT c3_name_uk UNIQUE (cname),
        CONSTRAINT c3_code_chk CHECK (ccode LIKE '%K%')
);

SELECT * FROM user_constraints WHERE table_name = 'COFFEE3';

/*
        # 외래키 설정하기
        
            - 외래키 제약조건은 설정할 때 어떤 테이블의 어떤 컬럼을 참조할 것인지를 명확하게 지정해야 한다.
            - 외래키가 참조할 수 있는 컬럼은 PK 또는 UNIQUE 제약조건이 설정되어 있어야 한다.
            - 외래키 제약 조건이 걸린 컬럼은 참조하는 컬럼에 존재하는 값 또는 null 만 추가할 수 있다.
*/
-- 1번 방식으로 외래키 설정
CREATE TABLE coffees4 (
    coffee_id        NUMBER(10) CONSTRAINT c4_id_pk PRIMARY KEY,
    coffee_name   VARCHAR2(30),
    coffee_price    NUMBER(15),
    location_id      NUMBER(4)
        CONSTRAINT c4_loc_fk REFERENCES locations (location_id)
);

INSERT INTO coffees4 VALUES(1, 'Americano', 1500, 1600);
INSERT INTO coffees4 VALUES(2, 'Americano', 1500, 1700);

SELECT * FROM coffees4 INNER JOIN locations USING (location_id);

-- 2번 방식으로 외래키 구축
CREATE TABLE coffees5 (
    coffee_id        NUMBER(10),
    coffee_name   VARCHAR2(30),
    coffee_price    NUMBER(15),
    location_id      NUMBER(4)       
);
--  ADD CONSTRAINT 제약조건명 FOREIGN KEY (자식키컬럼) REFERNCES 부모테이블(부모키컬럼)
ALTER TABLE coffees5 ADD CONSTRAINT c5_loc_fk
        FOREIGN KEY (location_id) REFERENCES locations(location_id);

SELECT * FROM user_constraints WHERE table_name = 'COFFEES5';

CREATE TABLE coffees6 (
    coffee_id        NUMBER(10),
    coffee_name   VARCHAR2(30),
    coffee_price    NUMBER(15),
    location_id      NUMBER(4),
    CONSTRAINT c6_loc_fk FOREIGN KEY (location_id) REFERENCES locations (location_id)
);

/*
    # 외래키 삭제 정책
    
        - 외래키가 참조하고 있던 부모 레코드가 삭제되는 경우에 대한 정책 설정
        
        (1) ON DELETE CASCADE
            
            부모 레코드가 삭제되면 자식 레코드들도 함께 삭제
            
        (2) ON DELETE SET NULL
        
            부모 레코드가 삭제되면 자식 레코드들의 값을 NULL로 변경
            
        (3) RESTRICT (기본값)
        
            부모 레코드를 삭제하려고 할 때 자식 레코드가 존재하면 삭제를 막는다.
            외래키 제약 조건 생성시 삭제 정책을 지정하지 않으면 기본적으로 RESTRICT가 된다.
            
*/

-- locations2 생성
CREATE TABLE locations2 AS (SELECT * FROM locations);

-- Coffees6과 locations2를 외래키로 설정하기 위해 기존 제약조건 삭제
-- ※ 제약조건 삭제하기 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE coffees6 DROP CONSTRAINT c6_loc_fk;
ALTER TABLE coffees6 DROP CONSTRAINT c6_loc2_fk;

-- locations2 테이블을 복사할 때 함께 복사되지 않은 기본키 제약 조건을 설정
ALTER TABLE locations2 ADD CONSTRAINT loc2_id_pk PRIMARY KEY (location_id);
DESC locations2;

-- Coffees6과 locations2를 외래키로 설정
ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2(location_id); -- RESTRICT

ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2(location_id) ON DELETE CASCADE; -- CASCADE (함께 삭제)

ALTER TABLE coffees6 ADD CONSTRAINT c6_loc2_fk FOREIGN KEY (location_id)
    REFERENCES locations2(location_id) ON DELETE SET NULL; -- SET NULL (자식 레코드 NULL처리)

SELECT * FROM locations2;
SELECT * FROM coffees6;
-- 자식 레코드가 없는 부모 레코드 삭제
DELETE FROM locations2 WHERE location_id = 1000;

-- 자식 레코드가 있는 부모 레코드의 경우 삭제 정책의 영향을 받음
DELETE FROM locations2 WHERE location_id = 2000;
DELETE FROM locations2 WHERE location_id = 3200;
DELETE FROM locations2 WHERE location_id = 3100;
SELECT * FROM coffees6;

INSERT INTO coffees6 VALUES(1,'Americano',123,1300);
INSERT INTO coffees6 VALUES(1,'Cafe Latte',222,2000);
INSERT INTO coffees6 VALUES(1,'Caffe Mocha',333,2900);
INSERT INTO coffees6 VALUES(1,'Americano',300,3100);
INSERT INTO coffees6 VALUES(1,'Green Tea',400,3200);

SELECT * FROM coffees6;
DESC coffees6;

SELECT * FROM user_constraints WHERE table_name = 'COFFEES6';