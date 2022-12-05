--1. HR계정으로 접속 확인 : resource - 테이블 생성, 수정, 삭제 가능
show user;

--2. 테이블 생성
create table myTbl2 (
   id varchar2 (20),
   pass varchar2 (20)
   );

--3, 테이블에 값 넣기 : commit(저장)
insert into myTbl2 values ('1','1234');
commit; --DB에 영구 저장 (insert, update, delete구문에서 사용)
--4. 테이블의 값 출력
select * from myTbl2;
--5. 테이블 삭제
drop table myTbl2;