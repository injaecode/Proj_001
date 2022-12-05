--모든  테이블 출력하기
select * from tab;

--테이블의 구조 확인하기
    --select : 출력하기
    /*
    select 컬럼명 
    from 테이블 이름
    
    */
    
-- 1. employee 테이블의 모든 컬럼 출력
    --근로자(고용ㅇ자)에 대한 정보를 저장
select *
from employee;

--2. department 테이블의 모든 컬럼을 출력
select *
from department;

--3. salgrade 테이블의 모든 컬럼(필드, 엔티티) 출력
    --판매 순위를 저장하는 테이블
select *
from salgrade;

/*
====================================
각 테이블의 컬럼 정보
1. employee 테이블
*/
select * from employee;
/*
ENO : 사원번호
ENAME : 사원명
JOB : 직책
MANAGER : 상관의 사원번호
HIREDATE : 입사일
SALARY : 월급
COMMISSION : 보너스
DNO : 부서번호
*/

-- 2. 부서 정보를 저장하는 테이블
select * from department;

/*
DNO : 부서번호
DNAME : 부서명
LOC : 부서의 위치
*/

-- 3. 판매 순위를 저장하는 테이블
select * from salgrade ; 
/*
GRADE : 순위
LOSAL : 제일 낮은 월급
HISAL : 제일 높은 월급
*/

-- select * : 테이블 내 모든 값 출력 
-- 컬럼 = 필드 = 엔티티
-- 레코드 : 각 컬럼에 들어간 값, 1라인
-- 레코드 셋 : 레코드들의 집합
select *
from employee;

--특정 컬럼만 출력
select eno
from employee;

--특정 컬럼 여러개 출력 (, 사용해 구별
select eno, ename, salary
from employee;

-- 모든 컬럼 출력
select eno, ename, job, manager, hiredate, salary, commission,dno
from employee; 

--특정 컬럼만 출력 시 여러번 출력하기
select eno, ename, salary, ename, ename
from employee;

--테이블의 구조 확인하기
DESCRIBE employee;
DESC employee;

--컬럼을 별칭으로 출력
select eno as 사원번호, ename as 사원명, job as 직책
from employee;

--employee 테이블의 모든 컬럼을 별칭으로 출력하기
select eno 사원번호, ename 사원명, job 직책, manager 상관번호, 
hiredate 입사일, salary "월급*", commission 보너스, dno "부서 번호"
from employee;

--조건을 사용하여 출력 : where
select *
from employee
where eno = 7499;   --조건 적용: eno 컬럼의 값이 7499인 것만 출력

desc employee; -- employee 테이블의 구조 확인

-- 값 출력시 : number 데이터 타입 값은 ''없이 출력
--           number이외의 데이터 타입은 '' :char, varchar, date..

select * from employee
where job = 'MANAGER' ; --job (varchar2), 값을 가져올때는 대소문자를 구별


select * from employee
where dno = 20;

--#실습#
-- 월급 2000만원 이상 사용자만 출력
select * from employee
where salary >=2000;

--이름이 CLARK인 사용자의 월급만 출력
select salary 월급 from employee
where ename = 'CLARK';

-- 사원번호 7788인 이름과 입사날짜 출력
select ename 이름, hiredate 입사날짜 from employee
where eno = 7788;


/*
<select문의 전체 구조>
select --컬럼명 : * (모든 컬럼),
form -- 테이블명, 뷰 이름
where -- 조건
group by -- 특정 컬럼의 동일한 값을 그룹화
Having -- group by에서 나온 결과의 조건 처리
Order by -- 정렬해서 출력할 칼럼 asc: 내림차순 정렬 - desc: 오름차순 정렬
*/


select distinct dno 부서번호 from employee;     --distinct : 중복 값 제거하여 출력

-- 컬럼에 연산을 적용 : 컬럼명이 없어짐. alias(별칭)하여 출력
select eno, ename, salary 월급, salary*12 연봉, commission 보너스
from employee;

--전체 연봉 구하기 : 월급*12+보너스 =전체 연봉

select eno, ename, salary, commission,salary*12 연봉, (salary*12)+commission as 전체연봉
from employee;

--null 컬럼과 사칙연산 시 값은 null로 출력
    -->전체 연봉을 계산할 때 null 값을 가진 컬럼을 0으로 변경한 후 연산을 적용해야 함
        -- nvl 함수 : 컬럼의 null 값을 다른 값으로 변환해 처리해주는 함수
        -- nvl (commission,0) : commission 컬럼에 null을 0으로 수정해 처리
        
select eno, ename, salary, commission,salary*12 연봉, (salary*12)+nvl(commission,0) as 전체연봉
from employee;

--null값을 가진 컬럼 출력 시 주의사항
--where commission = null 시 오류, null 검색시에는 is 사용
select * from employee
where commission is null;

select * from employee
where commission is not null;

--where 조건에서 and, or 사용하기
    --예시) 부서번호가 20번이거나 30번인 모든 컬럼 출력
select * from employee
where dno = 20 or dno = 30;
    --예시) 부서번호가 20번이고 월급이 1500이하인 모든 컬럼 출력
select * from employee
where dno = 20 and salary <=1500;
    --예시) 직책이 MANAGER이면서, 월급이 2000이상인 사용자만 출력
select * from employee
where job = 'MANAGER' and salary>=2000;

--실습 1 : 보너스 컬럼이 null인 행의 사원번호, 사원 이름, 입사 날짜 출력
select eno 사원번호, ename 사원이름, hiredate 입사날짜 from employee
where commission is null;
--실습 2 : 부서번호가 20이고 입사날짜가 81년 4월 이후인 사원의 이름과 직책, 입사 날짜 출력
select ename 사원이름, job 직책, hiredate 입사날짜 from employee
where dno = 20 and hiredate>='81/04/01';
--실습 3 : 모든 사원의 연봉을 계산해 사원번호, 사원이름, 월급, 보너스, 전체 연봉 출력
select eno 사원번호, salary 월급, commission 보너스, (salary*12)+nvl(commission,0) 전체연봉 from employee
--실습 4 : commission이 null이 아닌 사원의 이름 출력
select ename 사원이름 from employee
where commission is not null;
--실습 5 : 상관번호가 7698인 사원의 이름과 직책 출력
select ename 사원이름, job 직책 from employee
where manager = 7698;
--실습 6 : 월급이 1500이상이고 부서가 20인 사원의 이름과 입사날짜, 부서번호, 월급 출력
select ename 사원이름, hiredate 입사날짜, dno 부서번호, salary 월급 from employee
where salary>=1500 and dno=20;
--실습 7 : 입사날짜가 81년 4월 이상, 81년 12월 이하 사원의 이름과 입사 날짜 출력
select ename 사원이름, hiredate 입사날짜 from employee
where hiredate>='81/04/01' and hiredate<='81/12/31';
--실습 8 : 직책이 SALESMAN이면서 월급이 2000이상이고, 부서번호가 30인 사원 이름 출력
select ename 사원이름 from employee
where job='SALESMAN' and salary>=1500 and dno = 30;
--실습 9 : 월급이 1500이하이면서 부서번호가 20번이 아닌 사원의 이름과 월급, 부서번호 출력
select ename 사원이름, salary 월급, dno 부서번호 from employee
where salary<=1500 and dno !=20;
--실습 10 : 사원번호 7788, 7782인 사원의 부서번호와 이름, 직책을 출력
select dno 부서번호, ename 이름, job 직책 from employee
where eno =7788 or eno=7782;