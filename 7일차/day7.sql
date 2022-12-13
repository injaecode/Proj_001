/* view, index*/

show user; 
    --view의 정보를 저장하는 데이터사전
select * from user_view;
    --index 정보를 저장하는 데이터사전
    
/* view : 가상의 테이블, 데이터가 저장되어있지 않다
        --실제 테이블의 값을 select하는 코드만 들어가있다
        --목적 1. 보안을 위해 사용하는 경우  : 실제 테이블의 특정 컬럼을 숨겨서 처리
        --     2. 편의성을 위해 사용하는 경우: 복잡한 구문을 view로 만들어서 처리
                    join구문, 복잡한 구문
*/

    --view 실습을 위한 샘플 테이블 생성
    create table emp100
    as
    select * from employee;
    
    --view 생성 : 1. 보안을 위해 사용하는 경우
    
    create view V_emp
    as 
    select eno, ename, salary from employee;
    