create database maxtronic;

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

create table item(
itm_code char(4),
itm_description varchar(25),
itm_unit_price decimal(9,2),
itm_imported tinyint(1),
itm_supplier varchar(20),
primary key(itm_code)
);

desc item;
desc location;
desc store;

create table location(
loc_code char(4),
loc_name varchar(25),
loc_contact char(11),
loc_address varchar(300),
primary key(loc_code)
);

create table store(
st_item_code char(4),
st_location_code char(4),
st_qty int,
st_date date,
primary key (st_item_code,st_location_code),
foreign key (st_item_code) references item(itm_code),
foreign key(st_location_code) references location(loc_code)
);

select user from mysql.user;

insert into item(itm_code , itm_description , itm_unit_price , itm_imported  , itm_supplier)
values
('IT10' , 'Television' , 24000.00 , 1 , 'Sony'),
('IT11' , 'Computer' ,60000.00 , 1 ,'Dell'),
('IT12' , 'Laser Printer' ,19000.00 , 1 ,'HP'),
('IT13' , 'VCD Player' ,7599.00, 1 ,''),
('IT15' , 'Polisher' , 12000.00, 1 , 'National')
;

select * from item;

delete from  item
where itm_code = 'IT10';

delete from item ; 

alter table item
add primary key (itm_code);

alter table item
modify column itm_imported int;


alter table item
add dob date;
 
 alter table item 
 drop dob;
 
 update item 
 set itm_supplier = 'DELL'
 where itm_code = 'IT10';
 
 update item 
 set itm_supplier = 'Sony'
 where itm_code = 'IT10';
 
update item 
set itm_unit_price = itm_unit_price + 5000.00
;

update item 
set itm_unit_price = itm_unit_price + 5000.00
where itm_unit_price > 20000 ;