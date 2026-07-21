CREATE DATABASE CompanyDB;
USE CompanyDB;


CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);


CREATE TABLE projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


INSERT INTO departments (dept_id, dept_name) 
VALUES 
(10, 'Human Resources'),
(20, 'Engineering'),
(30, 'Marketing'),
(40, 'Sales'),
(50, 'Customer Support'); 


INSERT INTO employees (emp_id, emp_name, dept_id, manager_id)
VALUES 
(1, 'Alice Vance', 10, NULL),  
(2, 'Bob Smith', 20, 1),       
(3, 'Charlie Brown', 20, 2),   
(4, 'Diana Prince', 30, 1),    
(5, 'Evan Wright', NULL, 2);   


INSERT INTO projects (proj_id, proj_name, dept_id)
VALUES 
(101, 'Project Alpha', 20),
(102, 'Project Beta', 20),
(103, 'Project Gamma', 30),
(104, 'Project Delta', 40),
(105, 'Project Omega', NULL);  

select 
	departments.dept_id,
    employees.emp_name
from departments
inner join employees
	on departments.dept_id = employees.dept_id;
    
    
select 
	departments.dept_name,
    employees.emp_name
from employees
inner join departments
	on employees.dept_id = departments.dept_id;
    
select 
	departments.dept_id,
    employees.emp_name
from departments
left join employees
	on departments.dept_id = employees.dept_id;
    
select 
	departments.dept_id,
    employees.emp_name
from departments
right join employees
	on departments.dept_id = employees.dept_id;
    
    
select 
	departments.dept_id,
    employees.emp_name
from departments
left join employees
	on departments.dept_id = employees.dept_id
    
union
    
select 
	departments.dept_id,
    employees.emp_name
from departments
right join employees
	on departments.dept_id = employees.dept_id;
    
select 
    e.emp_name as employee,
    m.emp_name as Manager
from employees e
left join employees m
	on e.manager_id = m.emp_id;
    
select
	employees.emp_name,
    projects.proj_name
from employees
cross join projects;
    
    
    



    



      
