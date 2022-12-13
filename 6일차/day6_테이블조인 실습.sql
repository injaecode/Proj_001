--1. EQUI 조인을 사용하여 SCOTT 사원의 부서 번호와 부서 이름을 출력 하시오.
select ename 이름, e.dno 부서번호, dname 부서이름
from employee e, department d
where e.dno = d.dno
and e.ename = 'SCOTT';

--2. INNER JOIN과 ON 연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
select ename 이름, dname 부서, loc 지역
from employee e inner join department d
on e.dno=d.dno;

--3. INNER JOIN을 사용하여 10번 부서에 속하는 
--모든 담당 업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력 하시오. 
    select distinct e.job 업무, d.loc 지역
    from employee e inner join department d
    on e.dno = d.dno 
    where e.dno =10;

    -------
    select dno, job, loc
    from employee e inner join department d
    using (dno)
    where dno=10;

--4. NATURAL JOIN을 사용하여 커밋션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력 하시오. 
    select ename 이름, dname 부서이름, loc 지역 
    from employee e natural join department d
    where commission is not null and commission !=0;
    
--5. EQUI 조인과 WildCard ( _ , %)를 사용하여 이름에 A 가 포함된 모든 사원의 이름과 부서명을 출력 하시오. 
select distinct ename 이름, dname 부서
from employee e, department d
where e.dno=d.dno
and ename like '%A%';

--6. NATURAL JOIN을 사용하여 NEW YORK에 근무하는 모든 사원의 이름, 업무, 부서번호 및 부서명을 출력하시오. 
select ename 이름, job 업무, dno 부서번호, dname 부서명
from employee e natural join department d
where loc = 'NEW YORK';

--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
-- 	각 열(컬럼)에 별칭값을 한글로 넣으시오. 
select e.ename 이름, e.eno 사원번호, e.manager 관리자번호, m.eno 관리자번호, m.ename 관리자
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select e.ename || '('||e.eno ||')의 직속상관은 ' || m.ename || '입니다.'
from employee e inner join employee m
on e.manager = m.eno
order by e.ename asc;

--8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
    --ANSI 호환
    select *
    from employee e left outer join employee m 
    on e.manager = m.eno
    order by e.eno desc;
    --EQUI JOIN
    select e.ename 사원이름, e.eno 사원번호, m.eno 관리자사번, m.ename 관리자이름
    from employee e, employee m
    where e.manager = m.eno (+)
    order by e.eno desc;
    
--9. SELF JOIN을 사용하여 지정한 사원(scott)의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하시오. 
--   단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
select e.ename 이름, e.dno 부서번호, m.ename 동료
from employee e inner join employee m
on e.dno=m.dno 
where e.ename = 'SCOTT' and m.ename <> 'SCOTT';

--10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select m.ename 이름, m.hiredate 입사일 
from employee e, employee m
where e.ename = 'WARD'
and m.hiredate > e.hiredate
order by e.ename;

-- 11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
--    단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
select e.ename 이름, e.hiredate 입사일, m.ename 관리자이름, m.hiredate 관리자입사일
from employee e join employee m
on e.manager = m.eno
where e.hiredate < m.hiredate
order by e.ename;


