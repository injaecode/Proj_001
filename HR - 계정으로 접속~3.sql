--���  ���̺� ����ϱ�
select * from tab;

--���̺��� ���� Ȯ���ϱ�
    --select : ����ϱ�
    /*
    select �÷��� 
    from ���̺� �̸�
    
    */
    
-- 1. employee ���̺��� ��� �÷� ���
    --�ٷ���(��뤷��)�� ���� ������ ����
select *
from employee;

--2. department ���̺��� ��� �÷��� ���
select *
from department;

--3. salgrade ���̺��� ��� �÷�(�ʵ�, ��ƼƼ) ���
    --�Ǹ� ������ �����ϴ� ���̺�
select *
from salgrade;

/*
====================================
�� ���̺��� �÷� ����
1. employee ���̺�
*/
select * from employee;
/*
ENO : �����ȣ
ENAME : �����
JOB : ��å
MANAGER : ����� �����ȣ
HIREDATE : �Ի���
SALARY : ����
COMMISSION : ���ʽ�
DNO : �μ���ȣ
*/

-- 2. �μ� ������ �����ϴ� ���̺�
select * from department;

/*
DNO : �μ���ȣ
DNAME : �μ���
LOC : �μ��� ��ġ
*/

-- 3. �Ǹ� ������ �����ϴ� ���̺�
select * from salgrade ; 
/*
GRADE : ����
LOSAL : ���� ���� ����
HISAL : ���� ���� ����
*/

-- select * : ���̺� �� ��� �� ��� 
-- �÷� = �ʵ� = ��ƼƼ
-- ���ڵ� : �� �÷��� �� ��, 1����
-- ���ڵ� �� : ���ڵ���� ����
select *
from employee;

--Ư�� �÷��� ���
select eno
from employee;

--Ư�� �÷� ������ ��� (, ����� ����
select eno, ename, salary
from employee;

-- ��� �÷� ���
select eno, ename, job, manager, hiredate, salary, commission,dno
from employee; 

--Ư�� �÷��� ��� �� ������ ����ϱ�
select eno, ename, salary, ename, ename
from employee;

--���̺��� ���� Ȯ���ϱ�
DESCRIBE employee;
DESC employee;

--�÷��� ��Ī���� ���
select eno as �����ȣ, ename as �����, job as ��å
from employee;

--employee ���̺��� ��� �÷��� ��Ī���� ����ϱ�
select eno �����ȣ, ename �����, job ��å, manager �����ȣ, 
hiredate �Ի���, salary "����*", commission ���ʽ�, dno "�μ� ��ȣ"
from employee;

--������ ����Ͽ� ��� : where
select *
from employee
where eno = 7499;   --���� ����: eno �÷��� ���� 7499�� �͸� ���

desc employee; -- employee ���̺��� ���� Ȯ��

-- �� ��½� : number ������ Ÿ�� ���� ''���� ���
--           number�̿��� ������ Ÿ���� '' :char, varchar, date..

select * from employee
where job = 'MANAGER' ; --job (varchar2), ���� �����ö��� ��ҹ��ڸ� ����


select * from employee
where dno = 20;

--#�ǽ�#
-- ���� 2000���� �̻� ����ڸ� ���
select * from employee
where salary >=2000;

--�̸��� CLARK�� ������� ���޸� ���
select salary ���� from employee
where ename = 'CLARK';

-- �����ȣ 7788�� �̸��� �Ի糯¥ ���
select ename �̸�, hiredate �Ի糯¥ from employee
where eno = 7788;


/*
<select���� ��ü ����>
select --�÷��� : * (��� �÷�),
form -- ���̺��, �� �̸�
where -- ����
group by -- Ư�� �÷��� ������ ���� �׷�ȭ
Having -- group by���� ���� ����� ���� ó��
Order by -- �����ؼ� ����� Į�� asc: �������� ���� - desc: �������� ����
*/


select distinct dno �μ���ȣ from employee;     --distinct : �ߺ� �� �����Ͽ� ���

-- �÷��� ������ ���� : �÷����� ������. alias(��Ī)�Ͽ� ���
select eno, ename, salary ����, salary*12 ����, commission ���ʽ�
from employee;

--��ü ���� ���ϱ� : ����*12+���ʽ� =��ü ����

select eno, ename, salary, commission,salary*12 ����, (salary*12)+commission as ��ü����
from employee;

--null �÷��� ��Ģ���� �� ���� null�� ���
    -->��ü ������ ����� �� null ���� ���� �÷��� 0���� ������ �� ������ �����ؾ� ��
        -- nvl �Լ� : �÷��� null ���� �ٸ� ������ ��ȯ�� ó�����ִ� �Լ�
        -- nvl (commission,0) : commission �÷��� null�� 0���� ������ ó��
        
select eno, ename, salary, commission,salary*12 ����, (salary*12)+nvl(commission,0) as ��ü����
from employee;

--null���� ���� �÷� ��� �� ���ǻ���
--where commission = null �� ����, null �˻��ÿ��� is ���
select * from employee
where commission is null;

select * from employee
where commission is not null;

--where ���ǿ��� and, or ����ϱ�
    --����) �μ���ȣ�� 20���̰ų� 30���� ��� �÷� ���
select * from employee
where dno = 20 or dno = 30;
    --����) �μ���ȣ�� 20���̰� ������ 1500������ ��� �÷� ���
select * from employee
where dno = 20 and salary <=1500;
    --����) ��å�� MANAGER�̸鼭, ������ 2000�̻��� ����ڸ� ���
select * from employee
where job = 'MANAGER' and salary>=2000;

--�ǽ� 1 : ���ʽ� �÷��� null�� ���� �����ȣ, ��� �̸�, �Ի� ��¥ ���
select eno �����ȣ, ename ����̸�, hiredate �Ի糯¥ from employee
where commission is null;
--�ǽ� 2 : �μ���ȣ�� 20�̰� �Ի糯¥�� 81�� 4�� ������ ����� �̸��� ��å, �Ի� ��¥ ���
select ename ����̸�, job ��å, hiredate �Ի糯¥ from employee
where dno = 20 and hiredate>='81/04/01';
--�ǽ� 3 : ��� ����� ������ ����� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ���� ���
select eno �����ȣ, salary ����, commission ���ʽ�, (salary*12)+nvl(commission,0) ��ü���� from employee
--�ǽ� 4 : commission�� null�� �ƴ� ����� �̸� ���
select ename ����̸� from employee
where commission is not null;
--�ǽ� 5 : �����ȣ�� 7698�� ����� �̸��� ��å ���
select ename ����̸�, job ��å from employee
where manager = 7698;
--�ǽ� 6 : ������ 1500�̻��̰� �μ��� 20�� ����� �̸��� �Ի糯¥, �μ���ȣ, ���� ���
select ename ����̸�, hiredate �Ի糯¥, dno �μ���ȣ, salary ���� from employee
where salary>=1500 and dno=20;
--�ǽ� 7 : �Ի糯¥�� 81�� 4�� �̻�, 81�� 12�� ���� ����� �̸��� �Ի� ��¥ ���
select ename ����̸�, hiredate �Ի糯¥ from employee
where hiredate>='81/04/01' and hiredate<='81/12/31';
--�ǽ� 8 : ��å�� SALESMAN�̸鼭 ������ 2000�̻��̰�, �μ���ȣ�� 30�� ��� �̸� ���
select ename ����̸� from employee
where job='SALESMAN' and salary>=1500 and dno = 30;
--�ǽ� 9 : ������ 1500�����̸鼭 �μ���ȣ�� 20���� �ƴ� ����� �̸��� ����, �μ���ȣ ���
select ename ����̸�, salary ����, dno �μ���ȣ from employee
where salary<=1500 and dno !=20;
--�ǽ� 10 : �����ȣ 7788, 7782�� ����� �μ���ȣ�� �̸�, ��å�� ���
select dno �μ���ȣ, ename �̸�, job ��å from employee
where eno =7788 or eno=7782;