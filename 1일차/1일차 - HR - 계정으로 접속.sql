--1. HR�������� ���� Ȯ�� : resource - ���̺� ����, ����, ���� ����
show user;

--2. ���̺� ����
create table myTbl2 (
   id varchar2 (20),
   pass varchar2 (20)
   );

--3, ���̺� �� �ֱ� : commit(����)
insert into myTbl2 values ('1','1234');
commit; --DB�� ���� ���� (insert, update, delete�������� ���)
--4. ���̺��� �� ���
select * from myTbl2;
--5. ���̺� ����
drop table myTbl2;