CREATE DATABASE IF NOT EXISTS sales;
USE sales;



CREATE TABLE sales
(
purchase_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10)
);
DROP TABLE sales;

CREATE TABLE sales
(
purchase_number INT NOT NULL AUTO_INCREMENT,
data_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10),
PRIMARY KEY (purchase_number)
);

ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

CREATE TABLE customers (
customer_id int,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address varchar(255),
number_of_complaints int
);
DROP TABLE customers;

CREATE TABLE customers                                                              
(   customer_id INT AUTO_INCREMENT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),  
    number_of_complaints int,  
primary key (customer_id)  
);  

ALTER TABLE customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO customers(first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

INSERT INTO customers (first_name, last_name, gender)
VALUES ('Peter', 'Figaro','M')

SELECT * FROM customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

CREATE TABLE companies (
company_id varchar(255),
company_name varchar(255),
headquarters_phone_number int(12),
primary key(company_id)
);

DROP TABLE companies;

-- default
CREATE TABLE companies (
company_id INT auto_increment,
company_name varchar(255) DEFAULT 'X',
headquarters_phone_number varchar(255),
primary key(company_id),
unique key (headquarters_phone_number)
);

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;

INSERT INTO companies (headquarters_phone_number, company_name)
VALUES ('1234567', 'JOJO')

SELECT * FROM companies;

CREATE TABLE items (
item_code varchar(255),
item varchar(255),
unit_price NUMERIC(10,2),
company_id varchar(255),
primary key(item_code)
);


