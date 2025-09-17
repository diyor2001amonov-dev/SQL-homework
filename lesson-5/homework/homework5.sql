--Easy-Level 
--1
select ProductName as Name 
from Products;
--2
select * 
from Customers as Client;
--3
select ProductName 
from Products
union 
select  ProductName 
from Products_Discounted ;
--4
select * 
from Products
intersect 
select  * 
from Products_Discounted;
--5
select distinct FirstName, Country
from Customers;
--6
select *, 
CASE
	when Price > 1000 then 'High' 
	when Price <= 1000 then 'Low' 
	end as PriceText
	from Products;
--7
select *, 
iif (StockQuantity > 100, 'Yes', 'No') as javob
from  Products_Discounted;
--Medium-Level 
--8
select ProductName 
from Products
union 
select  ProductName 
from Products_Discounted;
--9
select * 
from Products
except
select  * 
from Products_Discounted;
--10
select *, 
iif (Price > 1000, 'Expensive', 'Affordable') as javob
from  Products;
--11
select * 
from Employees 
where Age < 25 or Salary > 60000;
--12
update Employees
set Salary = Salary * 1.10
where DepartmentName = 'HR'
or EmployeeID = 5;
--Hard-Level
--13
select *, 
CASE
	when SaleAmount > 500 then 'Top Tier' 
	when SaleAmount between 200 and 500 then 'Mid Tier' 
	else 'Low Tier'
	end as SaleText
	from Sales;
--14
select CustomerID 
from Orders
except
select  CustomerID  
from Sales;
--15
select customerid, quantity, 
CASE
	when quantity = 1 then '3%' 
	when quantity  between 1 and 3 then '5%' 
	else '7%'
	end as discountPercentage
	from Orders;


