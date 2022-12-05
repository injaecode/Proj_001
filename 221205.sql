select * from myTbl;

insert into myTbl value('1','1234');
commit

select *from myTbl;

-- ���� �ּ�: ���α׷����� �ؼ����� �ʴ� ����
/*
������ �ּ�
*/
--1. HR���� ���� : 12�������� ���� ���� �� ������ �տ� C## ���� �ʼ�
--  system �������� ������ ����â���� ��� �ʿ�
-- HR: ������ / ��ȣ : 1234
create user C##HR identified by 1234;

--2. HR ������ ���� �ο� : 
/* connect : ���ݿ��� DB�� ������ �� �ִ� ���� �ο�
   resource : ��ü(resource-table, index, view, store procedure, triger, function)�� ����, ����, ������ �� �ִ� ������ �ο�
*/

grant connect, resource to C##HR;
--3. ���̺� �����̽��� ����� ���� �ο�
    -- USERS ���̺� �����̽��� ��뷮�� ������ ����� �� �ֵ��� ���� ����
alter user C## quota unlimited on USERS;

--4. HR ���� ���� - ���� ������ �Ǿ��ִ� ��� ���� �Ұ�. ������ ���� ���� �� ���� ����
drop user C##HR;

show user;
