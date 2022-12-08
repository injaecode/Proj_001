create table tb_zipcode (
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );
  
    desc tb_zipcode;
    
    insert into tb_zipcode (zipcode, sido, gugum, dong, bungi)
    values ('42100', '서울시', '종로구', '인사동', '12-3');
    
    insert into tb_zipcode (zipcode, sido, gugum, dong, bungi)
    values ('41230', '부산시', '연제구', '중동', '64-82');
    
    insert into tb_zipcode (zipcode, sido, gugum, dong, bungi)
    values ('15020', '경기도', '의정부시', '의정부동', '1-11');
   
   insert into tb_zipcode (zipcode, sido, gugum, dong, bungi)
   values ('22321', '경기도', '광명시', '철산동', '633-1');
    
    insert into tb_zipcode (zipcode, sido, gugum, dong, bungi)
    values ('32223', '서울시', '은평구', '응암동', '17-17');
    
    commit;
    
    create table member (
    id varchar2(20) not null constraint PK_member_id primary key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7), 
    constraint FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode (zipcode),
    adress varchar2(20),
    tel varchar2(13),
    indate date default sysdate
    );

    desc member;
    select * from user_constraints 
    where table_name = 'MEMBER';
    
    
    insert into member (id, pwd, name, zipcode, adress, tel, indate)
    values ('aa123', '1234', '최군', '42100', '서울시 강남구', '010-1111-2222', default);
  
    insert into member (id, pwd, name, zipcode, adress, tel)
    values ('ab126', '1237', '김양', '41230', '부산시 연제구', '010-1111-3333' );
  
    insert into member 
    values ('abb123', '12#34', '최군', '15020', '경기도 의정부', '010-1111-4444', default);
  
  insert into member 
    values ('abb1723', '12#34', '임양', '22321', '경기도 광명시', '010-1111-5555', default);
  
  insert into member 
    values ('12abb123', '12#3@4', '양군', '15020', '서울시 은평구', '010-1111-6666', default);
  
  select * from member
  
  -------------------------------------------------------------
  
  create table products (
  product_code varchar2(20) not null constraints PK_products_product_code primary key,
  product_name varchar2(100),
  product_kind char(1),
  product_price1 varchar2(10),
  product_price2 varchar2(10),
  product_content varchar2(1000),
  sizeSt varchar2(5),
  sizeEt varchar2(5),
  product_quantity varchar2(5),
  useyn char(1),
  indate date
  );
  
  insert into products values('11', '티셔츠', '1', '1000', '1100', '반팔', 'xs', 'xl', '100','y','22/12/08')
  insert into products values('12', '티셔츠1', '2', '1001', '1101', '반팔1', 'xs', 'xl', '100','y','22/12/08')
  insert into products values('13', '티셔츠1', '1', '1000', '1100', '반팔', 'xs', 'xl', '100','y','22/12/08')
  insert into products values('14', '티셔츠', '1', '1000', '1100', '반팔', 'xs', 'xl', '100','y','22/12/08')
  insert into products values('15', '티셔츠', '1', '1000', '1100', '반팔', 'xs', 'xl', '100','y','22/12/08')
  
  create table orders (
  o_seq number(10) not null constraints PK_orders_o_seq primary key,
  product_code varchar2(20),
  constraint FK_orders_product_code_products Foreign key (product_code) references products (product_code),
  id varchar2(16),
  constraint FK_orders_id_member Foreign key (id) references member (id),
  product_size varchar2(5),
  quantity varchar2(5),
  result char(1),
  indate date
  );
desc orders;
  insert into orders values('1231', '11', 'aa123', 'xs', '1', 'y', '22/12/01');
   insert into orders values('1232', '12', 'ab126', 'xs', '1', 'y', '22/12/01');
     insert into orders values('1233', '13', 'abb123', 'xs', '1', 'y', '22/12/01');
       insert into orders values('1234', '14', 'abb1723', 'xs', '1', 'y', '22/12/01');
         insert into orders values('1235', '15', '12abb123', 'xs', '1', 'y', '22/12/01');

select * from orders