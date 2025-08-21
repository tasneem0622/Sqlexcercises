-- using CREATE command

Create database customer_data;

use customer_data;

create table customers(
customer_id int primary key,
name varchar(100),
email varchar(100));

-- using ALTER command
 
 Alter table customers
 ADD Phone_number INT;
 
 -- using DROP command
 
 Drop Table Customers;
 
-- using TRUNCATE command

Truncate table customers;
