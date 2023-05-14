CREATE DATABASE maxtronic;

USE maxtronic;

use maxtronic;

create user if not exists 'admin'@'localhost' identified by 'admin123';
create user if not exists 'emp'@'localhost' identified by 'emp123';
create user if not exists 'user'@'localhost' identified by 'user123';

grant all privileges on *.* 
to 'admin'@'localhost';

grant select,insert,update,delete on *.*
to 'emp'@'localhost';

grant select on *.*
to 'user'@'localhost';

flush privileges;


CREATE USER admin_max@localhost;
GRANT ALL PRIVILEGES ON *.* TO admin_max@localhost WITH GRANT OPTION;

create user emp_max@localhost;
grant select, insert, update, delete on *.* to emp_max@localhost;

create user user_max@localhost;
grant select on *.* to user_max@localhost;

select user from mysql.user;

create table item (
	itm_code char(4),
    itm_description varchar(25),
    itm_unit_price decimal(9,2),
    itm_imported tinyint(1),
    itm_supplier varchar(20),
    primary key(itm_code)
);

create table location (
	loc_code char(4),
    loc_name varchar(25),
    loc_contact char(11),
    loc_address varchar(300),
    primary key(loc_code)
);

create table store (
	st_item_code char(4),
    st_location_code char(4),
    st_qty int,
    st_date date,
    primary key(st_item_code,st_location_code),
    foreign key (st_item_code) references item(itm_code),
    foreign key (st_location_code) references location(loc_code)
);

insert into item values 
	("IT10","Television",24000.00,1,"Sony"),
    ("IT11","Computer",60000.00,1,"Dell"),
    ("IT12","Laser Printer",19000.00,1,"HP"),
    ("IT13","VCD Player",7599.00,1,NULL),
    ("IT15","Polisher",12000.00,1,"National"),
    ("IT16","Scanner",16000.00,NULL,"HP"),
    ("IT17","Refrigerator",65000.00,1,"LG"),
    ("IT18","Table Lamp",2999.00,0,"Abans"),
    ("IT19","Wall Clock",1200.00,1,NULL),
    ("IT20","Blender",4800.00,1,"National"),
    ("IT14","Oven",7300.00,0,"Abans")
;

select * from item;

insert into store values
	("IT10","L01",30,"2016-04-08"),
    ("IT10","L03",3,"2016-04-02"),
    ("IT10","L04",10,"2016-04-25"),
    ("IT11","L01",25,NULL),
    ("IT11","L02",12,"2016-05-07"),
    ("IT13","L04",60,"2016-05-09"),
    ("IT16","L02",5,NULL)
;

select * from store;

insert into location values
	('L01','Colombo',0112946058,'Colombo 04'),
	('L02','Kalutara',NULL,'Mian Street'),
	('L03','Galle',0912546893,NULL),
	('L04','Matara',0411570045,'Dharmpala Mawatha')
;

select * from location;


-- Q07========================= 
select itm_description , itm_unit_price
from item;

-- Q08

select st_item_code
from store;

-- Q09
select distinct st_item_code
from store;

-- Q10

select itm_description , itm_unit_price
from item
order by itm_description asc;


-- Q11

select st_item_code , st_qty
from store
order by st_item_code asc , st_qty desc; 



-- Q12

select * from item
where itm_unit_price >20000;


-- Q13

select st_item_code
from store
where st_location_code = 'L01';

-- Q14

select * from item
where itm_description like 'T%';

-- Q15

select * from item
where itm_description like '%er';

-- Q16

select * from item
where itm_supplier IN ("DELL" , "HP" , 'LG') ;

-- Q17

select itm_code , itm_description
from item
where itm_supplier is not null;

select itm_code , itm_description
from item
where itm_supplier is null;

-- Q19 

select  itm_description , st_qty , loc_name
from item, store, location
where itm_unit_price > 20000
AND item.itm_code = store.st_item_code 
AND location.loc_code = store.st_location_code; 

-- Q20

select  st_item_code , loc_name , st_qty
from store, location
where location.loc_code = store.st_location_code; 

-- 21

select  itm_description , loc_name
from item, store , location
where item.itm_code = store.st_item_code 
AND location.loc_code = store.st_location_code;

-- Q22

select count(*) as 'Iterm count'
from item;

-- Q23
select sum(st_qty) as 'sumeeee'
from store;


-- store prosegear-------------------8-8-8-8-8--------------------

delimiter //
create procedure lahiru()
begin
	select * from item;
end//

delimiter ;

call lahiru;


delimiter //
create procedure dana()
begin
	select * from store;
end //
delimiter ;

call dana;


delimiter //
create procedure muthu()
begin
	select * from item;
end //
delimiter ;

-- **********
delimiter //
create procedure maxx(in xx varchar(20))
begin
	select * from location where loc_name = xx;
end //
delimiter ;

call maxx("colombo");


delimiter //
create procedure loca (in ss varchar (30) )
begin
	select * from location where loc_name = ss;
end //
delimiter ;

call loca('galle');



delimiter //
create procedure id(in gg char(10) )
begin
	select * from item where itm_code = gg;
end //
delimiter ;

call id('IT10');

delimiter //
create procedure xxx()
begin 
	select * from location;
end //
delimiter ;

call xxx;

delimiter //
create procedure tion(in ff varchar(30) )
begin
	select * from location where loc_name = ff;
end //
delimiter ;

call tion('galle');


-- View **************************************************

create view Doni AS
select * from location;

select * from Doni;


create view madhu AS 
select * from item;

select * from madhu;


create or replace view madhu  AS
select  st_item_code , loc_name , st_qty
from store, location
where location.loc_code = store.st_location_code; 

select * from madhu ;


create or replace view doni AS
select st_item_code
from store
where st_location_code = 'L01';

select * from doni ;

drop view doni;


-- practical 06-------------------------------

-- Q21

select * from item
where itm_code between 'IT10'AND 'IT19';

-- Q22

select * from item
where itm_code not between 'IT10'AND 'IT19';

-- Q23

select itm_description
from item as i,store as s
where st_location_code IN ('L01' OR 'L04') 
AND i.itm_code = s.st_item_code ;

-- Q24

select distinct itm_description, itm_unit_price
from item , store
where item.itm_code = store.st_item_code 
AND st_location_code IN('L01' OR 'L02') 
order by itm_unit_price desc; 

-- Q25


select distinct itm_description , itm_unit_price , loc_code
from item ,store , location
where item.itm_code = store.st_item_code 
AND location.loc_code = store.st_location_code
AND st_location_code IN('L01' OR 'L02') 
order by loc_code desc; 

-- Q26

select count( loc_name)
from location;

-- Q27
create table sales(
sa_trans_no int auto_increment primary key,
sa_item_code char(4),
sa_location_code char(4),
sa_sales_qty int,
sa_date_of_sale date,
foreign key(sa_item_code) references item(itm_code),
foreign key(sa_location_code) references location(loc_code)
);
    
insert into sales
(sa_item_code,sa_location_code,sa_sales_qty,sa_date_of_sale)
values
('IT10','L01',3,'2016-5-2'),
('IT10','L03',1,'2016-5-12'),
('IT13','L04',15,'2016-4-7'),
('IT11','L01',12,'2016-4-15'),
('IT11','L02',5,'2016-7-12')
;

-- Q27

select sum(sa_sales_qty) 
from sales
where sa_item_code = 'IT10';

-- Q28
select sum(sa_sales_qty) 
from sales
where sa_location_code = 'L03';

-- Q29

SELECT MAX(itm_unit_price)
from item;


-- Q30

SELECT itm_description
from item
where itm_unit_price = (SELECT MAX(itm_unit_price) from item)
;

-- Q31

SELECT itm_description
FROM item as i, sales as s
WHERE  i.itm_code = s.sa_item_code
AND (extract( year from  sa_date_of_sale)) = '2011'
AND (extract(month from sa_date_of_sale)) = '5';


-- Q32

SELECT round((itm_unit_price * 5) - (itm_unit_price *5 ) * (10/100),2) ' How many rupees have be paid' 
from item
where itm_code='IT11';

SELECT round( (itm_unit_price *5 ) * (90/100),2) ' How many rupees have be paid' 
from item
where itm_code='IT11';








