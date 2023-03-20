-- 한줄 주석
/*
    여러 줄 주석
*/

/*
    # Oracle XE Database 11g 다운로드 및 설치
    
        1. 구글링
        2. 다운로드 및 설치
        
    # 설치 시 주의할 점
        
        1. 설치 경로를 잘 기억해 둘 것 (C:/oraclexe)
        2. 설치 시 포트번호를 잘 기억해 둘 것 (1521, 8080, 2030, ...)
        3. 설치 시 설정한 비밀번호를 잊지 말 것
        
    # 설치 후 콘솔 체크
    
        1. sqlplus
        2. 관리자 계정으로 로그인 (ID : sys as sysdba)
        3. SELECT * FROM tab; (또는 tabs)
        4. SELECT * FROM all_users;
        
    # 연습용 계정(HR) 언락
    
        1. 관리자 계정으로 로그인
        2. ALTER USER hr ACCOUNT UNLOCK; (hr 계정의 잠금 해제)
        3. ALTER USER hr IDENTIFIED BY password; (hr 계정의 비밀번호 변경)
        
    # SQLDeveloper 설치
    
        1. 구글링 후 다운로드 및 설치
        2. 원하는 접속을 생성하여 GUI 환경에서 DB를 다룰 수 있음.
        3. 접속 시 포트번호가 제대로 설정되었는지 체크할 것
*/
-- 현재 계정의 테이블 목록 보기 (계정마다 가지고 있는 테이블이 다르다)
Select * From tab; 

Select * From countries;
Select * From employees;
Select * From departments;
Select * From emp_details_view;
Select * From jobs;