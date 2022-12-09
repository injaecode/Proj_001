--와인 종류 정보 관리 테이블

create table wine_type (
wine_type_code varchar2(6) not null constraint wine_type_code_PK primary key,
wine_type_name varchar2(50)
);

insert into wine_type
values('1','12');

insert into wine_type
values('2','23');

insert into wine_type
values('3','34');

insert into wine_type
values('4','45');

insert into wine_type
values('5','56');

select * from wine_type;

-- 관리자 관련 정보 테이블

create table manager (
manager_id varchar2(30) not null constraint manager_id_PK primary key,
manager_pwd varchar2(30) not null,
manager_tel varchar2(30)
);

insert into manager
values ('man1', '123', '010-1111-1111');

insert into manager
values ('man2', '1234', '010-1111-1112');

insert into manager
values ('man3', '12345', '010-1111-1113');

insert into manager
values ('man4', '123456', '010-1111-1114');

insert into manager (manager_id, manager_pwd)
values ('man5', '1234567');

select * from manager;

---재고 관련 정보 테이블
create table stock_management (
stock_code varchar2(6) not null constraint stock_code_PK primary key,
wine_code varchar2(6),
manager_id varchar2(30),
constraint manager_id_FK Foreign key (manager_id) references manager (manager_id),
ware_date date default sysdate not null ,
stock_amount number(5) default 0 not null
);

insert into stock_management
values ('1212', 'A', 'man1', default, default);

insert into stock_management
values ('1213', 'A', 'man1', default, default);

insert into stock_management
values ('1214', 'A', 'man2', default, default);

insert into stock_management
values ('1215', 'A', 'man3', default, default);

insert into stock_management
values ('1216', 'A', 'man4', default, default);
select * from stock_management;

drop table stock_management
--와인 테마 정보 테이블
create table theme (
theme_code varchar2(6) not null constraint theme_code_PK primary key,
theme_name varchar2(50) not null
);

insert into theme
values ('99','christmas');

insert into theme
values ('98','thanks giving');

insert into theme
values ('97','birth day');

insert into theme
values ('96','gloomy');

insert into theme
values ('95','anniversary');

select * from theme;
--와인 관련 정보
create table wine (
wine_code varchar2(26) not null constraint wine_code_PK primary key,
wine_name varchar2(100) not null,
wine_url blob,
nation_code varchar2(6),
wine_type_code varchar2(6),
constraint wine_type_code_FK foreign key (wine_type_code) references wine_type (wine_type_code),
wine_sugar_code number(2),
wine_price number(15) default 0 not null ,
wine_vintage date,
theme_code varchar2(6),
constraint theme_code_FK foreign key (theme_code) references theme (theme_code),
today_code varchar2(6)
);

insert into wine (wine_code, wine_name, nation_code, wine_type_code, wine_price, wine_vintage, theme_code, today_code)
values ('Aplus','산테로피노샤르도네','IT', '1', '17000',sysdate,'99','1201');

insert into wine (wine_code, wine_name, nation_code, wine_type_code, wine_price, wine_vintage, theme_code, today_code)
values ('Bplus','에스크도 로호','FR', '2', '27500',sysdate,'99','1207');

insert into wine (wine_code, wine_name, nation_code, wine_type_code, wine_price, wine_vintage, theme_code, today_code)
values ('B','보칸티노','IT', '3', '100000',sysdate,'99','1208');

insert into wine (wine_code, wine_name, nation_code, wine_type_code, wine_price, wine_vintage, theme_code, today_code)
values ('A','브레드앤버터','FR', '4', '113000',sysdate,'99','1205');

insert into wine (wine_code, wine_name, nation_code, wine_type_code, wine_price, wine_vintage, theme_code, today_code)
values ('C','샤또 보네','PG', '5', '34000',sysdate,'99','1231');


select * from wine;

--국가 관련 정보 테이블
create table nation(
nation_code varchar2(26) not null constraint nation_code_PK primary key,
nation_name varchar2(50) not null
);

insert into nation
values ('FR', '프랑스');

insert into nation
values ('IT', '이탈리아');

insert into nation
values ('PG', '포르투갈');

insert into nation
values ('CZ', '체코');

insert into nation
values ('KR', '한국');
select * from nation;

------오늘의 와인정보 테이블
create table today(
today_code varchar2(6) not null constraint today_code_PK primary key,
today_sens_value number(3),
today_intell_value number(3),
today_phy_value number(3)
);

insert into today 
values('1201', 100, 45, 20);

insert into today 
values('1207', 70, 50, 60);

insert into today 
values('1208', 33, 66, 99);

insert into today 
values('1205', 100, 100, 100);

insert into today 
values('1231', 10, 10, 100);

select * from today;

------회원 등급별 마일리지율 테이블
create table grade_pt_rade(
mem_grade varchar2(20) not null constraint mem_grade_PK primary key,
grade_pt_rate number(3,2)
);

insert into grade_pt_rade
values ('A', 9.5);

insert into grade_pt_rade
values ('B', 7.5);

insert into grade_pt_rade
values ('C', 5.5);

insert into grade_pt_rade
values ('D', 3.5);

insert into grade_pt_rade
values ('E', 1.5);
select * from grade_pt_rade;

---회원정보 테이블
create table member_wine(
mem_id varchar2(6) not null constraint mem_id_PK primary key,
mem_grade varchar2(20),
constraint mem_grade_FK foreign key (mem_grade) references grade_pt_rade (mem_grade),
mem_pw varchar2(20) not null,
mem_birth date default sysdate not null,
mem_tel varchar2(20),
mem_pt varchar2(10) default 0 not null
);

insert into member_wine
values ('scott', 'C', '123123', default, '010-1111-1111', default);

insert into member_wine
values ('amy', 'B', '123123', default, '010-1111-1112', default);

insert into member_wine
values ('emma', 'C', '123123', default, '010-1111-1113', default);

insert into member_wine
values ('mike', 'E', '123123', default, '010-1111-1114', default);

insert into member_wine
values ('ashy', 'D', '123123', default, '010-1111-1115', default);

select * from member_wine;

---구매 정보 테이블
create table sale (
sale_date date default sysdate not null constraint sale_date_PK primary key,
wine_code varchar2(6) not null,
constraint wine_code_FK foreign key (wine_code) references wine (wine_code),
mem_id varchar2(30) not null,
constraint mem_id_FK foreign key (mem_id) references member_wine (mem_id),
sale_amount varchar2(5) default 0 not null,
sale_price varchar2(6) default 0 not null,
sale_tot_price varchar2(15) default 0 not null
);

insert into sale
values (default, 'A', 'mike', default, default, default);

insert into sale
values (default, 'B', 'scott', default, default, default);

insert into sale
values (default, 'C', 'ashy', default, default, default);

insert into sale
values (default, 'B', 'emma', default, default, default);

insert into sale
values (default, 'A', 'amy', default, default, default);

select * from sale;

alter table stock_management
add constraint wine__code_FK foreign key (wine_code) references wine (wine_code);

alter table wine
add constraint nation_code_FK foreign key (nation_code) references nation (nation_code);

alter table wine
add constraint today_code_FK foreign key (today_code) references today (today_code);

commit;