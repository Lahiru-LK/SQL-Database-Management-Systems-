CREATE DATABASE maxtronic;
USE maxtronic;
CREATE USER admin_max@localhost identified by '123456';
GRANT ALL ON maxtronic.* TO admin_max@localhost;
CREATE USER emp_max@localhost identified by '123456';
GRANT SELECT,INSERT,UPDATE,DELETE ON maxtronic.* TO emp_max@localhost;
CREATE USER user_max@localhost identified by '123456';
GRANT SELECT ON maxtronic.* TO user_max@localhost;

CREATE TABLE item(
itm_code CHAR(4),
itm_description VARCHAR(25),
itm_unit_price DECIMAL(9,2),
itm_imported TINYINT,
itm_supplier VARCHAR(20),
PRIMARY KEY (itm_code));

INSERT INTO item
VALUES
('IT10','Television',24000.00,1,'Sony'),
('IT11','Computer',60000.00,1,'Dell'),
('IT12','Laser Printer',19000.00,1,'HP'),
('IT13','VCD player',7599.00,1,NULL),
('IT15','Polisher',12000.00,1,'National'),
('IT16','Scanner',16000.00,NULL,'HP'),
('IT17','Refrigerator',65000.00,1,'LG'),
('IT18','Table Lamp',2999.90,0,'Abans'),
('IT19','Wall Clock',1200.00,1,NULL),
('IT20','Blender',4800.00,1,'National'),
('IT14','Oven',7300.00,0,'Abans');

CREATE TABLE location(
loc_code CHAR(4),
loc_name VARCHAR(25),
loc_contact CHAR(11),
loc_address VARCHAR(300),
PRIMARY KEY(loc_code));

INSERT INTO location
VALUES
('L01','Colombo','0112946058','Colombo 04'),
('L02','Kalutara',NULL,'Main Street'),
('L03','Galle','0912546893',NULL),
('L04','Matara','0415670045','Dharmapala Mawatha');

CREATE TABLE store(
st_item_code CHAR(4),
st_location_code CHAR(4),
st_qty INT,
st_date DATE,
PRIMARY KEY(st_item_code,st_location_code),
FOREIGN KEY(st_item_code) REFERENCES item(itm_code),
FOREIGN KEY(st_location_code) REFERENCES location(loc_code));

INSERT INTO store
VALUES
('IT10','L01',30,'2016-04-08'),
('IT10','L03',3,'2016-04-02'),
('IT10','L04',10,'2016-04-25'),
('IT11','L01',25,NULL),
('IT11','L02',12,'2016-05-07'),
('IT13','L04',60,'2016-05-09'),
('IT16','L02',5,NULL);

SHOW tables;
DESC item;
SELECT * FROM item;
SELECT * FROM location;
SELECT * FROM store;

SELECT itm_description,itm_unit_price FROM item;

SELECT st_item_code FROM store;
SELECT DISTINCT st_item_code FROM store;

SELECT itm_description,itm_unit_price FROM item ORDER BY itm_unit_price DESC;
-- Retrieve st_item_code and st_qty from the store table according to the ascending order of st_item_code and then by descending order of st_qty.
SELECT st_item_code,st_qty
FROM store
ORDER BY st_item_code ASC,st_qty DESC;
-- Retrieve all records from Item table where itm_unit_price is greater than 20000.00. 
SELECT *
FROM item
WHERE itm_unit_price>20000.00;

-- Retrieve item codes which are stored in the location L01.
SELECT st_item_code
FROM store
WHERE st_location_code='L01';

-- List the item descriptions begin with letter T.
SELECT itm_description
FROM item
WHERE itm_description LIKE 'T%';

-- List the item descriptions end with er.
SELECT itm_description
FROM item
WHERE itm_description LIKE '%er';

-- List the details of items of supplier Dell, HP and LG
SELECT *
FROM item
WHERE itm_supplier='Dell' OR itm_supplier='HP' OR itm_supplier='LG';

-- Get the item code and the item name which supplier is known. 
SELECT itm_code,itm_description
FROM item
WHERE itm_supplier IS NOT NULL;

-- Get the item code and the item name which supplier is not known. 
SELECT itm_code,itm_description
FROM item
WHERE itm_supplier IS NULL;

-- Retrieve description, stored quantity and location name where items itm_unit_price exceeds 20000.00
SELECT i.itm_description AS 'Item Name',s.st_qty AS "Quantity",l.loc_name AS "Location"
FROM item AS i,store AS s,location AS l
WHERE i.itm_code=st_item_code AND l.loc_code=s.st_location_code AND i.itm_unit_price>20000.00;

-- Retrieve st_item_code, loc_name and st_qty for the items which are stored in store table.
SELECT s.st_item_code,l.loc_name,s.st_qty
FROM location AS l,store AS s
WHERE l.loc_code = s.st_location_code;

-- . Retrieve the Item descriptions and stored location names.
SELECT i.itm_description,l.loc_name
FROM item AS i,location AS l,store AS s
WHERE i.itm_code=s.st_item_code AND l.loc_code = s.st_location_code;

-- How many items are available in the item table?
SELECT COUNT(itm_code)
FROM item;

-- Get the summation of quantities stored in all locations.
SELECT s.st_location_code AS 'Location Code',l.loc_name AS 'Location Name',SUM(s.st_qty) AS 'Quantity'
FROM store AS s,location AS l,item AS i
WHERE i.itm_code=s.st_item_code AND l.loc_code = s.st_location_code
GROUP BY s.st_location_code;

CREATE TABLE sales(
sa_trans_no INT PRIMARY KEY auto_increment,
sa_item_code CHAR(4),
sa_location_code CHAR(4),
sa_sals_qty INT,
sa_date_of_sale DATE,
FOREIGN KEY (sa_item_code) REFERENCES item(itm_code),
FOREIGN KEY (sa_location_code) REFERENCES location(loc_code));

INSERT INTO sales
VALUES
(NULL,'IT10','L01',3,'2016-5-2'),
(NULL,'IT10','L01',1,'2016-5-12'),
(NULL,'IT13','L04',15,'2016-4-7'),
(NULL,'IT11','L01',12,'2016-4-15'),
(NULL,'IT11','L02',5,'2016-7-12');

SELECT sum(st_qty)
FROM store;

SELECT top(5)
FROM item;

SELECT itm_description
FROM item
ORDER BY itm_unit_price DESC
LIMIT 5;

-- List the item descriptions and unit prices for most cheapest 3 items
SELECT itm_description,itm_unit_price
FROM item
ORDER BY itm_unit_price ASC
LIMIT 3;

-- Find the cheapest item within the Dell,HP,LG products
SELECT *
FROM item
WHERE itm_unit_price = (SELECT MIN(itm_unit_price) FROM item WHERE itm_supplier IN ('DEll','HP','LG'));

-- Retrieve all records from Item table where unit_price is greater than 20000.00. 
SELECT *
FROM item
WHERE itm_unit_price > 20000.00;

-- List the details of items from IT10 to IT19
SELECT *
FROM item
WHERE itm_code BETWEEN 'IT10' AND 'IT19';

-- List the item descriptions contain with er
SELECT *
FROM item
WHERE itm_description LIKE '%er%';

-- Select the details of items with a item code between "IT10" and "IT19" from the table item.
SELECT *
FROM item
WHERE itm_code NOT BETWEEN 'IT10' AND 'IT19';

-- Get the item descriptions which are stored in either L01 or L04 locations
SELECT i.itm_description
FROM item AS i,store AS s
WHERE i.itm_code = s.st_item_code AND s.st_location_code IN ('L04','L01');

-- Retrieve itm_description and itm_unit_price of items which are stored at the locations of L01 or L02 according to the descending order of the unit price.
SELECT i.itm_description,i.itm_unit_price
FROM item AS i,store AS s
WHERE i.itm_code=s.st_item_code AND s.st_location_code IN ('L01','L02')
ORDER BY i.itm_unit_price DESC;

-- Retrieve itm_description, itm_unit_price and loc_code of items which are stored at the locations of L01 or L02 according to the descending order of the location code.
SELECT i.itm_description,i.itm_unit_price
FROM item AS i,store AS s
WHERE i.itm_code=s.st_item_code AND s.st_location_code IN ('L01','L02')
ORDER BY s.st_location_code DESC;

-- How many locations are available in the location table?
SELECT count(loc_code)
FROM location;

-- How many television sets have been sold by “Max Electronics” agency.
SELECT SUM(sa_sals_qty)
FROM sales
WHERE sa_item_code= 'IT10';
SELECT * FROM sales;
-- How many television sets have been sold by the Galle branch?
SELECT SUM(sa_sals_qty)
FROM sales
WHERE sa_item_code= 'IT10' AND sa_location_code='L03';

-- What is the largest unit price of the itm_unit_price column?
SELECT MAX(itm_unit_price)
FROM item;

-- Find the description of the item which has the largest unit price.
SELECT itm_description
FROM item
WHERE itm_unit_price=(SELECT max(itm_unit_price) FROM item);

-- List the descriptions of items sold within the month may 2011.
SELECT i.itm_description
FROM item AS i,sales AS sa
WHERE i.itm_code = sa.sa_item_code AND sa_date_of_sale LIKE '2016-05%';

SELECT i.itm_description
FROM item AS i,sales AS sa
WHERE i.itm_code = sa.sa_item_code AND EXTRACT(YEAR FROM sa_date_of_sale)='2016' AND EXTRACT(MONTH FROM sa_date_of_sale)='5';

-- One customer is going to by 5 computers with 10% discount. How many rupees have to be paid by the customer for this deal?
SELECT itm_code,itm_description,itm_unit_price,ROUND((itm_unit_price*5*(90/100)),2) AS "Amount"
FROM item
WHERE itm_code='IT11';

-- Get the total price of the computer stock, stored at the L01 location.
SELECT (i.itm_unit_price*s.st_qty) AS 'Total Price'
FROM item AS i , store AS s
WHERE i.itm_code=s.st_item_code AND s.st_location_code='L01' AND s.st_item_code='IT11';

-- Get the total price of the television stock, stored at the Colombo branch.
SELECT i.itm_description,ROUND((i.itm_unit_price*s.st_qty),2) AS 'Total Price of stock'
FROM item AS i,store AS s,location AS l
WHERE i.itm_description='television' AND s.st_location_code=l.loc_code AND s.st_item_code=i.itm_code AND l.loc_name='Colombo';

-- Change the location address of Galle branch as “Karapitiya”.
UPDATE location
SET loc_address="Karapitiya"
WHERE loc_code='L03';

SELECT * from location;

-- . Increase the unit prices by 500.00 rupees for the televisions and computers in the item table.
UPDATE item
SET itm_unit_price=itm_unit_price+500
WHERE itm_code IN ('IT10','IT11');

-- Get the item codes and the item names which supplier is known. 
SELECT itm_code,itm_description
FROM item
WHERE itm_supplier IS NOT NULL;

-- Get the descriptions, locations and quantities stored at all branches which are supplied by unknown suppliers
SELECT i.itm_description,l.loc_name,s.st_qty
FROM item AS i,store AS s,location AS l
WHERE i.itm_code=s.st_item_code AND l.loc_code=s.st_location_code AND i.itm_supplier IS NULL;

-- List the number of items stored at each location.(Display the Location code vs number of items).
SELECT st_location_code,SUM(st_qty) AS 'Number of items'
FROM store
GROUP by st_location_code;

-- List the number of items categories stored at each location. (Display the Location name vs number of items).
SELECT l.loc_name,count(s.st_item_code) AS 'Number of item Catagories',sum(s.st_qty) AS 'Number of items'
FROM location AS l,store AS s
WHERE l.loc_code=s.st_location_code
GROUP BY s.st_location_code;

-- List the item description and the total quantity for that description stored at all locations.
-- (Display the description vs total quantity for that description).
SELECT i.itm_description AS 'Item Name' , SUM(st_qty) AS 'Total No of Items'
FROM item AS i,store AS s
WHERE i.itm_code=s.st_item_code
GROUP BY i.itm_description;

-- . List the item description, total stored quantity, unit price and the value of the quantity for each item stored in store table. (value=unit price*quantity)
SELECT i.itm_description,sum(s.st_qty),i.itm_unit_price,((sum(st_qty))*i.itm_unit_price) AS 'Value of Quantity'
FROM item AS i,store AS s
WHERE i.itm_code = s.st_item_code
GROUP BY i.itm_code;