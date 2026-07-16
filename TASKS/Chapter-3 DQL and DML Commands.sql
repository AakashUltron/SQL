CREATE DATABASE SALES_MANAGEMENT;

USE SALES_MANAGEMENT;

create table ProductLines(
productLine varchar(50) primary key,
textDescription varchar(4000) default null,
htmlDescription mediumtext ,
image blob 
);

create table Products(
productCode varchar(15) primary key,
productName varchar(70) not null,
productLine varchar(50),
productScale varchar(70),
productVendor varchar(70),
productDescription text,
quantityInStock int ,
buyPrice decimal(10,2),
MSRP decimal(10,2),
foreign key(ProductLine) references ProductLines(ProductLine)
);

create table Offices(
officeCode varchar(10) primary key,
city varchar(50),
phone varchar(20),
addressLine1 varchar(100),
addressLine2 varchar(100),
state varchar(50),
country varchar(50),
postalCode varchar(20),
territory varchar(20)
);

create table Employees(
employeeNumber int primary key,
lastName varchar(50),
firstName varchar(50),
extension varchar(10),
email varchar(100),
officeCode varchar(10),
reportsTo int,
jobTitle varchar(50),
foreign key (officeCode) references Offices(officeCode),
foreign key (reportsTo) references Employees(employeeNumber)
);

create table Customers(
customerNumber int primary key,
customerName varchar(50),
contactLastName varchar(50),
contactFirstName varchar(50),
phone varchar(20),
addressLine1 varchar(100),
addressLine2 varchar(100),
city varchar(50),
state varchar(50),
postalCode varchar(15),
country varchar(50),
salesRepEmployeeNumber int,
creditLimit decimal(10,2),
foreign key(salesRepEmployeeNumber) references Employees(employeeNumber)
);

create table Orders(
orderNumber INT primary key,
orderDate date,
requiredDate date,
shippedDate date,
orderStatus varchar(20),
comments text,
customerNumber int,
foreign key(customerNumber) references Customers(customerNumber)
);

create table OrderDetails(
orderNumber int,
productCode varchar(15),
quantityOrdered int,
priceEach decimal(10,2),
orderLineNumber smallint,
primary key (orderNumber, productCode),
foreign key(productCode) references Products(productCode),
foreign key(orderNumber) references Orders(orderNumber)
);

create table Payments(
customerNumber int,
checkNumber varchar(50),
paymentDate date,
amount decimal(10,2),
primary key (customerNumber, checkNumber),
foreign key(customerNumber) references Customers(customerNumber)
);

insert into Offices(officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory)
values
('1', 'Chennai', '+91-44-12345678', 'T Nagar', NULL, 'Tamil Nadu', 'India', '600017', 'APAC'),
('2', 'Bangalore', '+91-80-87654321', 'MG Road', NULL, 'Karnataka', 'India', '560001', 'APAC');

insert into Employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
values
(1002, 'Kumar', 'Arun', 'x101', 'arun.kumar@classic.com', '1', NULL, 'Sales Manager'),
(1056, 'Ravi', 'Suresh', 'x102', 'suresh.ravi@classic.com', '1', 1002, 'Sales Rep'),
(1076, 'Sharma', 'Neha', 'x103', 'neha.sharma@classic.com', '2', 1002, 'Sales Rep');

insert into Customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit)
values
(2001, 'ABC Traders', 'Rao', 'Vikram', '+91-9876543210','Anna Nagar', NULL, 'Chennai', 'Tamil Nadu', '600040', 'India', 1056, 150000),
(2002, 'XYZ Electronics', 'Patel', 'Amit', '+91-9123456789', 'Indiranagar', NULL, 'Bangalore', 'Karnataka', '560038', 'India', 1076, 200000);

insert into ProductLines(productLine,textDescription,htmlDescription,image)
values
('Classic Cars', 'Vintage and classic model cars', NULL, NULL),
('Motorcycles', 'Racing and sports bikes', NULL, NULL);

insert into Products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP)
values
('S10_1678', '1969 Harley Davidson', 'Motorcycles', '1:10','Min Lin Diecast','Classic Harley Davidson bike model', 100, 4800, 6500),
('S12_1099', '1968 Ford Mustang', 'Classic Cars', '1:12','Autoart Studio', 'Classic Ford Mustang model', 50, 9500, 12000);

insert into Orders(orderNumber,orderDate,requiredDate,shippedDate,orderStatus,comments,customerNumber)
values
(30001, '2026-01-10', '2026-01-15', '2026-01-13', 'Shipped', 'Delivered on time', 2001),
(30002, '2026-01-12', '2026-01-18', NULL, 'In Process', NULL, 2002);

insert into OrderDetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber)
values
(30001, 'S10_1678', 2, 6500, 1),
(30002, 'S12_1099', 1, 12000, 1);

insert into Payments(customerNumber,checkNumber,paymentDate,amount)
values
(2001, 'CHK1001', '2026-01-16', 13000),
(2002, 'CHK1002', '2026-01-17', 12000);

SELECT * FROM ProductLines;

SELECT customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit
from Customers 
where creditLimit > 190000;

SELECT customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit
from Customers 
where city = 'Chennai';


SELECT productCode,productName,quantityInStock
from Products
where quantityInStock < 100;


UPDATE Customers
SET creditLimit = 75000
WHERE customerNumber = 103; 

ALTER table Employees ADD column employeePhoneNo varchar (10);

UPDATE Employees
SET employeePhoneNo = '9999999999'
WHERE employeeNumber = 1002;

UPDATE Employees
SET employeePhoneNo = '8888888888'
WHERE employeeNumber = 1056;

UPDATE Employees
SET employeePhoneNo = '7777777777'
WHERE employeeNumber = 1076;

select * from employees;

insert into Products
(productCode, productName, productLine, productScale,
productVendor, productDescription, quantityInStock,
buyPrice, MSRP)
values
('S18_2000','Yamaha R1','Motorcycles','1:18','Autoart Studio','Sports bike model',75,7000,9500);


update Customers
set creditLimit = 250000
where customerNumber = 2001;

delete FROM OrderDetails
where orderNumber = 30002;

delete from Orders
WHERE orderNumber = 30002;

select * FROM OrderDetails;



