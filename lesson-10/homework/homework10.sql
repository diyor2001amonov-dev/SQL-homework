-- Easy-Level Tasks (10)
--1
select e.Name, e.Salary, d.DepartmentName from Employees E
join Departments D on e.DepartmentID = d.DepartmentID
where Salary > 50000;
--2
select c.FirstName, c.LastName, o.OrderDate 
from Customers C
join Orders O on C.CustomerID = O.CustomerID
where year (o.OrderDate) = '2023'; 
--3
select e.Name, d.DepartmentName from Employees E
left join Departments D on E.DepartmentID = D.DepartmentID;
--4
select s.SupplierName, p.ProductName from Products P
right join Suppliers S on P.SupplierID = S.SupplierID;
--5
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount from Orders O
FULL OUTER JOIN  Payments P on o.OrderID = p.OrderID;
--6
select e.Name, E1.Name from Employees E
left join Employees E1 on E.EmployeeID = E1.ManagerID;
--7
select  S.Name, C.CourseName from students S
join Enrollments E on S.studentid = E.studentid
join courses C on E.Courseid = C.Courseid
where c.coursename = 'Math 101';
--8
select * from Customers C
join Orders O on c.CustomerID = o.CustomerID
where o.Quantity > 3;
--9
select  E.Name, D.DepartmentName from Employees E
join Departments D on e.DepartmentID = d.DepartmentID
where DepartmentName = 'Human Resources';
--Medium-Level Tasks
--10
select  count(E.EmployeeID), D.DepartmentName from Employees E
join Departments D on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having count(E.EmployeeID) > 5;
--11
select p.productid, p.productname from Products P
left join Sales S on p.ProductID = s.ProductID
where s.ProductID is null;
--12
select c.FirstName, c.LastName, count(o.OrderID) from Customers C
join Orders O on C.CustomerID = O.CustomerID
group by c.FirstName, c.LastName;
--13
select E.Name, D.DepartmentName from Employees E
join Departments D on e.DepartmentID = d.DepartmentID
--14
select e1.Name as Employee1, e2.Name as Employee2, e1.ManagerID from Employees E1
join Employees E2 on e1.ManagerID = e2.ManagerID and e1.EmployeeID < e2.EmployeeID;
--15
select o.OrderID, o.OrderDate, c.FirstName, c.LastName from Orders O
join Customers C on o.CustomerID = c.CustomerID
where year(o.OrderDate) = 2022;
--16
select e.Name, e.Salary, d.DepartmentName from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where e.Salary > 60000 and d.DepartmentName = 'sales';
--17
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount from Orders O
join Payments P on o.OrderID = p.OrderID;
--18
select o.ProductID, p.ProductName from Products p
left join Orders o on p.ProductID = o.ProductID
where o.ProductID is not null;
--Hard-Level Tasks
--19
select e.name, e.salary from Employees E
where e.Salary > ( select avg(Salary) from Employees
where DepartmentID = DepartmentID);
--20
select O.OrderID, O.OrderDate from Orders O 
left join Payments P on O.OrderID = P.OrderID
where year(O.OrderDate) < 2020 and p.OrderID is null
--21
select p.ProductID, p.ProductName from Products P 
left join Categories C on P.Category = C.CategoryID
where c.CategoryID is null;
--22
select     
	E1.Name AS Employee1,
    E2.Name AS Employee2,
    E2.ManagerID,
    E1.Salary AS Salary1,
    E2.Salary AS Salary2 from Employees E1
join Employees E2 on e1.ManagerID = E2.ManagerID and E1.EmployeeID < e2.EmployeeID
where E1.Salary > 60000 and E2.Salary > 60000;
--23
select * from Employees E
join Departments D on E.DepartmentID = D.DepartmentID
where d.DepartmentName like 'm%';
--24
select s.SaleID, p.ProductName, s.SaleAmount from Products P
join Sales S on p.ProductID = s.ProductID
where s.SaleAmount > 500;
--25
select s.StudentID, s.Name from Students S
left join Enrollments E on s.StudentID = e.StudentID
left join Courses C on e.CourseID = c.CourseID
where c.CourseName <> 'Math 101';
--26
select 
    o.OrderID,
    o.OrderDate,
    p.PaymentID
from Orders o
left join Payments p 
    on o.OrderID = p.OrderID
where p.PaymentID IS NULL;
--27
select   
p.ProductID,
    p.ProductName,
    c.CategoryName from Products P
join Categories C on P.Category = C.CategoryID
where c.CategoryName in ('Electronics', 'Furniture');
