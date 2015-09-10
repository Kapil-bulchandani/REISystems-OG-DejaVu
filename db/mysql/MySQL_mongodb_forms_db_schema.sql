DROP DATABASE IF EXISTS mongodb_forms;

CREATE DATABASE mongodb_forms;

USE mongodb_forms;

create table immi_i140(
a_number BIGINT,
first_name varchar(40),
middle_name varchar(40),
last_name varchar(40),
date_of_birth varchar(40)
);

load data local infile '/home/ec2-user/MySQL/applicant_data.csv' into table immi_i140  COLUMNS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\n' ;


GRANT ALL ON mongodb_forms.* TO 'mongouser'@'%' identified by 'password';
GRANT ALL ON mongodb_forms.* TO 'mongouser'@'localhost' identified by 'password';

