-- 14_���̺� �����ϱ�.sql

/*
        # ���̺� �� �÷� �߰��ϱ�
        
            - ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ�� [��������], ...);
            - �� �÷��� �߰��� ���� ���� ����� �߰� �÷� ���� NULL�� �ȴ�.
            - DEFAULT�� ������ ������ ���ο� �÷��� ���� DEFAULT�� �Ͽ� �߰��Ѵ�.
*/
ALTER TABLE fruits ADD (
    grade VARCHAR2(2)
        CONSTRAINT fruit_grade_chk CHECK (regexp_like (grade, '[ABCDF]?[+- ]?')) -- regexp_like () : ����ǥ����
);
ALTER TABLE fruits DROP CONSTRAINT fruit_grade_chk;
ALTER TABLE fruits ADD CONSTRAINT fruit_grade_chk CHECK (regexp_like (apple_grade, '[ABCDF][+]?'));
-- ���� 1 : fruits ���̺��� country_id�� �ùٸ� �ܷ�Ű ���������� �����غ�����
--             (countries ���̺��� ������ countries2 ���̺�� ������ ��)

-- (1) countries ���̺��� ������ countries2 ���̺��� �����
CREATE TABLE countries2 AS (SELECT * FROM countries);

-- (2) countries2 ���̺� primary key�� �����Ѵ�.
ALTER TABLE countries2 ADD CONSTRAINT country_id_pk PRIMARY KEY (country_id);
SELECT * FROM countries2;

UPDATE fruits SET country_id = null;

-- (3) fruits ���̺� countries2 ���̺��� �⺻Ű(country_id)�� ������ �ܷ�Ű�� �����Ѵ�.
ALTER TABLE fruits ADD CONSTRAINT fruits_counid_fk FOREIGN KEY (country_id)
                REFERENCES countries2(country_id);

-- (*) fruits ���̺� �̹� ���� �����Ѵٸ� ���� �����ְ� (3)�� �����Ѵ�
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
    # ���̺� �÷� �����ϱ�
    
        - ALTER TABLE ���̺�� DROP COLUMN �÷���;
*/

ALTER TABLE fruits DROP COLUMN grade;

SELECT * FROM fruits;

/*
    # ���̺� �÷� �̸� �����ϱ�
    
        - ALTER TABLE ���̺�� RENAME COLUMN �����̸� TO �ٲ��̸�;
*/
ALTER TABLE fruits RENAME COLUMN grade TO fruit_grade;
ALTER TABLE fruits RENAME COLUMN fruit_grade TO apple_grade;

SELECT * FROM fruits;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS';

/*
    # ���̺� �������� �̸� �����ϱ�
    
        - ALTER TABLE ���̺�� RENAME CONSTRAINT �������Ǹ� TO �ٲ��̸�;
*/
ALTER TABLE fruits RENAME CONSTRAINT fruit_grade_chk TO fruit_apple_grade_chk;

/*
    # ���̺� �̸� �����ϱ�
    
        - RENAME ���̺�� TO �ٲ��̸�;
*/
RENAME coffees5 TO coffeesFive;

SELECT * FROM user_tables;

/*
    # �÷� �����ϱ�
    
        - ALTER TABLE ���̺�� MODIFY (�÷��� �÷�Ÿ�� [��������], ...);
        - �̹� �����ϴ� �÷��� ���� ���� �������� ������ �� ���
        - �÷� ũ�⸦ ������ ���� �ִ�.
        - ���ο� ���� ������ ������ ���� �ִ�.
        - NOT NULL, CHECK, DEFAULT�� �̰��� ���� �߰��ؾ� �Ѵ�. 
*/

SELECT * FROM coffeesfive;
DESC coffees;

ALTER TABLE coffeesFive MODIFY (
    coffee_id NUMBER(10),
        CONSTRAINT c5_id_pk PRIMARY KEY (coffee_id)
);

