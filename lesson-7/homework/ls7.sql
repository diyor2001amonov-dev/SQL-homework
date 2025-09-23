-- Easy-Level Tasks 
--1
select min(price) from Products;
--2
select max(Salary) from Employees;
--3
select count(CustomerID) from Customers;
--4
select count(distinct Category) from Products;
--5
select sum(SaleAmount) from Sales 
where ProductID = 7;
--6
select avg(age) from Employees;
--7
select count(EmployeeID) , DepartmentName from Employees
group by DepartmentName;
--8
select Category, min(Price), max(Price) from Products
group by Category;
--9
select CustomerID, sum(SaleAmount) from Sales
group by CustomerID;
--10
select DepartmentName, count(EmployeeID) from Employees
Group by DepartmentName
having count(EmployeeID) > 5;
--  Medium-Level Tasks 
--11
select sum (SaleAmount) as [SumAmount],
	avg (SaleAmount) as [AvgAnount]
	from Sales
Group by ProductID;
--12
select count(EmployeeID)
from Employees
where DepartmentName = 'HR'
--13
select DepartmentName, max(Salary) as [MaxSalary],
min(Salary) as [MinSalary]
from Employees
group by DepartmentName;
-- 14
select DepartmentName, avg(Salary) as [avgSalary]
from Employees
group by DepartmentName;
--15
select DepartmentName,
	count(EmployeeID), 
	avg(salary)
	from Employees
group by DepartmentName;
--16
select Category, 
avg(Price)
from Products
group by Category
having avg(Price) > 400;
--17
select SaleDate, sum(SaleAmount) as [CountSale]
from Sales
group by SaleDate
order by SaleDate;
--18
select CustomerID, count(Quantity)
from orders
group by CustomerID
having count(quantity) >= 3;
--19
select DepartmentName, 
	avg(Salary)
	from Employees
group by DepartmentName
having avg(Salary) > 60000;
-- Hard-Level Tasks 
--20
select Category, 
	avg(Price)
	from Products
group by Category
having avg(Price) > 150;
--21
select CustomerID, 
	sum(SaleAmount)
	from Sales
group by CustomerID
having sum(SaleAmount) > 1500;
--22
select DepartmentName, 
	sum(Salary), 
	avg(Salary)
	from Employees
group by DepartmentName
having avg(Salary) > 65000;
--23
select custid, 
sum(case when freight > 50 then freight else 0 end),
min(freight) 
from tsql2012.sales.orders
group by custid
order by custid;
--24
select year(orderdate),
month(orderdate),
sum(freight),
count(orderid)
from 
sales.orders
group by year(orderdate), month(orderdate)
having count(distinct orderid) >= 2
order by  year(orderdate), month(orderdate);
--25
select year(orderdate),
min(freight),
max(freight)
from 
sales.orders
group by year(orderdate)
order by  year(orderdate);
