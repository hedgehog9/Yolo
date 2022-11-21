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



create table tbl_schedule
(
 schedule_no    number 
,fk_empno       number
,start_date     date
,end_date       date
,subject        nvarchar2(30)
,content        nvarchar2(300) 
,color          varchar2(20)
,category       varchar2(20)
,fk_deptno      number
,joinuser       nvarchar2(200)
,constraint PK_tbl_schedule_schedule_no primary key(schedule_no)
,constraint CK_tbl_member_category check (category in('미팅','출장','회의'))
-- fk_empno, fk_deptno 외래키 등록하기
);

-- ALTER TABLE tbl_schedule ADD joinuser NVARCHAR2(200);
ALTER TABLE tbl_schedule ADD place NVARCHAR2(100);

create sequence seq_scheduleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_schedule(schedule_no, fk_empno, start_date, end_date, subject, content, color, category, fk_deptno, joinuser, place)
values(seq_scheduleno.nextval, 2, to_date('2022-11-19 09:00','YYYY-MM-DD HH24:MI:SS'), to_date('2022-11-19 18:00','YYYY-MM-DD HH24:MI:SS'), '이게나오나', '테스트', 'red', '미팅', 2, null, '집')

commit

select * from tbl_schedule

select to_char(end_date, 'yyyy-mm-dd hh24:mi:ss') from tbl_schedule

select schedule_no,fk_empno
      ,to_char(start_date,'yyyy-mm-dd hh24:mi') as start_date
      ,to_char(end_date,'yyyy-mm-dd hh24:mi') as end_date
      ,subject,content,color,category,fk_deptno,joinuser 
from tbl_schedule

update tbl_schedule 
set 
(start_date, end_date, subject, content, color, joinuser, category, place)
= ()

















