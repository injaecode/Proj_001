/* 
SQL (Structured Query Language): 구조화된 질의 언어
        select 컬럼
        from 테이블명, 뷰명
        where 조건
        group by 그룹핑할 컬럼명
        having 나온 결과에 대한 조건
        order by 정렬할 컬럼
    
    DDL(Data Definition Language) : 데이터 정의 언어 / 객체를 생성, 수정 삭제
            객체(Object) - Table, View Function, Index, Store Procedure, Triger, USER...
        create(생성), alter(수정), drop(삭제)
        rename(객체이름변경), truncate(레코드 삭제)
    DML(Data Manipulation Language) : 데이터 조작 언어 / 레코드를 생성, 수정, 삭제
        insert(생성), update(수정), delete(삭제)
        - 트랜잭션을 발생시킴. commit(DB에 영구저장), rollback(원래 상태로 되돌림)
    DCL(Data Control Language) : 데이터 제어 언어 / 계정 생성, 권한을 부여, 삭제시 사용
        grant(권한 부여), revoke(권한 취소)
        
    DQL(Data Query Language) : 데이터 질의 언어 : select 
    DTL(Transaction Control Language): 트랜잭션 제어 언어
        begin transaction -> 트랜잭션 시작
        
        commit : 트랜잭션 종료(Database에 영구 저장)
        rollback : 트랜잭션 종료(원래상태로 되돌림, 트랜잭션 전 상태로 회귀)
        savepoint (트랜잭션 내의 임시 저장시점 설정)

*/

--테이블 생성(Create Table)

create table dept (             --생성할 테이블명
    dno number(2) not null,     -- 컬럼명 자료형 null허용 여부
    dname varchar2(4) not null, 
    loc varchar2(13) null
    );
    
--테이블 구조 확인
desc dept;

--테이블에 값 넣기 (insert into 테이블명 (명시할 컬럼명) values (넣을 값)
    --begin transaction 트랜잭션 작동
begin transaction;
insert into dept (dno, dname, loc) values ( 10, 'ACCO', 'SEOUL');

commit;         --database에 영구 저장
rollback;       --트랜잭션 시작 시점으로 되돌림

--데이터 검색하기
select * from dept;

    --트랜잭션(Transaction) : 작업(일)을 처리하는 최소단위
        --DML(insert, update, delete문을 사용하면 자동으로 트랜잭션이 시작됨
        --트랜잭션을 종료하지 않으면 외부에서 다른 사용자 접근 불가(Lock)
        --트랜잭션 종료
            --commit : DB에 영구 저장
            --rollback 원래 상태로 되돌림
        --트랜잭션의 4가지 특징
            --원자성(Atomicity) : 여러 구문을 하나의 작업단위로 처리
            --일관성(Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가져야 한다.
            --독립성(Isolation): 하나의 트랜잭션이 처리되기 전까지는 다른 트랜잭션과 격리
            --지속성(Durability) : commit된 트랜잭션은 DB에 영구적으로 저장

select * from dept;
    --컬럼과 값의 순서가 맞아야 함
insert into dept(dno, loc, dname)
values(20, 'Pusan', 'Sale');

insert into dept
values (30, 'abc', 'Daegu');

select * from dept;
desc dept;

insert into dept(dno, dname)
values( 30, 'abc');

commit;

--회원 정보를 저장하는 테이블 생성
create table member01 (
id varchar2(50) not null primary key, 
pass varchar2(50) not null,
addr varchar(100) null,
phone varchar(30) null,
age number (3) not null,
weight number (5, 2) not null
);

/* 제약 조건
    - Primary key : 테이블에서 하나만 존재할 수 있음 
        ㄴ 데이터 수정 및 삭제 시 조건을 사용하는 컬럼
        ㄴ primary key가 적용된 컬럼은 중복된 데이터 삽입 불가
        ㄴ 인덱스가 자동으로 생성됨 (검색 시 유용)
        ㄴ null 적용 불가
    
    - Unique : 중복된 값을 넣을 수 없다. 테이블에서 여러번 사용 가능
        ㄴ 1회에 한해 null 적용 가능
        ㄴ 인덱스가 자동으로 생성됨
    
    - check : 값을 넣을 때 체크해서 삽입
    - not null : 컬럼에 null 삽입 불가
*/

desc member;

insert into member01(id, pass, addr, phone, age, weight)
values ('aaaa','1234','서울 종로구','010-1111-1111', 20, 65.33);

insert into member01(id, pass, addr, phone, age, weight)
values ('bbbb','1234','서울 종로구','010-1111-1111', 20, 65.33);

insert into member01(id, pass, addr, phone, age, weight)
values ('cccc','1234','서울 종로구','010-1111-1111', 20, 65.33);

select * from member01;

--null 허용 컬럼에 null 삽입하기
desc member01;
insert into member01
values ('dddd', '1234', null, null, 30, 70.557);

commit;

insert into member01 (pass, age, weight, id)
values ('1234', 40, 88.888, 'eee');

-- 수정 (Update) < 반드시 where 절을 사용해서 수정해야함
    -- where 절에 사용된느 컬럼은 중복되지 않는 컬럼을 사용해 수정 : Primary Key, Unique
    /* 
    update 테이블명
    set 컬럼명=바꿀값, 컬럼명=바꿀값
    where 조건
    */
    
    select * from member01;
    
    update member01
    set phone = '010-2222-2222', age = 55, weight = 90.55
    where id = 'bbbb'
    
    commit;
    
    rollback; 
    
-- update시 중복되지 않는 컬럼에 조건을 준 경우
update member01
set phone = '010-3333-3333', age=80
where id = 'eee'

commit;

--delete : 반드시 where 조건 사용, 조건 없이 삭제하면 모든 데이터가 삭제됨
    -- 중복되지 않는 칼럼을 조건에 적용 : primary key, unique
    
select * from member01;

delete member01;
where id = 'ccc'

rollback;

--테이블 복사 (EMP)
create table emp 
as select * from employee;
    --복사된 테이블
    select * from emp;

/* 
  1.  레코드 3개 추가 입력, 모든 값 입력, null이 허용된 컬럼에 null 넣기
  2.  update를 사용해 데이터 수정, SCOTT의 보너스를 500으로 수정
    영업사원들의 보너스 300만원으로 수정
    ward의 부서번호 10으로 수정
    allen의 상관번호를 7839, 1800, 입사일을 22/01/01로 수정
  3. delete eno 7782, 6798의 레코드 삭제  
  
*/

desc emp;

/* 
    Unique 제약조건 : 중복된 데이터를 넣을 수 없다.
        -1회에 한해 null 삽입 가능
        -특정 컬럼에 여러번  삽입 가능
        -인덱스를 자동으로 생성 (검색 용이)
        -join시 on절, where조건
*/

create table customer1 (
    id varchar(20) null primary key, -- 오류 발생, primary key : not null
    pass varchar(20) not null unique,-- 중복되지 않는 컬럼
    name varchar(20) null unique,    -- null 허용, 테이블에 여러번 삽입 가능
    phone varchar(20) null unique,
    addr varchar(20) null 
    );
 desc customer1;   
insert into customer1 (id, pass, name, phone, addr)
values ('bbb','1234','홍길동2','010-1111-1111','서울 종로');

select *from customer1
--제약 조건 확인하기
select * from user_constraints
where table_name = 'CUSTOMER1';

/* check 제약조건 : 값을 컬럼에 넣을 때 체크해서 값을 넣는다
*/

--테이블 생성 시 제약조건에 이름을 부여하면서 테이블 생성
--제약조건 이름 생성 규칙 ; 테이블이름_컬럼명_제약조건유형
create table emp3 (
eno number(4) constraint emp3_eno_PK primary key,
ename varchar2(10),
salary number(7,2) constraint emp3_salary_CK check (salary>0)
);

--emp3 테이블에 할당된 제약조건 확인
select * from user_constraints
where table_name = 'EMP3'

insert into emp3 (eno, ename, salary)
values (1111, 'smith', 100);

select * from emp3;

create table emp4 (
eno number(4) constraint emp4_eno_PK primary key,
ename varchar2(10),
salary number(7,2) constraint emp4_salary_CK check (salary>0),
dno number(2) constraint emp4_dno_CK check(dno in (10, 20, 30, 40))
);

insert into emp4 
values (3333, 'scott', 300, 10);

select * from emp4;
commit;

select * from user_constraints --HR계정의 모든 제약 조건 확인
where table_name = 'EMP4'

/*
foreign key(참조키) : 다른 테이블(부모)의 primary key, unique 컬럼을 참조해서 값을 할당
*/

select * from employee; -- dno: FK(department 테이블의 dno 참조)
select * from department; -- 부모, dno

insert into employee
values (8888,'aaaa', 'aaaa', 7788, '22/12/08', 6000, null, 40);

rollback;

--부모테이블 생성 : Foreign key가 참조하는 컬럼은 primary key, unique 키 컬럼을 참조함
create table ParentTbl (
    name varchar2(20),
    age number(3) constraint ParentTble_age_CK check (age>0 and age<200),
    gender varchar2(3) constraint ParentTbl_gender_CK check (gender in ('M', 'W')),
    infono number constraint ParentTbl_infono_PK primary key
    );
    
insert into ParentTbl values ('홍길동', 30, 'M', 1);
insert into ParentTbl values ('김똘똘', 20, 'M', 2);
insert into ParentTbl values ('원빈', 25, 'M', 3);
insert into ParentTbl values ('손흥민', 31, 'M', 4);

select * from ParentTbl;

create table ChildTbl (
id varchar2(40) constraint ChildTbl_id_PK Primary key,
pw varchar2(40),
infono number, 
constraint ChildTbl_infono_FK Foreign key (infono) references ParentTbl (infono)
);

--부모 테이블에 값 넣기
insert into ParentTbl values ('홍길동', 30, 'M', 1);
insert into ParentTbl values ('김똘똘', 20, 'M', 2);
insert into ParentTbl values ('원빈', 25, 'M', 3);
insert into ParentTbl values ('손흥민', 31, 'M', 4);

--자식 테이블에 값 넣기
insert into ChildTbl values ('aaa', '1234', 1);
insert into ChildTbl values ('bbb', '1234', 2);
insert into ChildTbl values ('ccc', '1234', 2);
insert into ChildTbl values ('ddd', '1234', 2);
select * from childtbl;

commit;

/* 
    default : 컬럼의 값을 넣지 않을 때 default로 설정된 값이 기본적으로 들어간다
        -- 제약조건은 아니라 제약 조건 이름을 할당할 수 없다.
*/

create table emp5(
     eno number (4) constraint emp5_eno_PK primary key,
     ename varchar2(10),
     salary number(7, 2) default 1000 --값을 기입하지 않으면 default 값으로 적용됨
     );
     
     insert into emp5 (eno, ename)
     values (1111, 'aaaa');
     
    insert into emp5 (eno, ename)
     values (4444, 'aaaa');
commit;

--테이블 삭제
drop table member01;
rollback;