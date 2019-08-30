drop table memoTime;

select * from tab;

create table memoTime(
num NUMBER,
name varchar2(15),
title varchar2(100),
indate date default sysdate,
pass varchar2(15),
primary key(NUM),
status NUMBER default 0
);


CREATE SEQUENCE AUTO_SEQ_NUMBER
INCREMENT BY 1
START WITH 1
MAXVALUE 1000
NOCACHE
NOCYCLE;

