CREATE DATABASE DEPARTMENTAL_SALES;

USE DEPARTMENTAL_SALES;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);


CREATE TABLE sales_records (
    sale_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    sale_amount DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


INSERT INTO departments (department_id, department_name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen');


INSERT INTO sales_records (sale_id, employee_name, department_id, sale_amount, sale_date) VALUES
(101, 'Alice', 1, 1500.00, '2026-01-15'),
(102, 'Bob',   1, 800.00,  '2026-01-16'),
(103, 'Charlie',1, 2500.00, '2026-01-17'),
(104, 'Alice', 1, 1200.00, '2026-02-01'),
(105, 'David', 2, 300.00,  '2026-01-15'),
(106, 'Eva',   2, 750.00,  '2026-01-20'),
(107, 'David', 2, 450.00,  '2026-02-10'),
(108, 'Frank', 3, 2100.00, '2026-01-18'),
(109, 'Grace', 3, 1300.00, '2026-01-25'),
(110, 'Frank', 3, 950.00,  '2026-02-05');

select * FROM SALES_RECORDS;

select * FROM DEPARTMENTS;

## Windows Function:

select *,
rank() over(order by sale_amount desc) as ranking
from sales_records;

select *,
rank() over(partition by date(sale_date) order by sale_date desc) as datewise_partition
from sales_records;

select *,
sum(sale_amount) over(partition by sale_id order by sale_date) as sales_per_employee
from sales_records;

select *,
lag(sale_amount) over(partition by employee_name order by sale_date) as prev_sale
from sales_records;

select *,
lead(sale_amount) over(partition by employee_name order by sale_date) as prev_sale
from sales_records;

select *,
lag(sale_amount) over(partition by department_id order by sale_date) as prev_sale
from sales_records;

select *,
lead(sale_amount) over(partition by department_id order by sale_date) as prev_sale
from sales_records;

select *,
lag(sale_amount) over(order by sale_date) as previous_sale
from sales_records;

select *,
lead(sale_amount) over(order by sale_date) as previous_sale
from sales_records;

select *,
lead(sale_amount) over(order by sale_date) as next_sale
from sales_records;


## Stored Procedures:

delimiter $$
create procedure sales_details()
begin
	select * from sales_records;
end $$

delimiter ;

call sales_details();

delimiter $$
create procedure employee_sale_records(in sales_id int)
begin
	select * from sales_records
    where sale_id = sales_id;
end $$
delimiter ;

call employee_sale_records(106);


delimiter $$
create procedure total_department_sales(in dept_id int)
begin
    select
        department_id,
        sum(sale_amount) as total_sales
    from sales_records
    where department_id = dept_id
    group by department_id;
end $$
delimiter ;

call total_department_sales(1);


