-- 17.������.sql

/*
    # ������
    
        -   �⺻Ű�� ����ϱ� ���ϵ��� ������� DB ������Ʈ
        -   �ڵ� ��ȣ ������
        
        CREATE SEQUENCE ��������
                                            [START WITH n]                            - ��ȣ�� n������ ����
                                            [INCREMENT BY n]                       - ���ڰ� n�� ����
                                            [MAXVALUE n | NOMAXVALUE]    - �ڵ� ���� ��ȣ�� �ִ밪 ����
                                            [MINVALUE n | NOMINVALUE]       - �ڵ� ���� ��ȣ�� �ּҰ� ����
                                            [CYCLE | NOCYCLE]                    - �ִ밪�� �Ѿ��� �� ��ȣ�� ��ȯ ���θ� ����
                                            [CACHE n | NOCACHE]                 - ��ȣ�� ��ŭ �̸� ������ �������� ����
*/
SELECT * FROM tab;

CREATE TABLE animals (
    animal_id           NUMBER(4)
        CONSTRAINT animal_id_pk PRIMARY KEY,
    animal_name     VARCHAR2(25),
    animal_age        NUMBER(3) DEFAULT 0
);

SELECT * FROM animals;

-- ������ ������ ��ųʸ� ��
SELECT * FROM all_sequences;
SELECT * FROM user_sequences;

-- ID�� ����ϱ� ���� �������� ���� (�⺻ �ɼ�)
-- �⺻ �ɼ� : ���۰� 1, ������ 1, �ִ밪 ��û ŭ, ĳ��ũ�� 20, ��ȯ X
CREATE SEQUENCE animals_seq;

-- seq.nextval�� ȣ���ϸ� ���� ���� ������ (1����)
INSERT INTO animals (animal_id, animal_name) VALUES(animals_seq.nextval, 'ȣ����');

-- ������ ���� �ѹ� �����ϸ� �ٽ� �������� �ʴ´�. (�ѹ� �Ұ���)
ROLLBACK;

-- seq.currval�� ���� ���� ���� Ȱ���� �� �ִ�. (���� ����)
SELECT animals_seq.currval FROM dual;
-- nextval�� ���� ��ȸ�ϸ� ���� ������ ������.
SELECT animals_seq.nextval FROM dual;

-- dual : �����Ͱ� �� �� ����ִ� ������ ���̺�
SELECT * FROM dual;

-- ���� �׽�Ʈ �ϰ� ���� �� ���� ���� ���̺��� ���� �ش� ���� �ุŭ ������ ������ �����ϴ�.
SELECT 1+5 FROM employees;
-- �׷��� �� �ุ �ִ� dual�� ����Ѵ�.
SELECT 1+5 FROM dual;

-- CYCLE�� �����ϸ� �ִ밪 ���޽� �ּҰ����� �ٽ� ���ƿ´�.
CREATE SEQUENCE sequence_practice
            MINVALUE 100 MAXVALUE 9999 INCREMENT BY 100 CYCLE NOCACHE;

SELECT * FROM user_sequences;
SELECT sequence_practice.nextval FROM dual;

-- ������ �����ϱ� (������ ����)
ALTER SEQUENCE sequence_practice MAXVALUE 900;

-- ������ �����ϱ�
DROP SEQUENCE sequence_practice;

SHOW recyclebin;

PURGE recyclebin;
