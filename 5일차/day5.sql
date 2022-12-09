--테이블 수정(alter table)

--실습 테이블 복사 
    -- 컬럼명, 자료형, 데이터(레코드):원본 테이블에 할당된 제약 조건은 복사되지 않음
create table dept20
as
select * from department;

desc department;    --원본
desc dept20;        --복사본

--제약 조건 확인
select * from user_constraints
where table_name = 'DEPARTMENT';
select * from user_constraints
where table_name = 'DEPT20';

-- 1. 기존 테이블에 컬럼 추가 : null을 허용하고 컬럼을 추가해야함
select * from dept20;

-- 기존 테이블에 birth 컬럼을 추가
Alter table dept20
add (birth date);

Alter table dept20
add (email varchar2(100),address varchar2(200), jumin char(13))

/* 
    char : 자리수가 지정된 컬럼에 사용 (주민번호, 은행 비밀번호)
         - 성능 빠름, 하드 공간을 낭비할 수 있음
    varchar2 : 자리수를 알 수 없는 경우, (주소, email)
        - varchar의 성능을 개선해 만듦 (오라클에서 사용됨)
        - char보다 성능이 떨어짐, 하드 공간 낭비를 줄임
        

*/

--칼럼에 지정된 자료형 수정
alter table dept20
modify email varchar2(200);

alter table dept20
modify loc varchar2(50);

--특정 컬럼 삭제
alter table dept20 
drop column JUMIN;

alter table dept20
drop column ADDRESS;

--컬럼 삭제 시 레코드가 많은 경우 시스템에 많은 부하가 발생됨
        -- 임시적으로 특정 컬럼의 사용을 중지한 후 야간에 작업할 것 권장
        --  ㄴ SET UNUSED : CPU 부하없이 특정 컬럼 사용 중지
        alter table dept20      --email 컬럼 임시 중지
        set unused (email);

        alter table dept20      --unused 컬럼 삭제
        drop unused column;
        
--테이블의 컬럼명 변경
alter table dept20
rename column DNO to D_NO;

alter table dept20
rename column DNAME to D_NAME;

desc dept20 ;
select * from dept20;

--테이블 이름 변경
rename dept20 to dept22;

--현재 로그온한 사용자의 모든 테이블 출력 
select * from tab;

--현재 로그온한 사용자의 모든 테이블 출력 : 데이터 사전을 통해 출력
    -- 매우 자세히 출력
select * from user_tables; 

/* 데이터 사전 :관리를 목적으로 객체의 정보를 저장하는 테이블
    객체(Objejct) : Table, View, Index, Function, Stored Procedure, User, Sequence ...
    USER_ : 자신이 속한 계정에서 생성한 객체만 출력
    ALL_ : 자신이 속한 계정에서 생성한 객체와 권한을 부여받은 객체 정보를 출력
    DAB_ : 데이터베이스 관리자만 접근 가능한 객체 정보, sys, system
    
    select * from user_tables; 테이블 정보
    select * from user_constraints; 제약 조건 정보 출력 <- 컬럼, 
        //not null, primary key, unique, foreign key, check
        //default : 제약조건이 아님
    select * from user_indexes; 인덱스 정보를 출력 : 테이블 컬럼에 부여됨
        //인덱스(색인, 목차)
    select * from user_sequences; 시퀀스 정보 확인
        //sequence : 컬럼에 값이 자동으로 증가되는 컬럼에 적용되는 객체
*/

select * from user_tables
where table_name = 'DEPARTMENT'

select * from dba_tables;

--테이블 컬럼에 할당된 제약조건 수정 : Alter Table
select * from user_constraint;

-- 실습할 테이블 복사 : 제약 조건은 복사되지 않음
create table emp_copy01
as
select * from employee;

create table dept_copy01
as
select * from department;

--employee 테이블의 제약조건 확인
select * from user_constraints
where table_name = 'EMPLOYEE';

--emp_copy1 테이블의 제약 조건 확인
select * from user_constraints
where table_name = 'EMP_COPY01';   --불러오기 위해선 대문자 사용 

-- 두 테이블의 제약조건 확인
select * from user_constraints
where table_name in('EMPLOYEE', 'EMP_COPY01', 'DEPARTMENT','DEPT_COPY01'); 

--primary key 할당 (복사한 테이블), eno컬럼에 PK
    -- 해당 컬럼에는 null 불가
    -- 중복된 값 불가
select * from emp_copy01;

alter table emp_copy01
add constraint EMP_COPY01_ENO_PK primary key (eno)

--foreign key : 부모 테이블의 primary key, unique를 참조함
    --dept_copy01테이블의 dno컬럼에 primary key 적용
alter table dept_copy01
add constraint DEPT_COPY_DNO_PK primary key (dno);

    --emp_copy01테이블의 don컬럼에 FK할당 -> dept_copy01 (dno)
select * from emp_copy01;
select * from dept_copy01;

--FK 제약 조건 추가
alter table emp_copy01
add constraint EMP_COPY01_DNO_FK foreign key (dno) references dept_copy01(dno);


desc emp_copy01;
desc dept_copy01;

select * from emp_copy01;

-- ename 컬럼에 unique 제약 조건 추가하기
    --unique : 중복 값 불가하며, 1회 한정 null 삽입 가능
    alter table emp_copy01
    add constraint EMP_COPY01_ENAME_UK unique (ename);
    
--salary 컬럼에 check 제약 조건 추가하기 (salary>0)
alter table emp_copy01
add constraint EMP_COPY_01_SALARY_CK check (salary>0);

--특정 컬럼에 not null 제약 조건 추가하기 : modify 사용
    -- 기존의 컬럼에 null이 존재하지 않아야 함
desc emp_copy01;
select job from emp_copy01
where job is null;

--NOT NULL을 추가할 때 modify를 사용
alter table emp_copy01
modify job constraint EMP_COPY_JOB_NN not null;

/*  제약조건 제거
        alter table 테이블명
        drop <제약조건이름>
        
        --FK가 참조하는 테이블의 제약 조건 제거 시 FK를 일차로 제거 후 해당 테이블의 제약 조건을 제거해야 함
*/ 

-- 기존 테이블의 제약조건 확인
select * from user_constraints
where table_name in ('EMP_COPY01', 'DEPT_COPY01');

--eno컬럼의 Primary Key 제약조건 제거하기, 
    --eno 컬럼에 할당된 primary key 이름으로 제거 (제약조건 이름, primary key  테이블에 1번만 적용되므로)   
    alter table emp_copy01
    drop primary key;
    --dno 컬럼에 할당된 primary key 제거 << FK가 참조 중, FK 먼저 제거 후 삭제 해야함 !!중요!!
    alter table dept_copy01
    drop constraints DEPT_COPY_DNO_PK;
    --FK 먼저 제거
    alter table emp_copy01
    drop constraints EMP_COPY01_DNO_FK;
    
    --제약 조건을 제거하면서 참조하는 FK까지 강제로 함께 제거하는 방법 : cascade 옵션 사용
    alter table dept_copy01
    drop constraint DEPT_COPY_DNO_PK cascade;
    
    --Unique 제약조건 제거하기
    alter table emp_copy01
    drop constraint EMP_COPY01_ENAME_UK;
    
    --check 제약조건 제거하기
    alter table emp_copy01
    drop constraint EMP_COPY_01_SALARY_CK;
    
    --not null 제약조건 제거
    alter table emp_copy01
    drop constraint EMP_COPY_JOB_NN;
    
create table emp_copy02
as
select * from employee
where dno=20;

create table dept_copy02
as 
select * from department;

--기존의 복사한 테이블에서 제약 조건 추가
--eno 컬럼에 primary key 추가, dno 컬럼dp FK : dept_copy02 (dno)
alter table emp_copy02
add constraint EMP_COPY02_ENO_PK primary key (eno);

select * from emp_copy02
select * from dept_copy02;

--Foreign key : DNO - dept_copy02(dno)
--FK가 참조할 테이블에 primary key 할당
alter table dept_copy02
add constraint DEPT_COPY02_DNO_PK primary key (dno);

--Foreign key 할당
alter table emp_copy02
add constraint EMP_COPY02_DNO_FK foreign key (dno) references dept_copy02 (dno);

--두 테이블 (emp_copy02, dept_copy02) 제약조건 확인
select * from user_constraints
where table_name in ('EMP_COPY02', 'DEPT_COPY02');

--Foreign key가 참조하는 테이블은 삭제 불가능
    --자식 테이블(참조:FK) 테이블을 먼저 제거 후 부모 테이블을 삭제해야 삭제 가능
drop table emp_copy02;
drop table dept_copy02;   

--FK가 참조하는 테이블을 강제로 제거
drop table dept_copy02 cascade constraint purge;

drop table emp_copy02;

--제약 조건 disable / enable : 
    -- bulk insert(대량의 데이터 삽입)할 때 테이블에 제약조건이 있으면 값 저장 시간 과다 소요
    
--실습 테이블 복사 후
create table emp_copy03
as
select eno, ename, job, salary, dno
from employee
where dno = 30;

create table dept_copy03
as
select * from department;

select * from emp_copy03;
select * from dept_copy03;

---------------------------
--eno : primary key : emp_copy03
--dno : primary key : dept_copy03
--dno : foreign key : emp_copy03
---------------------------
alter table emp_copy03
add constraints EMP_COPY03_ENO_PK primary key (ENO);
alter table dept_copy03
add constraint DEPT_COPY03_DNO_PK primary key (DNO); -- FK가 참조할 컬럼

alter table emp_copy03
add constraint EMP_COPY03_DNO_FK foreign key (DNO) references dept_copy03(DNO);

--제약조건 일시 중지하기 : 제약조건 이름을 사용해 중지시킴  (status : enabled -> disabled)
select * from user_constraints
where table_name in ('EMP_COPY03', 'DEPT_COPY03')

alter table dept_copy03
disable constraint DEPT_COPY03_DNO_PK;  

alter table emp_copy03
disable constraint EMP_COPY03_ENO_PK;

alter table emp_copy03
disable constraint EMP_COPY03_DNO_FK;   -- 중지 시에는 FK 먼저 -> PK

--제약조건 활성화 (enable)
alter table emp_copy03 
enable constraint EMP_COPY03_ENO_PK; -- 활성화 시에는 PK ->FK 순으로

alter table dept_copy03
enable constraint DEPT_COPY03_DNO_PK;  

alter table emp_copy03 
enable constraint EMP_COPY03_DNO_FK;

-----------------------------------------

/*
    Alter table : 생성된 테이블을 수정
        --컬럼을 추가, 제거, 컬럼의 자료형 수정
        --제약 조건 추가, 제거, 수정
*/

--시퀀스 (sequence) : 자동 번호 발생기 (컬럼의 값을 자동으로 증가시킴)
    --고유한 번호가 할당됨
    --시퀀스를 생성, 테이블의 특정 컬럼에 적용
    --출력된 시퀀스는 되돌릴 수 없음
    
create sequence sample_seq
    increment by 10     -- 증가값 : 10
    start with 10;      -- 초기값 : 10
    
create sequence sample_seq1
    increment by 1      -- 증가값 : 1
    start with 1        -- 초기값 : 1
    
--시퀀스 정보 확인
select * from user_sequences;

--시퀀스의 다음값 확인
select sample_seq.nextval from dual;
--현재 시퀀스가 가지고 있는 값
select sample_seq.currval from dual;    --첫 시퀀스에서 진행하면 오류 발생

--생성한 시퀀스를 테이블의 특정 컬럼에 적용
create table dept30
as 
select * from department
where 0 = 1;    --where 절이 false이면서 테이블의 레코드를 복사하지 않음

select * from dept30;

insert into dept30
values (sample_seq.nextval, 'ACC1', 'SEOUL');

select * from dept30;

create table dept40
as 
select * from department
where 0 = 1; 

insert into dept40
values (sample_seq1.nextval, 'MANAGER1', 'BUSAN')

select * from dept40

--현재 시퀀스에 할당된 값 확인
select sample_seq1.currval from dual;


--------3부터 시작해서 3씩 증가하는 시퀀스를 생성해 dept50 테이블의 dno컬럼에 할당후 출력
create sequence plus3
    increment by 3
    start with 3
    
create table dept50
as
select * from department
where 0 = 1;

insert into dept50
values(plus3.nextval,'MARKETING','LONDON')

select * from dept50