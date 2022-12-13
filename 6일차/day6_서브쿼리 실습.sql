-- 1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.  
select ename 이름, job 담당업무
from employee
where job = (select job from employee where eno=7788);

--2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename 이름, job 담당업무
from employee
where salary > all(select salary from employee where eno=7499);

--3. 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select ename 이름, job 담당업무, salary 급여
from employee
where salary = (select min(salary) from employee);

--4. 평균 급여보다 적은 사원의 담당 업무를 찾아 직급과 평균 급여를 표시하시오.
select job 직무, avg(salary) 급여
from employee
where salary <all(select avg(salary) from employee)
group by job;

--5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
select ename 이름, salary 급여, dno 부서번호
from employee
where salary = any(select min(salary) from employee group by dno)

--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 
--표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select eno 사원번호, ename 이름, job 담당업무, salary
from employee
where salary <all(select salary from employee where job = 'ANALYST') and job <> 'ANALYST'

--7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select  ename 이름
from employee 
where eno not in (select distinct manager from employee where manager is not null)

--8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select ename 이름
from employee 
where eno = any(select distinct manager from employee where manager is not null)

--9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select ename 이름, hiredate 입사일
from employee 
where dno = (select dno from employee where ename = 'BLAKE') and ename <> 'BLAKE' 

--10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno 사원번호, ename 이름
from employee 
where salary >any(select avg(salary) from employee)
order by salary;

--11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select eno 사원번호, ename 이름
from employee
where dno =any(select dno from employee where ename like '%K%')

-- 12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select ename 사원이름, dno 부서번호, job 담당업무
from employee
where dno in (select dno
              from department
              where loc = 'DALLAS');

--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 
select ename 이름, salary 급여
from employee 
where manager = any(select eno from employee where ename = 'KING')

--14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
select e.dno 부서번호, ename 이름, job 담당업무
from employee e, department d
where e.dno = d.dno
and dname = 'RESEARCH'; 

--15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select eno 사원번호, ename 이름, salary 급여
from employee
where salary>(select avg(salary) from employee)
and dno in (select dno from employee where ename like '%M%')  

--16. 평균 급여가 가장 적은 업무를 찾으시오. 
select job 
from employee
where salary < all(select avg(salary) from employee group by job)

--17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select ename 이름
from employee
where dno = any(select dno from employee where job = 'MANAGER');