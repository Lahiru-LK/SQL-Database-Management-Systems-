CREATE DATABASE practical09;

USE practical09;


-- create subject table--------------------
CREATE TABLE IF NOT EXISTS subject(
  subject_id VARCHAR(10) NOT NULL,
  name VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (subject_id)
  ); 
  
DESC  subject;

INSERT INTO subject (subject_id, name)
 VALUES
('S001',  'Translations'),
('S002', 'Novels'),
('S003', 'History')
;
SELECT * FROM subject;

-- author table created-----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS author (
  author_id VARCHAR(10) NOT NULL,
  subject_id VARCHAR(20) DEFAULT NULL,
  name VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (author_id),
  FOREIGN KEY(subject_id) REFERENCES subject(subject_id)
  );
  
INSERT INTO author (author_id, subject_id, name) 
VALUES
('A001', 'S001', 'ureka Nilmini'),
('A002', 'S002', 'Mohan Raj'),
('A003', 'S002', 'J.B. Dissanayaka'),
('A004', 'S003', 'Sunil Santha'),
('A005', 'S001', 'Mahinda Prasad')
;
SELECT * FROM author;

-- book table*-----------------------------------------------------

CREATE TABLE IF NOT EXISTS book (
  book_id VARCHAR(10) NOT NULL,
  author_id VARCHAR(20) NOT NULL,
  edition_number VARCHAR(20) NOT NULL,
  name VARCHAR(20) DEFAULT NULL,
  year INT DEFAULT NULL,
  PRIMARY KEY (book_id,edition_number),
  FOREIGN KEY(author_id) REFERENCES author(author_id)
  );

INSERT INTO book (Book_id, Author_id,Edition_number, name, year) 
VALUES
('B001', 'A001','1', 'Sarasa Wasanthaya',2020),
('B002', 'A002','1', 'Aradhana', 2011),
('B003', 'A004','1', 'Thiththa Kahata', 2015),
('B004', 'A005','1', 'Puhul Hora', 2015),
('B005', 'A003','1', 'Manikkawatha',  2002)
;

CREATE TABLE IF NOT EXISTS cover(
  cover_id VARCHAR(10) NOT NULL,
  book_id VARCHAR(10) DEFAULT NULL,
  cover_details VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (cover_id),
  FOREIGN KEY(book_id) REFERENCES book(book_id)
  );
  
  
INSERT INTO cover(cover_id,book_id,cover_details)
 VALUES
('C001','B001', 'Sarasa Wasanthaya'),
('C002', 'B003', 'Thiththa Kahata'),
('C003', 'B002', 'Aradhana'),
('C004', 'B004', 'Puhul Hora'),
('C005', 'B005', 'Manikkawatha')
;

-- Quation a -------------------------------------------------------------------------------------------------------------------

SELECT name FROM subject;

-- Quation b-------------------------------------------------------------------------------------------------------------------

SELECT name FROM author;

-- Quation c-------------------------------------------------------------------------------------------------------------------

SELECT name FROM book;

-- Quation d-------------------------------------------------------------------------------------------------------------------

SELECT name,year FROM book ORDER BY name ASC;

-- Quation e-------------------------------------------------------------------------------------------------------------------

SELECT book.name
FROM book
INNER JOIN author ON author.author_id=book.author_id 
INNER JOIN subject ON subject.subject_id=author.subject_id
WHERE subject.name='Novels';

-- Quation f-------------------------------------------------------------------------------------------------------------------

SELECT subject.name
FROM subject
INNER JOIN author ON author.subject_id=subject.subject_id
INNER JOIN book ON book.author_id=author.author_id
WHERE book.year=2020;

-- Quation g-------------------------------------------------------------------------------------------------------------------

SELECT * FROM book
INNER JOIN author ON author.author_id=book.author_id
WHERE author.name='ureka Nilmini';

-- Quation h-------------------------------------------------------------------------------------------------------------------

SELECT count(Edition_number)
FROM book
INNER JOIN author ON author.author_id=book.author_id
INNER JOIN subject ON subject.subject_id=author.subject_id
WHERE subject.name='History';


-- Quation i-------------------------------------------------------------------------------------------------------------------

SELECT max(Edition_number)
FROM book
INNER JOIN author ON author.author_id=book.author_id 
INNER JOIN subject ON subject.subject_id=author.subject_id
WHERE subject.name='Translations';

-- Quation j-------------------------------------------------------------------------------------------------------------------

SELECT author.name
FROM author
INNER JOIN subject ON subject.subject_id=author.subject_id
WHERE subject.name='Novels';

-- Quation k-------------------------------------------------------------------------------------------------------------------

-- Quation L-------------------------------------------------------------------------------------------------------------------

SELECT name
FROM book
WHERE Edition_number>1;

-- Quation m------------------------------------------------------------------------------------------------------------------

