select * from myTbl;

insert into myTbl value('1','1234');
commit

select *from myTbl;

-- 한줄 주석: 프로그램에서 해석되지 않는 영역
/*
여러줄 주석
*/
--1. HR계정 생성 : 12버전부터 계정 생성 시 계정명 앞에 C## 적용 필수
--  system 계정으로 접속한 쿼리창에서 명령 필요
-- HR: 계정명 / 암호 : 1234
create user C##HR2 identified by 1234;

--2. HR 계정의 권한 부여 : 
/* connect : 원격에서 DB에 접속할 수 있는 권한 부여
   resource : 객체(resource-table, index, view, store procedure, triger, function)를 생성, 수정, 삭제할 수 있는 권한을 부여
*/

grant connect, resource to C##HR2;
--3. 테이블 스페이스를 사용할 권한 부여
    -- USERS 테이블 스페이스의 사용량을 무제한 사용할 수 있도록 권한 설정
alter user C##HR2 quota unlimited on USERS;

--4. HR 계정 삭제 - 연결 설정이 되어있는 경우 삭제 불가. 연결을 먼저 삭제 후 계정 삭제
drop user C##HR;

show user;
