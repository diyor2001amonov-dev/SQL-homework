--Basic-Level Tasks
create table employees (Empid int, Name varchar(50), salary decimal(10,2));

insert into employees values (1, 'Mubinlolo', 12600.00);

insert into employees values (2, 'Toxir aka', 34700.00), (3, 'Jasur', 11.00), (4, 'Rustam', 12.00);

insert into employees 
select 5, 'Aziz', 13454647.00;

update employees set salary = 7000.00
where Empid = 1;

delete from employees 
where Empid = 2;

/*
Delete - qatorlarni shart (where) bo'yicha o'chiradi va jurnalga yozib boradi,
rollback bilan orqaga qaytarsa bo'ladi;

Truncate table - barcha qatorlarni tezroq birdaniga o'chiradi (where yo'q);

Drop Table butun table ni o'chiradi va drop qilgandan so'ng jadval strukturasi yo'qoladi;
*/

alter table employees
alter column Name varchar (100);

alter table employees
add Department varchar(50);

alter table employees
alter column salary float;


create table Departments (DepartmentID int primary key, DepartmentName varchar(50));

truncate table employees;

--Intermediate-Level Tasks

insert into Departments values (1, 'IT'), (2, 'Risk'), (3, 'security'), (4, 'strategy');

update employees 
set Department = 'Management'
where salary > 5000;

alter table employees
drop column department;


exec sp_rename 'dbo.employees', 'StaffMembers';

drop table Departments;

--Advanced-Level Tasks

create table Products (ProductID int primary key, ProductName Varchar(50), Category varchar(50), Price decimal);

alter table products 
add constraint Price_check 
check (price > 0);

alter table products
add StockQuantity int
default 50;

exec sp_rename 'dbo.products.category', 'ProductCategory', 'column';

insert into Products (ProductID, ProductName, ProductCategory, Price) values (1,'apple', 'fruit', 5000.12), 
(2, 'tomato', 'vegetables', 9000.00), 
(3, 'coca-cola', 'beverage', 13000.99),
(4, 'chortoq', 'beverage', 15000.34),
(5, 'egg', 'dairy and eggs', 30000.69);


select *
into Products_Backup
from Products;

exec sp_rename 'dbo.Products', 'Inventory';

alter table Inventory
drop constraint Price_check;

alter table Inventory
alter column Price float;

alter table Inventory
add ProductCode int identity (1000,5);


select * from Inventory;

