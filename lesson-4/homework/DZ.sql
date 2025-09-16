--Easy-Level
--1
select top 5 *
from employees;
--2
select distinct Category
from Products;
--3
select * from Products 
where Price > 100;
--4 
select * from 
Customers where 
FirstName like 'A%';
--5
select * from Products
order by Price ASC;
--6
select * from Employees
where Salary >= 60000
	and DepartmentName = 'HR';
--7
select EmpID,
	isnull(Email, 'noemail@example.com') as email
from Employees;
--8
select * 
from Products 
where Price between 50 and 100;
--9
select distinct Category, ProductName
from Products;
--10
select distinct Category, ProductName
from Products
order by ProductName DESC;
--Medium-Level
--11
select top 10 * 
from Products 
order by Price DESC;
--12
select EmpID,
	coalesce(FirstName, LastName) as FullName
from Employees;
--13
select distinct Categoty, Price
from products;
--14
select * 
from Employees 
where (age between 30 and 40) or DepartmentName = 'Marketing';
--15
select * 
from Employees
order by Salary DESC
offset 10 row fetch next 10 rows only;
--16
select * 
from Products
where Price <= 1000
and StockQuantity > 50 
order by StockQuantity ASC;
--17
select * 
from Products
where ProductName like = 'e%';
--18
select *
from Employees
where DepartmentName in ('HR', 'IT', 'Finance');
--19
select * 
from Customers
order by City ASC, PortalCode DESC;
--Hard-Level
--20
SELECT TOP (5)
       ProductID,
       ProductName,
       Price
FROM Products
ORDER BY Price DESC;
--21
select 
CONCAT (FirstName, ' ', LastName) as FullName
from Employees;
--22
select distinct
Category,
ProductName,
Price
from Products
where Price > 50 ;
--23
select 
ProductName,
Category,
Price
from Products
where Price < 0.1 * (select AVG(Price) from Products);
--24
select * from Employees
where Age < 30 and DepartmentName in ('HR', 'IT');
--25
select * from Customers
where Email like '%gmail.com';
--26
select * from Employees
where salary > all (
select salary
from Employees
where DepartmentName = 'sales'
);
select * from Orders 
where OrderDate
between DATEADD(day, -180, getdate()) and getdate();

