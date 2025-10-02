--Easy-Level Tasks
--1
select O.OrderID, c.FirstName, o.OrderDate from Orders O
join Customers C on O.CustomerID = c.CustomerID
where year(O.OrderDate) > 2022;
--2
select e.Name, d.DepartmentName from Employees E
join Departments D on e.DepartmentID = d.DepartmentID
where d.DepartmentName in ('Sales', 'Marketing');
--3
select d.DepartmentName, max(e.Salary) as maxsalary from Employees E 
join Departments D on E.DepartmentID = D.DepartmentID
group by d.DepartmentName;
--4
select c.FirstName, o.OrderID, o.OrderDate from Customers C
join Orders O on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 2023 and c.Country = 'usa'; 
--5
select c.FirstName, COUNT(o.OrderID) as TotalOrders from Orders O 
join Customers C on o.CustomerID = c.CustomerID
group by c.FirstName;
--6
select p.ProductName, s.SupplierName from Products P
join Suppliers S on P.SupplierID = S.SupplierID
where s.SupplierName in ('Clothing Mart', 'Gadget Supplies')
--7
select c.FirstName, max(o.OrderDate) as MostRecentOrderDate from Customers C 
join Orders O on c.CustomerID = c.CustomerID
group by c.FirstName;
--Medium-Level Tasks
--8
select c.FirstName, sum(o.TotalAmount) as OrderTotal from Customers C 
join Orders O on C.CustomerID = O.CustomerID
group by c.FirstName, o.TotalAmount
having o.TotalAmount > 500
--9
select p.ProductName, s.SaleDate, s.SaleAmount from Products P
join Sales S on P.ProductID = S.ProductID
where s.SaleAmount > 400 and year(s.SaleDate) = 2022; 
--10
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount from Products P 
join Sales S on p.ProductID = s.ProductID
group by p.ProductName;
--11
select e.Name, d.DepartmentName, e.Salary from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where d.DepartmentName = 'HR' and e.Salary > 60000;
--12
select p.ProductName, s.SaleDate, p.StockQuantity from Products P 
join Sales S on P.ProductID = S.ProductID
where year(s.SaleDate) = 2023 and p.StockQuantity > 100;
--13
select E.Name, D.DepartmentName, E.HireDate from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where D.DepartmentName = 'Sales' and year(E.HireDate) > 2020;
-- Hard-Level Tasks
-- 14
select c.FirstName, o.OrderID, c.Address, o.OrderDate from Customers C 
join Orders O on C.CustomerID = O.CustomerID
where c.Country = 'usa' and Address like '4%';
--15
select p.ProductName, p.Category, s.SaleAmount from Products P
join Sales S on P.ProductID = S.ProductID
where p.Category = 1 and s.SaleAmount > 350;
--16
select c.CategoryName, COUNT(p.ProductID) as ProductCount from Products P
join Categories C on p.ProductID = C.CategoryID
group by c.CategoryName;
--17
select c.FirstName, c.City, o.OrderID, o.TotalAmount from Customers C
join Orders O on C.CustomerID = O.CustomerID
where city = 'los angeles' and o.TotalAmount > 300;
--18
select e.Name, d.DepartmentName from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where d.DepartmentName in ('HR', 'Finance')  or (
       (LEN(e.Name)
        - LEN(REPLACE(LOWER(e.Name), 'a', ''))
        - LEN(REPLACE(LOWER(e.Name), 'e', ''))
        - LEN(REPLACE(LOWER(e.Name), 'i', ''))
        - LEN(REPLACE(LOWER(e.Name), 'o', ''))
        - LEN(REPLACE(LOWER(e.Name), 'u', ''))
       ) >= 4
   ); 
--19
select e.Name, d.DepartmentName, e.Salary from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where d.DepartmentName in ('Sales', 'Marketing') and e.Salary > 60000;
