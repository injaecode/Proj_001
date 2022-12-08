/* 
  1.  레코드 3개 추가 입력, 모든 값 입력, null이 허용된 컬럼에 null 넣기
  2.  update를 사용해 데이터 수정, SCOTT의 보너스를 500으로 수정
    영업사원들의 보너스 300만원으로 수정
    ward의 부서번호 10으로 수정
    allen의 상관번호를 7839, 1800, 입사일을 22/01/01로 수정
  3. delete eno 7782, 6798의 레코드 삭제  
  
*/

desc emp;
select * from emp;
begin transaction;
insert into emp (eno , ename, job, manager, hiredate, salary, commission, dno)
values (7123, 'LYNSAY', 'PRESIDENT', null, '22/12/08', 9900, 4000, 10);

insert into emp (eno , ename, job, manager, hiredate, salary, commission, dno)
values (7773, 'MARRY', 'SALESMAN', 7566, '82/06/01', 2500, null, 20);

insert into emp (eno , ename, job, manager, hiredate, salary, commission, dno)
values (7773, 'SALLY', 'CLERK', 7788, '80/01/24', 1450, 500, 30);

commit;
select * from emp;
update emp
set commission=500
where ename = 'SCOTT'

update emp
set commission=300
where job = 'SALESMAN';

update emp
set dno = 10
where ename = 'WARD';

update emp
set manager = 7839, salary = 1800, hiredate = '22/01/01'
where ename = 'ALLEN'

commit;

delete emp
where eno = 7782

delete emp
where eno = 7698

commit;

rollback;
select * from emp;