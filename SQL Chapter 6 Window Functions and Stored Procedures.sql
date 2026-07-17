CREATE DATABASE sales_datadb;

USE sales_datadb;

CREATE TABLE sales_data (
    transaction_id INT PRIMARY KEY,
    employee_id INT,
    month VARCHAR(7),
    sales_amount DECIMAL(10, 2)
);

INSERT INTO sales_data (transaction_id, employee_id, month, sales_amount) VALUES
(1, 101, '2024-01', 500.00),
(2, 102, '2024-01', 600.00),
(3, 101, '2024-02', 450.00),
(4, 103, '2024-02', 700.00),
(5, 102, '2024-02', 650.00),
(6, 101, '2024-03', 550.00),
(7, 103, '2024-03', 800.00),
(8, 102, '2024-03', 700.00),
(9, 104, '2024-03', 300.00);

select * from sales_data;

## Write a query that ranks the sales_amount in descending order from the sales_data table and assigns a rank to each row.

select *,
rank() over (order by sales_amount desc) as rk
from sales_data;

select *,
dense_rank() over (order by sales_amount desc) as rk
from sales_data;

## Write a query that Ranks the sales_amount for each month (partition by month) in descending order from the sales_data.

select *,
dense_rank() over(partition by month order by sales_amount desc) as rk_partition_by_month
from sales_data;

## Write a query that calculates the running total of sales_amount for each employee, order by month from the sales_data table

select *,
sum(sales_amount) over (partition by employee_id order by month) as sales_per_employee
from sales_data;

## Write a query that shows the previous month's sales_amount for each employee from the sales_data table, using LAG() function.

select *,
lag(sales_amount) over (partition by employee_id order by month) as prev_month
from sales_data;

## Write a query that shows the NEXT month's sales_amount for each employee from the sales_data table, using LEAD() function.

select *,
lead(sales_amount) over (partition by employee_id order by month) as next_month
from sales_data;

## STORED PROCEDURES

## SHOW ALL SALES

DELIMITER $$

CREATE PROCEDURE get_all_sales()
BEGIN
    SELECT *
    FROM sales_data;
END $$

DELIMITER ;

call get_all_sales();

## Employee-wise sales

delimiter $$
create procedure get_employee_sale(in emp_id int)
begin
	select *
    from sales_data
    where employee_id = emp_id;
end $$
delimiter ;

call get_employee_sale(103);



