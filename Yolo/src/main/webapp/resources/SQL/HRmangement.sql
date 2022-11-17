show user

create table tbl_member 
(
 empno          number 
,deptno         number
,email          nvarchar2(50)
,pwd            nvarchar2(200)
,name           varchar2(20)
,hiredate       date default sysdate 
,retiredate     date default null
,birthdate      date
,mobile         nvarchar2(11)
,address        nvarchar2(150)   
,manger_no      number
,position       varchar2(20)
,time_salary    number
,status         varchar2(20) default '재직'    -- 재직여부를 나타내는 컬럼
,constraint PK_tbl_member_empno primary key(empno)
,constraint CK_tbl_member_status check (status in('재직','퇴직','휴직'))
,constraint CK_tbl_member_position check (position in('사장','부장','차장','과장','대리','사원','인턴'))
);


insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(1,1,'karina@gmail.com','qwer1234$','카리나1','19961127','01072696621','서울',0,'사장',1000)

insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(2,1,'karina2@gmail.com','qwer1234$','카리나2','19961127','01072696621','서울',0,'사장',1000);

insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(3,1,'karina3@gmail.com','qwer1234$','카리나3','19961127','01072696621','서울',0,'사장',1000);

insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(4,1,'karina4@gmail.com','qwer1234$','카리나4','19961127','01072696621','서울',0,'사장',1000);

insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(5,1,'karina5@gmail.com','qwer1234$','카리나5','19961127','01072696621','서울',0,'사장',1000);

insert into tbl_member(empno,deptno,email,pwd,name,birthdate,mobile,address,manger_no,position,time_salary)
values(6,1,'karina6@gmail.com','qwer1234$','karina6','19961127','01072696621','서울',0,'사장',1000);

commit;

select email, name from tbl_member
where name like '%'||'ka'||'%';



