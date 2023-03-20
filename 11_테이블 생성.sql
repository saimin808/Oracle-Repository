-- 11_���̺� ����.sql

/*
    # CRUD
        
        -   ��κ��� ���α׷��� ������ �ִ� �⺻���� ������ ó���� �ٿ� ǥ���� ��
        -   Create  (���̺� ���� ����)
        -   Read    (���̺� ���� �б�)
        -   Update (���̺� ���� ����)
        -   Delete  (���̺� ���� ����)
        
    # DML (Data Manipulate Language, ������ ���۾�)
    
        -   INSERT   :   ������ �߰� ���� (DB�� Create)
        -   SELECT  :   ������ �д� ���� (DB�� Read) 
        -   UPDATE  :   ������ ���� ���� (DB�� Update)
        -   DELETE  :   ������ ���� ���� (DB�� Delete)
    
    # DDL (Data Definition Language, ������ ���Ǿ�)
    
        -   ���̺�, ������, ��, �ε���, DB���� �� DB ������Ʈ�� �����ϴ� ��ɾ�
        -   CREATE :   DB ������Ʈ ����
        -   ALTER   :   DB  ������Ʈ ���� (ALTER USER...)
        -   DROP     :   DB ������Ʈ ���� (������)
        -   TRUNCATE    :   DB ������Ʈ ���� ����
    
    # DCL (Data Control Language, ������ ���� ��ɾ�)
        
        -   DB ������ ������ �ο��ϰų� ��Ż�ϴ� ��ɾ�
        -   GRANT   :   ���� �ο�
        -   REVOKE  :   ���� ȸ��
        
*/

/*
    # ���̺� �����ϱ�
    
        CREATE TABLE ���̺�� (�÷���1 �÷�Ÿ��1, �÷���2 �÷�Ÿ��2, ....);
*/
CREATE TABLE fruits (
    name       VARCHAR2(30),
    sweet       NUMBER(4,2),
    price        NUMBER(7),
    country_id CHAR(2)
);
-- ������ ��ųʸ� : tabó�� DB�� �˾Ƽ� �����ϴ� �����Ϳ� ���� ������ (��Ÿ ������)
SELECT * FROM tab;
SELECT * FROM all_users;

-- ���̺� ���� : DROP TABLE ���̺��;
DROP TABLE fruits;

-- DROP TABLE�� ������ ���̺��� �����뿡 ����ִ�.
SHOW recyclebin;
SELECT * FROM recyclebin;

-- �����뿡 �ִ� �����ߴ� ���̺� �����ϱ�
FLASHBACK TABLE fruits TO BEFORE DROP;

SELECT * FROM tab;

-- ������ ����
PURGE recyclebin;

-- ���� ���̺��� �����Ͽ� �� ���̺� �����ϱ�
CREATE TABLE employees2 AS (SELECT * FROM employees);
SELECT * FROM employees2;
DESC employees2;

-- ���� ���̺��� ������ �����Ͽ� �� ���̺� �����ϱ� (�Ϻη� ���� ������ ��ȸ)
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0);
SELECT * FROM employees3;
DESC employees3;