-- ���� �ּ�
/*
    ���� �� �ּ�
*/

/*
    # Oracle XE Database 11g �ٿ�ε� �� ��ġ
    
        1. ���۸�
        2. �ٿ�ε� �� ��ġ
        
    # ��ġ �� ������ ��
        
        1. ��ġ ��θ� �� ����� �� �� (C:/oraclexe)
        2. ��ġ �� ��Ʈ��ȣ�� �� ����� �� �� (1521, 8080, 2030, ...)
        3. ��ġ �� ������ ��й�ȣ�� ���� �� ��
        
    # ��ġ �� �ܼ� üũ
    
        1. sqlplus
        2. ������ �������� �α��� (ID : sys as sysdba)
        3. SELECT * FROM tab; (�Ǵ� tabs)
        4. SELECT * FROM all_users;
        
    # ������ ����(HR) ���
    
        1. ������ �������� �α���
        2. ALTER USER hr ACCOUNT UNLOCK; (hr ������ ��� ����)
        3. ALTER USER hr IDENTIFIED BY password; (hr ������ ��й�ȣ ����)
        
    # SQLDeveloper ��ġ
    
        1. ���۸� �� �ٿ�ε� �� ��ġ
        2. ���ϴ� ������ �����Ͽ� GUI ȯ�濡�� DB�� �ٷ� �� ����.
        3. ���� �� ��Ʈ��ȣ�� ����� �����Ǿ����� üũ�� ��
*/
-- ���� ������ ���̺� ��� ���� (�������� ������ �ִ� ���̺��� �ٸ���)
Select * From tab; 

Select * From countries;
Select * From employees;
Select * From departments;
Select * From emp_details_view;
Select * From jobs;