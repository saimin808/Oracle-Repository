-- 19_계정 관리하기.sql (관리자로 접속해야 새로운 계정에 권한을 부여해줄수 있다)

CONNECT sys as sysdba;
SHOW user;

-- 새 계정 생성하기
CREATE USER testuser IDENTIFIED BY "password";

-- 유저 데이터 딕셔너리 뷰
SELECT * FROM all_users;

-- 유저에게 권한 주기 (GRANT)
GRANT CREATE SESSION TO testuser;   -- 접속 권한 주기
GRANT CREATE TABLE TO testuser;       -- 테이블 생성 권한 주기
GRANT RESOURCE TO testuser;             -- DB 저장 공간 사용 권한 주기

CONNECT testuser;
-- 유저의 권한 뺏기 (REVOKE ... FROM)
REVOKE CREATE TABLE FROM testuser;
GRANT RESOURCE TO testuser;
-- 비밀번호 바꾸기
ALTER USER testuser IDENTIFIED BY "1234";

--계정 삭제하기
DROP USER TESTUSER;

