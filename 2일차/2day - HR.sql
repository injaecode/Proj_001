
--HR 계정으로 접속한 쿼리
show user;

--현재 접속한 계정에서 모든 테이블 출력
select * from tab;

--각 테이블의 구조 확인
desc employee;
desc department;
desc salgrade;

--테이블의 각 컬럼에 저장된 값 출력
select *
from employee;

--컬럼을 여러번 출력, 연산, 별칭 : 컬럼을 종결
select ename as 사원명, salary 월급, salary*12 연봉 from employee;

--전체 연봉을 출력 null 값을 처리, nvl(commission,0)
select ename 사원명, salary*12 + nvl(commission,0) 전체연봉 from employee;

--IN 연산자 : where 조건에서 사용
    -- without IN : commission(보너스)가 300, 500, 1400인 사용자 
    select * from employee
    where commission = 300 or commission = 500 or commission = 1400;
    --with IN
    select * from employee
    where commission in (300, 500, 1400);

--Between A and B : A와 B사이의 값을 출력
--입사월이 81/01/01~81/12/31인 사원
select ename, hiredate from employee
where hiredate between '81/01/01' and '81/12/31';

--Like : 컬럼 값을 검색해 출력할 때 사용
    --? : 한글자 대체, 모든 값 수용 가능
    --% : 모든 글자 대체
--이름이 A로 시작되는 모든 사원 출력
select ename from employee where ename like 'A%';

--이름에 LL이 들어간 사원 찾기
select ename from employee where ename like '%LL%';

--이름 두번째 자리에 A문자가 포함된 사원 검색
select ename from employee where ename like '_A%';

--직책에 MAN이 포함된 사원 검색
select job from employee where job like '%MAN%';

--정렬해서 출력하기 : order by 정렬할 컬럼 정렬방식; 
    -- asc : 오름차순 <= 기본값, 생략가능
    -- desc : 내림차순

--사원 이름을 기준으로 ASC
select * from employee
order by ename ;

--입사일을 기준으로 DESC
select * from employee
order by hiredate desc ;

--사원 이름을 기준으로 DESC
select * from employee
order by eno desc;

--조건을 적용해서 나온 결과 정렬해서 출력하기
    --81년 입사한 사원을 월급이 많은 순으로 출력하기
    select eno, ename, hiredate, salary from employee
    where hiredate like '81%' order by salary desc;
    --보너스가 없는 사원 중 이름 내림차순으로 정렬
    select * from employee
    where commission is null order by ename;
    --부서번호가 20이고 월급이 1500이상인 사원을 월급이 많은 순으로 출력하기
    select * from employee
    where dno = 20 and salary>=1500 order by salary desc;
    
--여러 컬럼을 정렬할 경우 : 
    --처음의 컬럼을 모두 정렬 후 같은 값이 존재할 경우 그 컬럼을 뒤에서 정렬 (*!게시판 제작시 활용)
select dno, manager, ename from employee 
order by dno asc, manager asc, ename asc;

--manager desc정렬 후 ename컬럼을 asc정렬
select manager, ename from employee
order by manager desc, ename;

--부서별로 월급이 많은 사용자부터 출력
select ename, salary, dno from employee
order by dno,salary desc;

--보너스별로 월급이 많은 순으로 출력
select ename, commission, salary from employee
order by commission desc, salary desc;

--직책별로 입사일이 빠른 순 출력
select ename, job, hiredate from employee
order by job, hiredate;

--중복 제거 후 출력 : distinct를 중복을 제거할 컬럼(select) 앞에 입력

select distinct job from employee
order by job;

select distinct dno from employee
order by dno;

--중복 없이 상관 번호 출력
select distinct manager from employee
order by manager;

--오라클 기본 함수
    --1. 문자 처리 함수
    --2. 숫자 함수
    --3. 날짜 함수
    --4. 변환함수
    --5. 일반함수

/*1-1. 문자함수 - 대소문자 변환
LOWER: 소문자로 변환
UPPER: 대문자로 변환
INITCAP: 첫글자만 대문자, 이외 소문자로 변환
*/
select 'Oracle mania' as 원본,
upper ('Oracle mania') as 대문자,
lower ('Oracle mania') as 소문자,
initcap ('Oracle mania') as 첫자대문자
from dual;  --가상의 테이블

--값을 가져올때는 대소문자 구별 필요
select * from employee
where ename = upper('smith');

/*1-2.  문자함수 - 글자의 길이를 출력하는 함수
LENGTH: 글자 수를 반환 (한글을 1byte로 처리)
LENGTHB: 글자 수를 반환(한글을 3byte로 처리, UTF-8 기준)
*/
select length('Oracle mania'),  --12byte(공백포함)
length('오라클매니아')            --6byte
from dual;

select lengthb('Oracle mania'),  --12byte
lengthb('오라클매니아')            --18byte
from dual;

select ename, length(ename)글자수,job, length(job)글자수 from employee;

/*1-3.
CONCAT: 문자열 연결 함수
SUBSTR: 문자를 잘라주는 함수 (한글 1byte)
SUBSTRB: 문자를 잘라주는 함수 (한글 3byte)
INSTR: 특정 문자의 위치 값을 반환 (한글 1byte)
INSTRB: 특정 문자의 위치 값을 반환 (한글 3byte)
LPAD: 글자 자리수를 입력받고 나머지는 특정 기호로 채움 (왼쪽)
RPAD: 글자 자리수를 입력받고 나머지는 특정 기호로 채움 (오른쪽)
TRIM: 공백을 제거
*/
--concat
select 'Oracle', 'mania',concat('Oracle', 'mania') from dual;

--substr/substrb
select substr('Oracle mania', 4, 3),   -- 'cle' 4번째자리부터 3자리 출력
substrb('Oracle mania', 4, 3)         -- 'cle' 4번째자리부터 3자리 출력 
from dual;

select substr('오라클 매니아', 4, 3),   -- ' 매니' 4번째자리부터 3자리 출력
substrb('오라클 매니아', 5, 3)         -- '라' 4번째자리부터 3자리 출력 
from dual;

select ename, substr (ename, 3,3) as 잘라온값
from employee;

--instr
select 'Oracle mania', instr('Oracle mania', 'a')
from dual;

select 'Oracle mania', instr('Oracle mania', 'a', 4)
from dual;

select ename, instr(ename, upper('k'))
from employee;

--lpad/rpad
select salary, lpad(salary, 10, '*') --급여 컬럼의 값을 10자리로 표현하고, 왼쪽 공백은 *로 표시
from employee;

select salary, rpad(salary, 10, '*') --급여 컬럼의 값을 10자리로 표현하고, 오른쪽 공백은 *로 표시
from employee;

--trim
select '     Oracle mania    ' as 원본,
trim('     Oracle mania    ') as 공백제거
from dual;

/* 2. 숫자 함수
ROUND : 특정 자릿수에서 반올림
    ㄴ ROUND (대상): 소수점 뒷자리에서 반올림
    ㄴ ROUND (대상, 정수)
        - 정수가 양수일 때 : 소수점 기준으로 오른쪽으로 이동, 그 뒷자리를 반올림
        - 정수가 음수일 때 : 소수점 기준으로 왼쪽으로 이동, 그 자리에서 반올림
TRUNC : 특정 자릿수에서 잘라냄
MOD : 입력받은 수를 나누고 나머지 값만 만환
*/
select 98.7654 as 원본,
round (98.7654),        --99
round (98.7654, 2),     --98.77 소수점 기준으로 오른쪽으로 두자리 이동 후 뒤에서 반올림
round (98.7654, -1),    --100   소수점 기준으로 왼쪽으로 이동 후 그자리에서 반올림
round (98.7654, -2),    --100
round (98.7654, -3),    --0
round (98.7654, 3)      --98.765
from dual;

select 12345.6789 as 원본,
round (12345.6789), --12346
round (12345.6789, -3), --12000
round (12345.6789, 3) --12345.679
from dual;

--TRUNC : 잘라서 버림
select 98.7654 as 원본,
trunc (98.7654),    --98
trunc (98.7654,2),  --98.76
trunc (98.7654,-1)  --90
from dual;

--ㅡMOD (대상, 양수) : 대상을 양수로 나누는 값의 나머지
select mod (31,2), mod(31,5),mod(31,8)
from dual;
    --사원번호가 짝수인 사원만 출력
select * from employee
where mod (eno,2) = 0;

/*3. 날짜함수
sysday : 현재 시스템의 날짜와 시간을 출력
months_between : 두 날짜 사이의 개월 수를 출력
add_months : 특정 날짜에 개월 수를 더할때
next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
last_day : 달의 마지막 날짜를 반환
round : 날짜를 반올림, 15일 이상은 반올림, 15일 미만은 버림
trunc : 날짜를 버림
*/
--sysdate
select sysdate from dual;

select sysdate-1 as 어제날짜, sysdate as 오늘날짜, sysdate+1 as 내일날짜 from dual;

select hiredate as 입사날짜, hiredate-1, hiredate+10 from employee;

    --근무일수 구하기
    select round(sysdate-hiredate) as 총근무일수 from employee;
    
    select round((sysdate-hiredate),2) as 총근무일수 from employee;
    
--특정 날짜에서 달(MONTH)을 기준으로 버리기 (기존 일자가 사라지고 해당달 01일로 전환)
    select hiredate as 원본, trunc (hiredate, 'MONTH') from employee;
    
--특정 날짜에서 달(MONTH)을 기준으로 반올림하기, 15일 이상은 다음달 01일, 15일 미만은 해당달 01일
     select hiredate as 원본, round (hiredate, 'MONTH') from employee;
    
--months_between(date1, date2) :두 날짜 사이 개월 수 출력
    --근무 개월수 구하기
    select ename, hiredate, trunc(months_between(sysdate, hiredate)) as 근무개월수
    from employee;

--add_months (date1, 개월) : date1에 개월수를 더해 출력
    --입사 6개월 시점 출력
    select hiredate, add_months(hiredate,6) from employee;
    --입사 100일 시점 출력
    select hiredate, hiredate+100 as 입사100일 from employee;
    
--next (date, '요일') :date를 지난 다음의 해당 요일 출력
    select sysdate, next_day(sysdate, '월요일')
    from dual;
    
--last_day(date) : date가 해당하는 달의 마지막 날짜 출력
    select hiredate, last_day(hiredate) as 해당월마지막날 from employee;
    
/*4. 형 변환 함수 !중요!
TO_CHAR : 날짜형, 숫자형을 문자형으로 변환하는 함수
TO_DATE : 문자형을 날짜형으로 변환하는 함수
TO_NUMBER : 문자형을 숫자로 변환하는 함수
*/

--TO_CHAR(date, 'YYYYMMDD') : 날짜 형식을 변환해 char 타입으로 출력
    --yy: 연도 / mm: 월 / dd: 일 / dy: 단순 요일 / day: 자세한 요일 / hh 시 / mi 분 / ss 초
    select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YY-MM/DD'),
    to_char(hiredate,'YY--MM--DD--DY') from employee;
    --현재 시스템의 날짜와 시간, 요일 출력
    select  to_char(sysdate, 'yy-mm-dd (dy) hh:mi:ss') from dual;

--TO_CHAR(number, 'L###,###): 숫자 형식을 변환해 char 타입으로 출력
    --0: 자리수를 나타내고 자리수가 맞지 않으면 0으로 채움
    --9: 자리수를 나타내고 자리수가 맞지 않으면 빈칸으로으로 채움
    --L: 각지역의 통화기호를 출력 (. : 소수점 / , : 천단위 구분자)

select ename, salary, to_char(salary, 'L9,999,999'), to_char(salary, 'L000,000') from employee;

--TO_DATE('char', 'format') : char(문자) -> 날짜 형식으로 변환
--TO_DATE(number, 'format') : 숫자 -> 날짜 형식으로 변환

select sysdate, trunc(sysdate-to_date(20000101, 'yymmdd')) as "d+day" from dual;
    --*두 값 포맷이 맞지 않으면 오류 발생
    select sysdate-'2000-01-01' from dual;

select sysdate, sysdate-to_date('2000-01-01','yyyy-mm-dd') from dual;

    --2000년 1월 1일부터 2022년 2월 10일까지의 날짜 수 계산
    --'02/10/22' : 22년 02월 10일의 date 형식 변환
    select to_date('12/06/22','mm/dd/yy')-to_date('2000/01/01', 'yyyy/mm/dd') from dual;
    
    select trunc(sysdate-to_date(20000101,'yyyymmdd')) from dual;
    
    --employee테이블에서 81년 2월 22월 입사한 사원 검색 (문자열 ->date형식으로 변환해 검색)
    select ename 이름, hiredate 입사일 from employee
    where hiredate = to_date('1981-02-22','yyyy-mm-dd');
    
    --2000년 12월 25일부터 현재까지의 D+Month 확인, 소수점 이하 삭제
    select trunc(months_between(sysdate,to_date('12/25/00','mm/dd/yy'))) as "d+month" from dual;
    
--TO_NUMBER : 문자형 데이터를 숫자형으로 변환
select 10000-5000
from dual;

select '10000'-'5000' --자동으로 변환됨 : 문자열->숫자형
from dual;

select '10,000'-'5,000' --to_number로 변환이 필요함
from dual;

select to_number('10,000','99,999')-to_number('5,000', '9,999') as 숫자변환계산
from dual;

--5. 일반함수
--NVL : null을 처리하는 함수
    --nv1(컬럼명, 값): 컬럼에 null이 존재할때 값으로 대치
    --연봉 = 월급*12+보너스
    --보너스 컬럼에 null을 연산하면 null
    
select ename 이름, salary 월급, commission 보너스, 
salary*12+nvl(commission,0) as 연봉 from employee;
--NVL2 : null을 처리하는 함수
    --nvl(컬럼명, !null, null)
--NVL2함수를 사용해 총 연봉 계산
select ename 이름, salary 월급, commission 보너스, 
nvl2(commission, salary*12+commission, salary*12) as 연봉 from employee
-- NULLIF : 두 인자를 비교해서 동일한 경우 null을 반환하고, 아닌 경우 첫번째 표현식을 반환
    -- 동일하지 않은 경우 첫번째 표현식을 반환
    -- nullif(expr1, expr2)
    
select nullif('A','A'), nullif('A','B')
from dual;

--coalesce 함수
  --coalesce(expr1, expr2, expr3,...expr-n):
    --expr1 null아니면 expr1을 반환
    --expr1 null이고 expr2가 null이 아니면 expr2를 반환
    --expr1 null이고 expr2가 null이고 expr3가 null이 아니면 expr3를 반환

select coalesce ('abc', 'bcd', 'cde', 'def', 'efg')
from dual;

select coalesce (null, null, 'cde', 'def', 'efg')
from dual;

--decode함수 : switch case문과 동일한 함수
/*
    decode(표현식(컬럼명), 조건1, 결과,
                조건2, 결과2,
                조건3, 결과3
                ...
                기본결과n
            )
*/
--dno : 부서번호
-- 10 'ACCOUNTING'
-- 20 'RESEARCH'
-- 30 'SALES'
-- 40 'OPERATIONS'

select ename, dno, 
decode (dno, 10, 'ACCOUNTING', 
20, 'RESEARCH',
30, 'SALES',
40, 'OPERATIONS',
'DEFAULT')as 부서명
from employee;

--case : if~else if, else if와 비슷한 구문
/* 
    case WHEN 조건1 THEN 결과1
        when 조건2 then 결과2
        when 조건3 then 결과3
        else 결과n
    end
*/
    --부서번호에 대한 부서명 출력
select ename, dno,
    case when dno=10 then 'Accounting'
    when dno=20 then 'Research'
    when dno=30 then 'Sales'
    else 'Default'
    end as 부서명
from employee;


/*
그룹함수 : 동일한 값에 대해 그룹핑해서 처리하는 함수
group by 절에 특정 칼럼을 정의할 경우, 해당 칼럼의 동일한 값을 그룹핑해서 연산처리

집계함수: 연산을 처리하는 함수
    - sum: 합계를 구하는 함수
    - avg : 평균을 구하는 함수
    - max : 최대값
    - min : 최소값
    - count : 레코드수(한 라인의 값이 저장된), row(행)
    
    select 컬럼명
    from 테이블명
    where 조건
    group by 그룹핑할 컬럼
    having group by를  사용해 나온 결과에서 조건을 처리
    order by 정렬
*/

-- 집계함수를 컬럼에 사용하면 단일행으로 출력됨
select sum(salary) 합계, round(avg(salary),2) 평균, max(salary) 최대월급, min(salary) 최소월급
from employee;

--집계함수는 null을 0으로 자동으로 처리해 연산
select commission
from employee;

select sum(commission), avg(commission), max(commission), min(commission)
from employee;

--count함수 : 레코드수, row(행) 수,
select count(eno) as 레코드수 from employee; --14
    --null은 카운트되지 않음
    select count(manager) from employee;    --13
    --보너스를 받는 사원 수
    select count(commission) from employee;
    
--null이 포함된 컬럼을 count함수를 사용하면 전체 레코드 수가 부정확하게 출력될 수 있음
    --not null 정의된 칼럼이나 *를 사용해 카운트 해야함
    select count(*) from employee ;
    
    --부서 개수 카운트
    select count(distinct dno) 부서 개수
    from employee
    
    --부서별 급여 값 구하기: group by 동일한 컬럼 값 그룹핑하여 처리
    select dno 부서, sum(salary) 부서별월급합계, round(avg(salary)) 부서별월급평균, max(salary) 부서별최대월급, min(salary) 부서별최소월급, dno, count(*)
    from employee 
    group by dno    --dno칼럼의 동일한 값을 그룹핑
    order by dno;
    
    --직책별 월급 통계 출력
    --having <조건> :직책별 평균월급이 2000만원 이상인 것 출력
    --!주의! having절에서 별칭 사용할 경우 오류 발생
    select job 직책, sum(salary) 직책별월급합계, round(avg(salary)) 직책별월급평균, max(salary) 직책별최대월급, min(salary) 직책별최소월급
    from employee
    group by job
    having round(avg(salary))>=2000
    order by job;
    
    --where 테이블값을 조건을 주어서 가지고 올때 사용
    --having group by를 사용해서 나온 결과를 조건으로 출력
    
    --20번 부서는 제외하고 부서별 합계, 평균, 최대값, 최소값 출력(최소월급 1000만원 이상)
      select dno 부서, sum(salary) 부서별월급합계, round(avg(salary)) 부서별월급평균, max(salary) 부서별최대월급, min(salary) 부서별최소월급
    from employee 
    group by dno
    having dno in (10,30) and min(salary)>=1000 
    order by dno;
    
    select dno 부서, sum(salary) 부서별월급합계, round(avg(salary)) 부서별월급평균, max(salary) 부서별최대월급, min(salary) 부서별최소월급
    from employee
    where dno not in (20)
    group by dno
    having min(salary)>=1000 ;
    
    -- 두 컬럼 이상 그룹핑하기 : 두 칼럼 모두 동일할때 그룹핑 처리됨.
    select dno,job
    from employee
    order by dno, job;
    
    select sum(salary) 합계, round(avg(salary)) 평균, max(salary) 최대, min(salary) 최소, dno, job, count(*)
    from employee
    group by dno, job   -- 두 컬럼에 걸쳐서 동일한 것을 그룹핑
    order by dno, job
    
    --group by를 사용하면서 select 절에 출력할 컬럼
        --집계함수(sum, avg,max,min), count(*) ground by절에 사용된 칼럼
    --rollup 마지막라인에 전체합계, 전체평균을 추가적으로 출력 : group by절에서 사용됨
    select sum(salary), round(avg(salary)), max(salary), min(salary), dno, count(*)
    from employee
    group by rollup(dno)
    order by dno asc;
    
    --cube : 부서별 합계와 평균을 출력후 마지막라인에 전체 
    select sum(salary), round(avg(salary)), max(salary), min(salary), dno, count(*)
    from employee
    group by cube(dno)
    order by dno asc;
    
--서브쿼리(sub query) : select문 내에 select문이 위치한 쿼리
    --ename이 SCOTT인 사원과 동일한 직책의 사원을 출력
    select * from employee;
        -- sub query를 사용하지 않고 출력
        --1. SCOTT의 부서 확인
        select ename, job from employee where ename = 'SCOTT';
        --2. SCOTT의 부서와 동일한 직원을 출력
        select ename, job from employee where ename = 'ANALYST';
        
        --smit와 동일한 직책의 사원들을 sub query를 사용해서 한 라인에서 출력
        select ename, job from employee where job = (select job from employee where ename='SCOTT');
  
        --scott보다 월급이 많은 사용자 출력
        select ename from employee where salary > (select salary from employee where ename='SCOTT');
        
        --SMITH와 동일한 부서의 사원들을 sub query를 사용해서 출력
        select ename, dno from employee where dno = (select dno from employee where ename='SCOTT');
        
        --최소급여를 받는 사원의 이름, 담당업무, 급여 출력하기
        select ename, job, salary from employee where salary=(select min(salary) from employee);
        
        --각 부서의 최소 급여가 30번 부서의 최소 급여보다 큰 부서 출력
        --각부서의 최소 급여를 구함
        -- 30부서의 최소급여 보다 큰 부서를 출력
        select dno, min(salary), count(*)
        from employee
        group by dno
        having min(salary) > (select min(salary) from employee where dno = 30)
        order by dno
    
    --sub query에서 여러개의 값을 출력할 경우 : in 연산자를 사용
        --각 부서별로 최소 급여를 받는 사원의 사원번호와 이름을 출력
        select eno 사원번호, ename 사원명, salary 월급, dno 부서번호
        from employee
        where salary in (
        select min(salary) from employee
        group by dno); --sub query 부서별로 최소 월급을 출력

--all 연산자
    -- '>all' :최대값보다 큼을 나타냄
    -- '<all' :최소값보다 작음을 나타냄
--any 연산자
    --'<any' 최대값보다 작음을 나타냄
    --'>any' 최소값보다 큼을 나타냄
    --'=any'는 in과 동일
    
        --직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
        select eno, ename, job, salary
        from employee
        where salary < all(select salary from employee
                            where job = 'SALESMAN')
                    and job <> 'SALESMAN';  
                    
        --담당 억무가 분석가인 사원보다 급여가 적으면서 업무 분석가가 아닌 사원 표시
        select ename, job 
        from employee
        where salary < all(select salary from employee
                            where job = 'ANALYST')
                    and job <> 'ANALYST';