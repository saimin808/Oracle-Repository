-- 12_데이터 추가, 수정, 삭제.sql

/*
    # 테이블에 데이터 추가
    
        INSERT INTO 테이블명 (컬럼명, ...) VALUES(값, ...);
*/
DESC fruits;

INSERT INTO fruits (name, sweet, price, country_id) VALUES('grape', 10.3, 3800,'KR');

-- 컬럼의 순서를 바꿀 수도 있다 (값의 순서도 바꿔야 한다)
INSERT INTO fruits(price, name, sweet, country_id) VALUES(800, 'Gyul', 5.5, 'EN');

-- 컬럼을 반드시 모두 적을 필요는 없다 (생략한 값은 null이 된다)
INSERT INTO fruits(price, name) VALUES(1500, 'Apple');

-- 컬럼을 아예 적지 않는 것도 가능하다 (VALUES에는 모든 컬럼의 값을 순서대로 적어야 한다)
INSERT INTO fruits VALUES('Pine Apple', 9.99, 8800, 'US');

-- 서브 쿼리를 통해 INSERT 하기 (컬럼 구조가 동일해야 복사가 가능하다)
INSERT INTO fruits (SELECT * FROM fruits);
INSERT INTO fruits (SELECT * FROM employees); -- 불가능

SELECT * FROM fruits;
SELECT * FROM countries;
SELECT * FROM fruits LEFT OUTER JOIN countries USING (country_id) ORDER BY country_id;

/*
    # 테이블 데이터 수정하기
    
        UPDATE 테이블명 SET 컬럼=값, ... WHERE 조건
*/
-- 기본적인 데이터 수정
UPDATE fruits SET name = 'Grape' WHERE name = 'grape';

-- 조건을 적지않고 데이터를 수정하면 모든 행을 수정하게 된다 (※ 절대 하지 않도록 주의해야 함)
UPDATE fruits SET country_id = 'CA';

-- 연습1 : 당도가 10 미만인 행들의 원산지를 브라질로 변경하기
UPDATE fruits SET country_id = 'BR' WHERE sweet < 10;

-- 연습2 : 귤의 가격을 400원 증가시키기
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';

SELECT * FROM fruits;

/*
    # 테이블 데이터 삭제하기
    
        DELETE FROM 테이블명 WHERE 조건;
*/
-- 조건을 만족하는 행을 모두 삭제한다.
DELETE FROM fruits WHERE name LIKE '%Apple%';

-- 조건을 적지 않으면 모든 행이 삭제되므로 주의해야 한다.
DELETE FROM fruits;

SELECT * FROM fruits;

-- 연습 1 : 예전에 직접 설계했던 테이블을 생성해보기
CREATE TABLE players (
    back_number NUMBER(2), -- 등번호
    position        CHAR(2),      -- 포지션
    first_name     VARCHAR2(50), -- 이름
    last_name     VARCHAR2(50),
    region           VARCHAR2(20),    -- 국적
    coach           VARCHAR2(50)    -- 담당 코치
);
DROP TABLE players;

CREATE TABLE staffs (
    s_num          NUMBER(2), -- 스태프 번호 (직책순)
    first_name     VARCHAR2(50), -- 이름
    last_name     VARCHAR2(50),
    region           VARCHAR2(20), -- 국적
    position        VARCHAR2(20) -- 직책
);
DROP TABLE staffs;

SELECT * FROM tab;
-- 연습 2 : 테이블에 데이터를 적당히 추가해보기
INSERT INTO players VALUES (7, 'FW', 'Bukayo', 'Saka', 'England', 'Arteta');
INSERT INTO players VALUES (34, 'MF', 'Granit', 'Xhaka', 'Swiss', 'Stuivenberg');
INSERT INTO players VALUES (12, 'DF', 'William', 'Saliba', 'France', 'Arteta');
INSERT INTO players VALUES (1, 'GK', 'Aaron','Ramsdale', 'England', 'Cena');
SELECT * FROM players ORDER BY back_number;

INSERT INTO staffs VALUES (1, 'Mikel', 'Arteta', 'Spain', 'Head Coach');
INSERT INTO staffs VALUES (2, 'Oliver', 'Stuivenberg', 'Netherland', 'MF Coach');
INSERT INTO staffs VALUES (3, 'Ferran', 'Molina', 'Spain', 'DF Coach');
INSERT INTO staffs VALUES (4, 'Marcos', 'Cena', 'Spain', 'GK Coach');
SELECT * FROM staffs;


-- 연습 3 : 두 테이블을 JOIN하여 원하는 데이터를 조회해보기
-- 이너 조인
SELECT 
    back_number,
    p.position,
    p.first_name || ' ' || p.last_name AS player_name,
    s.first_name || ' ' || s.last_name AS coach_name,
    s.position AS coach_position
FROM
    players p INNER JOIN staffs s
ON
    p.coach = s.last_name;
    
-- 2.  담당 코치 first_name이 'Arteta'인 선수 찾기
SELECT
    p.position,
    p.first_name || ' ' || p.last_name AS player_name,
    s.first_name || ' ' || s.last_name AS coach_name
FROM
    players p INNER JOIN staffs s
ON
    p.coach = s.last_name
WHERE
    s.last_name = 'Arteta';
    
-- last_name이 Ramsdale인 선수의 담당 코치 찾기 (단일 서브 쿼리)
SELECT
    *
FROM
    staffs
WHERE
    last_name = (SELECT coach FROM players WHERE last_name = 'Ramsdale'); 