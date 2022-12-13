/*
    조인, 뷰, 인덱스
  
    조인 (Join) 두개 이상 테이블의 컬럼 출력 시 Join을 사용해 컬럼의 정보를 가져옴
        --employee, department 테이블은 원래 하나의 테이블이었다
        --모델링(중복제거, 성능 향상)을 사용해서 두 테이블로 분리되었습니다.
        --두 개 이상의 테이블에 컬럼을 가져오기 위해서는 Join문을 사용해 출력
        --두 테이블을 Join하기 위해서는 두 테이블에서 공통의 키 컬럼이 존재해야 함.
        --ANSI 호환 JOIN : 모든 SQL에서 공통으로 사용하는 JOIN구문
            Oracle, MY_SQL(Maria DB), MS-SQL, IBM DB2, ... <=DBMS
        
*/



select * from employee;
select * from department;

--EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN구문 ( 다른 SQL에서 호환 불가) 
        -- ANSI 호환의 SQL구문에서 INNER JOIN과 같은 구문
            --두 테이블의 교집합 출력
        -- from절에 join할 테이블 명시, comma(,)를 사용해 나열
        -- where절에 두 테이블의 공통 key컬럼을 찾아서 '='
        -- and절에서 조건을 처리
        -- 두 테이블의 공통 키컬럼을 select문에서 출력할 때 반드시 테이블명을 명시 (if not 오류 발생)
        

select eno 사원번호, ename 사원명, employee.dno 부서번호, dname 부서명, loc 부서위치
from employee, department               --조인할 테이블 나열
where employee.dno = department.dno     --두 테이블의 공통 키컬럼을 찾아서 '=' 처리
and employee.dno >=20;                  --조건 처리

-- 위 구문의 전체 구문 출력
select employee.eno, employee.ename, employee.dno, 
        department.dname, department.loc
from employee, department
where employee.dno=department.dno
and employee.dno>=20;

--주로 테이블 이름을 알리어스(별칭)해서 사용 

select eno, ename, salary, hiredate, e.dno, dname, loc
from employee e, department d -- 별칭 사용
where e.dno=d.dno;

--ANSI 호환의 INNER JOIN <- 모든 SQL에서 공통으로 사용되는 SQL구문
    -- 두 테이블의 공통인 값만 출력 (교집합)
    -- !주의! select절에 공통 키 컬럼 출력시 테이블 명시 필수
    -- from절에 INNER JOIN
    -- on절에 공통된 키컬럼을 '='로 처리
    -- where에서 조건을 처리함
    
    select ena 사원번호, ename 사원명, dno 부서번호, dname 부서명, loc 부서위치
    from employee e INNER JOIN department d -- inner join
    on e.dno = d.dno        --공통 키컬럼을 '=' 처리
    where e.dno >=20;       --where로 조건을 처리함
    
    --employee테이블의 사원명과 월급, 입사일, 부서명, 부서위치를 출력하되 월급이 2000 이상인 사원만 출력    
         --equi join(오라클에서만 사용)
            select ename 사원명, salary 월급, hiredate 입사일, dname 부서명, loc 부서위치
            from employee e, department d
            where e.dno=d.dno
            and e.salary>=2000;

        --ansi 호환 inner join문으로 출력 : 모든 SQL에서 공통으로 사용됨
            select ename 사원명, salary 월급, hiredate 입사일, dname 부서명, loc 부서위치
            from employee e inner join department d
            on e.dno=d.dno
            where salary >=2000;
    
    --두 테이블을 join해서 부서이름, 부서 번호, 부서별 월급 최대값을 출력
      --equi join(오라클에서만 사용)
         select d.dno 부서번호, dname 부서명, max(salary) 최대월급, count(*)
         from employee e, department d 
         where e.dno = d.dno
         group by dname, d.dno
        
    -- ansi호환으로 출력
        select d.dno 부서번호, dname 부서명, max(salary) 최대월급, count(*)
        from employee e inner join department d 
        on e.dno = d.dno
        group by dname, d.dno

--NATURAL JOIN : Oracle 9i지원
    -- 두 테이불을 join시 두 테이블에서 공통의 키컬럼을 찾아야 한다
    -- 두 테이블의 공통의 키 컬럼을 Oracle 내부에서 찾아서 처리함
    -- equi join에서 where 절의 두 테이블 공통 키 컬럼을 명시하지 않아도됨 (where절 없앰)
    -- where절 생략 시 오라클에서 두 테이블의 공통 키컬럼을 자동으로 찾아줌
    -- 두 테이블의 공통 키 컬럼은 동일한 타입이어야 함
    -- select 절에서 공통 키컬럼 출력시 테이블명을 명시하면 오류 발생
    -- from 절에서 natural join 사용
    
    --natural join을 사용해 출력하기
    select eno, ename, salary, e.dno, dname, loc
    from employee e natural join department d
    where dname = 'SALES';
    
    --where절이 생략될 경우 oracle 내부에서 key컬럼을 자동으로 탐색
    
    /*
    select 절에서 두 테이블의 공통 키 컬럼 출력시
        - equi join(inner join) - 반드시 키컬럼 앞에 테이블명을 명시해야함
        - natural join : 키 컬럼 앞 테이블 이름을 명시하면 오류 발생
    */
    
    --실습 문제) 사원이름, 월급, 부서이름, 부서번호를 출력하되 월급이 2000이상인 사용자만 출력
        --equi join (등가 조인) : oracle만 사용
         select ename 이름, salary 월급, e.dno 부서번호, dname 부서명
         from employee e, department d 
         where e.dno = d.dno
         and e.salary >=2000;
        --natural join : oracle만 사용
         select ename 이름, salary 월급, dno 부서번호, dname 부서명    --테이블 명을 명시하면 안됨
         from employee e natural join department d 
         where salary >=2000;
        --ansi 호환 : 모든 SQL에서 사용
         select ename 이름, salary 월급, e.dno 부서번호, dname 부서명
         from employee e join department d  --inner join 두테이블의 공통인 값만 출력
         on e.dno=d.dno
         where salary >= 2000;
         
    --non equi join : 오라클에서만 적용
        --where 절에 '='을 사용하지 않는 join 구문 <=공통 키 컬럼 없이 join
        --from절에 테이블을 ,로 나열

    
    --월급 등급을 출력하는 테이블    
    select * from salgrade;
    --사원 정보를 출력하는 테이블
    select * from employee;
--------------------
    
    -- employee, salgrade 테이블을 join해서 각 사원의 월급과 등급을 출력
    select ename, salary, grade
    from employee e, salgrade s             --from 절에서 테이블이 반점(,)으로 나열됨 (equi join)
    where salary between losal and hisal;
    
    --3개 테이블(employee, department, salgrade) join
        --사원 이름, 부서 이름, 월급, 월급 등급 출력
        select ename, dname, salary, grade
        from employee e, department d, salgrade s
        where e.dno=d.dno
        and salary between losal and hisal;
        
        --사원번호, 입사일, 부서번호, 월급, 월급등급, 부서명 출력
        select eno, hiredate, e.dno, salary, grade, dname
        from employee e, department d, salgrade s
        where e.dno=d.dno
        and salary between losal and hisal;
        
    /* self join : 자신의 테이블(원본)을 가상의 테이블(원본을 복사한 테이블)에 join함
        --자신의 테이블을 다시한번 조인
        --반드시 테이블을 별칭이름으로 만들고 별칭이름을 사용해 join
        --회사의 조직도를 SQL 구문으로 출력할 때 직급 상사가 누구인지 출력할 때 주로 사용
    */
    
    -- 관리자가 7788인 사원 eno, ename, manager 출력
    select eno 사원번호, ename 사원명, manager 직속상관
    from employee
    where manager = 7788
    order by ename asc
    
    --직속상관의 정보를 출력
    select eno 사원번호, ename 사원명, manager 직속상관
    from employee
    where eno = 7788;
    
 --self join을 사용해서 자신의 테이블을 join, 직속 상관 정보를 한번에 출력
    select e.ename 사원, e.manager 상관번호, m.eno 상관번호, m.ename 상관 
    from employee e, employee m  -- 같은 테이블 사용, 반드시 별칭 적용
    where e.manager = m.eno
    order by e.ename asc;
    
    select eno,ename, manager, eno, ename, manager
    from employee
    
    -- ANSI 호환 구문을 사용해 self join
    -- employee 테이블을 self join해서 사원에 대한 직속상관을 출력
    select e.ename || ' 의 직속상관은 ' || m.ename || ' 입니다.'
    from employee e inner join employee m
    on e.manager = m.eno
    order by e.ename asc;
    
    select eno, ename, manager, eno, ename, manager
    from employee;
    
/* outer join
    - 두 테이블에 공통적이지 않은 내용도 출력해야 할때
        - null 출력
        - oracle에서는 plus(+)를 사용해 outer join 
        - ANSI 호환 구문을 사용할때는 outer join 구문 사용함
            -- left outer join, left join
            -- right outer join, right join
            -- full outher join, full join
*/

--equi join을 사용해 outer join
select  e.ename || '의 직속 상관은 ' || m.ename || '입니다.'
from employee e, employee m
where e.manager = m.eno (+) --m.eno컬럼의 내용은 e.manager의 값이 없더라도 무조건 출력

-- ANSI 호환에서 outer join 
    -- left outer join (= left join)    : 왼쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- right outer join (= right join)  : 오른쪽 테이블의 내용은 매칭되지 않더라도 무조건 출력
    -- full outer join (= full join)    : 왼쪽, 오른쪽 모든 내용에 대해 매칭되지 않더라도 무조건 출력
    
 select  e.ename || '의 직속 상관은 ' || m.ename || '입니다.'
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename asc;


---------------------------------------------
select count (*) from employee; --14
select count (*) from department; --4

/* 카디시안 곱 : 왼쪽 테이블의 하나의 레코드에서 오른쪽 테이블의 모든 레코드 곱하기
    14*4 = 56개 레코드 출력
*/
    --inner join : e.dno = d.dno가 매칭되는 내용만 출력
    --equie join : oracle 구문으로 출력
select * 
from employee e, department d 
where e.dno = d.dno (+);