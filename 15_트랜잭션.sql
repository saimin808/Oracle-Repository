--15_Ʈ�����.sql

/*
    # Ʈ����� (Transaction)
  
        - �ϳ��� �۾� ���� (ex: �۱�)
        - Ʈ����ǿ� ���� ��� �۾��� ���������� �Ϸ�Ǵ� ��쿡��
           ��������� Ȯ�� ���� �� �ִ� ����� �����Ѵ�. (All or Nothing)
        - Ʈ������� �����ϱ� ���� Ű����δ� COMMIT, ROLLBACK, ROLLBACK TO, SAVEPOINT�� �ִ�.
        - �ϳ��� Ʈ������� ���������� ����� Ŀ�����κ��� ���ο� Ŀ���� �����ϱ� ������ ����Ǵ� ��� DML���� �ǹ��Ѵ�.
            (INSERT, UPDATE, DELETE�� Ʈ����� ������ ���������
                CREATE TABLE ���� DB ������Ʈ�� ��ȭ�� Ʈ����� ������ ����� �ƴϴ�)
*/
SELECT * FROM fruits;
DESC fruits;

COMMIT; -- ���� Ŀ���� ���ٸ� ROLLBACK�� ������ Ŀ�� ���·� ���ƿ� �� �ִ�.

UPDATE fruits SET price = price + 500 WHERE name LIKE '%apple%';
UPDATE fruits SET name = 'pineapple' WHERE name = 'banana';
UPDATE fruits SET price = price + 500 WHERE name LIKE '%apple%';

SAVEPOINT savepoint01; -- ���̺� ����Ʈ�� �����Ѵ�.

INSERT INTO fruits VALUES('kiwi', 8.88, 2000, 'BR', 'C+');
INSERT INTO fruits VALUES('gold kiwi', 9.88, 2200, 'US', 'B+');
INSERT INTO fruits VALUES('red kiwi', 10.88, 2500, 'US', 'A+');

SAVEPOINT kiwipoint;

INSERT INTO fruits VALUES('melon', 8.88, 2000, 'BR', 'C+');
INSERT INTO fruits VALUES('gold melon', 9.88, 2200, 'US', 'B+');
INSERT INTO fruits VALUES('red melon', 10.88, 2500, 'US', 'A+');

ROLLBACK; -- ���� �ֱ� Ŀ�� ���·� �ǵ��ư���.
ROLLBACK TO savepoint01; -- ���ϴ� ���̺� ����Ʈ ���·� �ǵ��ư���.
ROLLBACK TO kiwipoint;
commit;
SELECT * FROM fruits;
