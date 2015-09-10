DROP DATABASE IF EXISTS dejavu_application;

CREATE DATABASE dejavu_application;

USE dejavu_application;


CREATE TABLE users (
user_ref int NOT NULL AUTO_INCREMENT,
first_name varchar(100),
last_name varchar(100),
title varchar(255),
PRIMARY KEY (user_ref)
) ENGINE=InnoDB ;


CREATE TABLE operations (
operation_ref int NOT NULL AUTO_INCREMENT,
name varchar(255),
PRIMARY KEY (operation_ref)
) ENGINE=InnoDB ;

CREATE TABLE centers (
center_ref int NOT NULL AUTO_INCREMENT,
name varchar(255),
PRIMARY KEY (center_ref)
) ENGINE=InnoDB ;

CREATE TABLE workflow (
id int NOT NULL AUTO_INCREMENT,
ref_number varchar(100),
entry_datetime datetime,
center_ref int,
operation_ref int,
user_ref int,
start_datetime datetime,
end_datetime datetime,
PRIMARY KEY (id) ,
FOREIGN KEY (center_ref) 
        REFERENCES centers(center_ref)
        ON DELETE CASCADE,
FOREIGN KEY (user_ref) 
        REFERENCES users(user_ref)
        ON DELETE CASCADE,
FOREIGN KEY (operation_ref) 
        REFERENCES operations(operation_ref)
        ON DELETE CASCADE		
) ENGINE=InnoDB ;


-- just to create dummy data and not for application

create table ref_numbers (
id int NOT NULL AUTO_INCREMENT,
ref_number varchar(100),
PRIMARY KEY (id) 
) ENGINE=InnoDB ;


INSERT INTO centers(name) values('California Service Center'),('Nebraska Service Center'),('Texas Service Center'),('Vermont Service Center');
INSERT INTO operations(name) values('Submit'),('Review'),('Approve'),('Reject'),('Sent'),('Request Additional Documents');
INSERT INTO users(first_name,last_name,title) values('user1','ln1','Submitter'),('user2','ln2','Submitter'),('user3','ln3','Submitter'), ('user4','ln4','Reviewer'),('user5','ln5','Reviewer'),('user6','ln6','Reviewer'),
('user7','ln7','Certifier'), ('user8','ln8','Certifier'), ('user9','ln9','Certifier'),
('user10','ln10','Dispatcher');

INSERT INTO ref_numbers(ref_number) values('REF123456780'),('REF123456781'),('REF123456782'),('REF123456783'),('REF123456784'),('REF123456785'),('REF123456786'),('REF123456787'),('REF123456788'),('REF123456789'),('REF123456790'),('REF123456791'),('REF123456792'),('REF123456793'),('REF123456794'),('REF123456795'),('REF123456796'),('REF123456797'),('REF123456798'),('REF123456799'),('REF123456800'),('REF123456801'),('REF123456802'), ('REF123456803'),('REF123456804'),('REF123456805'),('REF123456806'),('REF123456807'),('REF123456808'),('REF123456809'),('REF123456810'),('REF123456811'),('REF123456812'),('REF123456813'),('REF123456814');


-- For Submit Operation

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 20 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 20 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id <=9 AND b.name = 'California Service Center' AND c.name = 'Submit' AND d.first_name = 'user1';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 25 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 25 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >9 AND a.id <= 18 AND b.name = 'Nebraska Service Center' AND c.name = 'Submit' AND d.first_name = 'user2';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 30 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 30 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >18 AND a.id <= 27 AND b.name = 'Texas Service Center' AND c.name = 'Submit' AND d.first_name = 'user3';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 30 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 30 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >27 AND b.name = 'Vermont Service Center' AND c.name = 'Submit' AND d.first_name = 'user1';


-- For Review Status

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 15 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 14 DAY, now() - INTERVAL 14 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id <=9 AND b.name = 'California Service Center' AND c.name = 'Review' AND d.first_name = 'user4';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 20 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 21 DAY, now() - INTERVAL 21 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >9 AND a.id <= 18 AND b.name = 'Nebraska Service Center' AND c.name = 'Review' AND d.first_name = 'user5';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 25 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 24 DAY, now() - INTERVAL 24 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >18 AND a.id <= 27 AND b.name = 'Texas Service Center' AND c.name = 'Review' AND d.first_name = 'user6';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 25 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 24 DAY, now() - INTERVAL 24 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >27 AND b.name = 'Vermont Service Center' AND c.name = 'Review' AND d.first_name = 'user4';


-- For Approve, reject, "Request Additional Document" Oprations

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 10 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 10 DAY, now() - INTERVAL 8 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id <=9 AND b.name = 'California Service Center' AND c.name = 'Approve' AND d.first_name = 'user7';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 15 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 15 DAY, now() - INTERVAL 13 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >9 AND a.id <= 18 AND b.name = 'Nebraska Service Center' AND c.name = 'Reject' AND d.first_name = 'user8';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 20 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 20 DAY, now() - INTERVAL 18 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >18 AND a.id <= 27 AND b.name = 'Texas Service Center' AND c.name = 'Approve' AND d.first_name = 'user9';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 20 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 20 DAY, now() - INTERVAL 18 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >27 AND a.id <= 30   AND b.name = 'Vermont Service Center' AND c.name = 'Approve' AND d.first_name = 'user7';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 20 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 20 DAY, now() - INTERVAL 18 DAY
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >30  AND b.name = 'Vermont Service Center' AND c.name = 'Request Additional Documents' AND d.first_name = 'user8';

-- For Sent Operation


INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 5 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 5 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id <=9 AND b.name = 'California Service Center' AND c.name = 'Sent' AND d.first_name = 'user10';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 10 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 10 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >9 AND a.id <= 18 AND b.name = 'Nebraska Service Center' AND c.name = 'Sent' AND d.first_name = 'user10';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 15 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 15 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >18 AND a.id <= 27 AND b.name = 'Texas Service Center' AND c.name = 'Sent' AND d.first_name = 'user10';

INSERT INTO workflow(ref_number, entry_datetime, center_ref, operation_ref, user_ref, start_datetime, end_datetime) 
SELECT a.ref_number, now() - INTERVAL 15 DAY , b.center_ref, c.operation_ref, d.user_ref, now() - INTERVAL 15 DAY, NULL
FROM ref_numbers a, centers b , operations c, users d
WHERE a.id >27 AND b.name = 'Vermont Service Center' AND c.name = 'Sent' AND d.first_name = 'user10';


DROP USER 'appuser';
DROP USER 'appuser'@'localhost';

create user 'appuser' identified by 'password';
create user 'appuser'@'localhost' identified by 'password';
GRANT ALL ON dejavu_application.* TO 'appuser'@'%';
GRANT ALL ON dejavu_application.* TO 'appuser'@'localhost';
