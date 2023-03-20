-- 17.시퀀스.sql

/*
    # 시퀀스
    
        -   기본키로 사용하기 편리하도록 만들어진 DB 오브젝트
        -   자동 번호 생성기
        
        CREATE SEQUENCE 시퀀스명
                                            [START WITH n]                            - 번호가 n번부터 시작
                                            [INCREMENT BY n]                       - 숫자가 n씩 증가
                                            [MAXVALUE n | NOMAXVALUE]    - 자동 생성 번호의 최대값 설정
                                            [MINVALUE n | NOMINVALUE]       - 자동 생성 번호의 최소값 설정
                                            [CYCLE | NOCYCLE]                    - 최대값을 넘었을 때 번호의 순환 여부를 설정
                                            [CACHE n | NOCACHE]                 - 번호를 얼만큼 미리 생성해 놓을지를 설정
*/
SELECT * FROM tab;

CREATE TABLE animals (
    animal_id           NUMBER(4)
        CONSTRAINT animal_id_pk PRIMARY KEY,
    animal_name     VARCHAR2(25),
    animal_age        NUMBER(3) DEFAULT 0
);

SELECT * FROM animals;

-- 시퀀스 데이터 딕셔너리 뷰
SELECT * FROM all_sequences;
SELECT * FROM user_sequences;

-- ID로 사용하기 위한 시퀀스를 생성 (기본 옵션)
-- 기본 옵션 : 시작값 1, 증가값 1, 최대값 엄청 큼, 캐쉬크기 20, 순환 X
CREATE SEQUENCE animals_seq;

-- seq.nextval을 호출하면 다음 값을 꺼낸다 (1증가)
INSERT INTO animals (animal_id, animal_name) VALUES(animals_seq.nextval, '호돌이');

-- 시퀀스 값은 한번 증가하면 다시 감소하지 않는다. (롤백 불가능)
ROLLBACK;

-- seq.currval을 통해 현재 값을 활용할 수 있다. (증가 안함)
SELECT animals_seq.currval FROM dual;
-- nextval을 통해 조회하면 값이 증가해 버린다.
SELECT animals_seq.nextval FROM dual;

-- dual : 데이터가 한 행 들어있는 연습용 테이블
SELECT * FROM dual;

-- 뭔가 테스트 하고 싶을 때 행이 많은 테이블을 쓰면 해당 값이 행만큼 나오기 때문에 불편하다.
SELECT 1+5 FROM employees;
-- 그래서 한 행만 있는 dual을 사용한다.
SELECT 1+5 FROM dual;

-- CYCLE을 설정하면 최대값 도달시 최소값으로 다시 돌아온다.
CREATE SEQUENCE sequence_practice
            MINVALUE 100 MAXVALUE 9999 INCREMENT BY 100 CYCLE NOCACHE;

SELECT * FROM user_sequences;
SELECT sequence_practice.nextval FROM dual;

-- 시퀀스 수정하기 (문법은 같음)
ALTER SEQUENCE sequence_practice MAXVALUE 900;

-- 시퀀스 삭제하기
DROP SEQUENCE sequence_practice;

SHOW recyclebin;

PURGE recyclebin;
