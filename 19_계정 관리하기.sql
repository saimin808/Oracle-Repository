-- 19_���� �����ϱ�.sql (�����ڷ� �����ؾ� ���ο� ������ ������ �ο����ټ� �ִ�)

CONNECT sys as sysdba;
SHOW user;

-- �� ���� �����ϱ�
CREATE USER testuser IDENTIFIED BY "password";

-- ���� ������ ��ųʸ� ��
SELECT * FROM all_users;

-- �������� ���� �ֱ� (GRANT)
GRANT CREATE SESSION TO testuser;   -- ���� ���� �ֱ�
GRANT CREATE TABLE TO testuser;       -- ���̺� ���� ���� �ֱ�
GRANT RESOURCE TO testuser;             -- DB ���� ���� ��� ���� �ֱ�

CONNECT testuser;
-- ������ ���� ���� (REVOKE ... FROM)
REVOKE CREATE TABLE FROM testuser;
GRANT RESOURCE TO testuser;
-- ��й�ȣ �ٲٱ�
ALTER USER testuser IDENTIFIED BY "1234";

--���� �����ϱ�
DROP USER TESTUSER;

