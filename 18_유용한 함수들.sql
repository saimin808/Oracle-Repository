-- 18_������ �Լ���.sql

/********** ���� Ÿ�� �Լ��� **********/

-- to_number(data) : �����͸� ���� Ÿ������ ��ȯ
SELECT to_number('12341234') FROM dual;

-- ������ �ִ� ���ڿ��� ���ڷ� ��ȯ
SELECT to_number('$5,000,000', '999,999,999$') FROM dual;
SELECT to_number('5,000,000��', '999,999,999L') FROM dual;

-- abs(n) : ���밪
SELECT -7 FROM dual;
SELECT abs(-7) FROM dual;

-- floor(n) : ����
SELECT 3.9 FROM dual;
SELECT floor(3.555) FROM dual;

-- ceil(n) : �ø�
SELECT 3.146295 FROM dual;
SELECT ceil(3.146295) FROM dual;

-- round(n) : �ݿø�
SELECT round(3.444) FROM dual;
SELECT round(3.555) FROM dual;

-- mod(n,m) : ������ ����
SELECT mod(99, 10) FROM dual;

-- trunc(value, n) : �ش� ���� n�ڸ� ���ϸ� �߶󳽴�. (������ ����)
SELECT trunc(1234567.1234567, 3) FROM dual;
SELECT trunc(1234567.1234567, 5) FROM dual;
SELECT trunc(1234567.1234567, -2) FROM dual;
SELECT trunc(1234567.1234567, -5) FROM dual;

/******** ���� Ÿ�� �Լ��� *********/

-- to_char(data) : ������ �����͸� ���� Ÿ������ ��ȯ (����, ��¥ ���)
SELECT to_char(12345) FROM dual;
SELECT to_DATE(20341212) FROM dual;
-- sysdate : ���� ��¥ �� �ð�
SELECT sysdate FROM dual;

-- ��¥ Ÿ���� ���� Ÿ������ ��ȯ ��Ű�鼭 ������ ������ �� �ִ�.
SELECT to_char(sysdate, 'YYYY/MM/DD HH:MI:SS') FROM dual;

-- ���� Ÿ���� ���ڷ� ��ȯ�� �� ����� �� �ִ� ����
--          9 : �ش� �ڸ��� ���ڰ� ���´�. (0�� ä���� �ʴ´�.)
--          0 : �ش� �ڸ��� ���ڰ� ���´�. (0�� ä���.)
--          L : �ش� ������ ȭ�� ��ȣ�� �ǹ��Ѵ�.
SELECT to_char(5000000, '000,000,000L') FROM dual;
SELECT to_char(5000000, '999,999,999L') FROM dual;
SELECT to_char(5000000, '999,999,999$') FROM dual;

-- lpad(����, ��ü����, ä�﹮��) : ���ʿ� ���ϴ� ���ڸ� ä���.
SELECT lpad('apple', 10, '#') FROM dual;
SELECT lpad('apple', 20, '#') FROM dual;

-- rpad(����, ��ü����, ä�﹮��) : �����ʿ� ���ϴ� ���ڸ� ä���.
SELECT rpad('apple', 10, '#') FROM dual;
SELECT rpad(first_name, 20, convert(VARCHAR2(2), employees_seq)) FROM employees;

-- ä�� ���ڴ� �������� ���� ���� �ִ�.
SELECT rpad('apple', 20, 'abc') FROM dual;
SELECT lpad(phone_number, 16, '010.') FROM employees; 

-- ltrim(����, ���Ŵ����) : ������ ���ڸ� ����
SELECT ltrim('##########apple', '#') FROM dual;

-- rtrim(����, ���Ŵ����) : �������� ���ڸ� ����
SELECT rtrim('apple#################', '#') FROM dual;

-- �����ϴ� ��� ���ڸ� �����ش� (�ٸ����ڰ� �� ������ �������� ����)
SELECT rtrim('apple!@#!@#!@#!@#!@#!@#!@####!@!!!!@', '!@#') FROM dual;

-- trim() : �ٱ��� ���� ���� (���� ���)
SELECT '    ABC TEST        '   FROM dual;
SELECT trim('   ABC TEST        ') FROM dual;

-- �ٱ����� �ٸ� ���ڸ� �����ϰ� ���� ���
SELECT trim('#' from '####ABC TEST########') FROM dual;

-- substr(����, ������ġ, ����) : 3��° ���� ������ �ε����� �ƴ϶� �ڸ��� ������ ������ �ǹ�
SELECT substr('Hello,world!', 3, 8) FROM dual;
SELECT substr('Hello,world!', 3) FROM dual; -- ������ ���� �ȳ����� ������ �ڸ�
SELECT substr('Hello,world!', -1) FROM dual; -- ���̳ʽ� ���� ������ �ڿ������� �� ��ġ�� �ǹ�
SELECT substr('Hello,world!', -2) FROM dual;
SELECT substr('Hello,world!', -5, 3) FROM dual;

-- �ε����� 1���� ���Ƿ� ������ ��
SELECT substr('�Ƹ޸�ī��', 0, 3) FROM dual; -- 0�� �־ 1���� ����
SELECT substr('�Ƹ޸�ī��', 2, 3) FROM dual; -- 1�̻��� ������ ���� �ڸ����� ����

-- length(str) : ����
SELECT length('�Ƹ޸�ī��') FROM dual;
SELECT lengthb('�Ƹ޸�ī��') FROM dual; -- byte ���� (�ѱ��� 3byte�� ������)

-- upper(str), lower(str) : �빮��, �ҹ���

-- initcap(str) : ù ���ڸ� �빮��
SELECT email FROM employees;
SELECT initcap(email) FROM employees;

-- replace(str, old, new) : ���� ��ü
SELECT replace('minsu@naver.com', 'naver', 'google') FROM dual;

/******** ��¥ Ÿ�� �Լ��� *********/

-- to_date(data) : �����͸� ��¥ Ÿ������ ��ȯ
SELECT to_date('2022-11-24') FROM dual;
SELECT to_date('2022--11--24', 'YYYY--MM--DD') FROM dual; -- ���� ������ �����ϴ�.
SELECT to_date('2022.....11.....24', 'YYYY.....MM.....DD') FROM dual; -- ������ -�� .�� ����

-- trunc(date type) : ��¥�� �߶󳻴� ���� �����ϴ�.
SELECT trunc(sysdate, 'day') FROM dual; -- 22/11/20     -- �� ������ �ڸ�
SELECT trunc(sysdate, 'month') FROM dual; -- 22/11/01 -- �� ������ �ڸ�
SELECT trunc(sysdate, 'year') FROM dual; -- 22/01/01    -- �� ������ �ڸ�