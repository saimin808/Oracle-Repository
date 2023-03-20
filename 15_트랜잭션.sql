--15_트랜잭션.sql

/*
    # 트랜잭션 (Transaction)
  
        - 하나의 작업 단위 (ex: 송금)
        - 트랜잭션에 속한 모든 작업이 정상적으로 완료되는 경우에만
           변경사항을 확정 지을 수 있는 기능을 제공한다. (All or Nothing)
        - 트랜잭션을 관리하기 위한 키워드로는 COMMIT, ROLLBACK, ROLLBACK TO, SAVEPOINT가 있다.
        - 하나의 트랜잭션은 마지막으로 실행된 커밋으로부터 새로운 커밋을 실행하기 전까지 수행되는 모든 DML만을 의미한다.
            (INSERT, UPDATE, DELETE는 트랜잭션 관리의 대상이지만
                CREATE TABLE 등의 DB 오브젝트의 변화는 트랜잭션 관리의 대상이 아니다)
*/
SELECT * FROM fruits;
DESC fruits;

COMMIT; -- 다음 커밋이 없다면 ROLLBACK시 마지막 커밋 상태로 돌아올 수 있다.

UPDATE fruits SET price = price + 500 WHERE name LIKE '%apple%';
UPDATE fruits SET name = 'pineapple' WHERE name = 'banana';
UPDATE fruits SET price = price + 500 WHERE name LIKE '%apple%';

SAVEPOINT savepoint01; -- 세이브 포인트를 생성한다.

INSERT INTO fruits VALUES('kiwi', 8.88, 2000, 'BR', 'C+');
INSERT INTO fruits VALUES('gold kiwi', 9.88, 2200, 'US', 'B+');
INSERT INTO fruits VALUES('red kiwi', 10.88, 2500, 'US', 'A+');

SAVEPOINT kiwipoint;

INSERT INTO fruits VALUES('melon', 8.88, 2000, 'BR', 'C+');
INSERT INTO fruits VALUES('gold melon', 9.88, 2200, 'US', 'B+');
INSERT INTO fruits VALUES('red melon', 10.88, 2500, 'US', 'A+');

ROLLBACK; -- 가장 최근 커밋 상태로 되돌아간다.
ROLLBACK TO savepoint01; -- 원하는 세이브 포인트 상태로 되돌아간다.
ROLLBACK TO kiwipoint;
commit;
SELECT * FROM fruits;
