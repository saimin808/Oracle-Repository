-- 12_������ �߰�, ����, ����.sql

/*
    # ���̺� ������ �߰�
    
        INSERT INTO ���̺�� (�÷���, ...) VALUES(��, ...);
*/
DESC fruits;

INSERT INTO fruits (name, sweet, price, country_id) VALUES('grape', 10.3, 3800,'KR');

-- �÷��� ������ �ٲ� ���� �ִ� (���� ������ �ٲ�� �Ѵ�)
INSERT INTO fruits(price, name, sweet, country_id) VALUES(800, 'Gyul', 5.5, 'EN');

-- �÷��� �ݵ�� ��� ���� �ʿ�� ���� (������ ���� null�� �ȴ�)
INSERT INTO fruits(price, name) VALUES(1500, 'Apple');

-- �÷��� �ƿ� ���� �ʴ� �͵� �����ϴ� (VALUES���� ��� �÷��� ���� ������� ����� �Ѵ�)
INSERT INTO fruits VALUES('Pine Apple', 9.99, 8800, 'US');

-- ���� ������ ���� INSERT �ϱ� (�÷� ������ �����ؾ� ���簡 �����ϴ�)
INSERT INTO fruits (SELECT * FROM fruits);
INSERT INTO fruits (SELECT * FROM employees); -- �Ұ���

SELECT * FROM fruits;
SELECT * FROM countries;
SELECT * FROM fruits LEFT OUTER JOIN countries USING (country_id) ORDER BY country_id;

/*
    # ���̺� ������ �����ϱ�
    
        UPDATE ���̺�� SET �÷�=��, ... WHERE ����
*/
-- �⺻���� ������ ����
UPDATE fruits SET name = 'Grape' WHERE name = 'grape';

-- ������ �����ʰ� �����͸� �����ϸ� ��� ���� �����ϰ� �ȴ� (�� ���� ���� �ʵ��� �����ؾ� ��)
UPDATE fruits SET country_id = 'CA';

-- ����1 : �絵�� 10 �̸��� ����� �������� ������� �����ϱ�
UPDATE fruits SET country_id = 'BR' WHERE sweet < 10;

-- ����2 : ���� ������ 400�� ������Ű��
UPDATE fruits SET price = price + 400 WHERE name = 'Gyul';

SELECT * FROM fruits;

/*
    # ���̺� ������ �����ϱ�
    
        DELETE FROM ���̺�� WHERE ����;
*/
-- ������ �����ϴ� ���� ��� �����Ѵ�.
DELETE FROM fruits WHERE name LIKE '%Apple%';

-- ������ ���� ������ ��� ���� �����ǹǷ� �����ؾ� �Ѵ�.
DELETE FROM fruits;

SELECT * FROM fruits;

-- ���� 1 : ������ ���� �����ߴ� ���̺��� �����غ���
CREATE TABLE players (
    back_number NUMBER(2), -- ���ȣ
    position        CHAR(2),      -- ������
    first_name     VARCHAR2(50), -- �̸�
    last_name     VARCHAR2(50),
    region           VARCHAR2(20),    -- ����
    coach           VARCHAR2(50)    -- ��� ��ġ
);
DROP TABLE players;

CREATE TABLE staffs (
    s_num          NUMBER(2), -- ������ ��ȣ (��å��)
    first_name     VARCHAR2(50), -- �̸�
    last_name     VARCHAR2(50),
    region           VARCHAR2(20), -- ����
    position        VARCHAR2(20) -- ��å
);
DROP TABLE staffs;

SELECT * FROM tab;
-- ���� 2 : ���̺� �����͸� ������ �߰��غ���
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


-- ���� 3 : �� ���̺��� JOIN�Ͽ� ���ϴ� �����͸� ��ȸ�غ���
-- �̳� ����
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
    
-- 2.  ��� ��ġ first_name�� 'Arteta'�� ���� ã��
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
    
-- last_name�� Ramsdale�� ������ ��� ��ġ ã�� (���� ���� ����)
SELECT
    *
FROM
    staffs
WHERE
    last_name = (SELECT coach FROM players WHERE last_name = 'Ramsdale'); 