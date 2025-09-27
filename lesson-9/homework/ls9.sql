-- Easy-Level Tasks
--1
select * from Suppliers s
join products p on p.supplierid = s.supplierid;
--2
select * from Departments d
join Employees e on e.DepartmentID = d.DepartmentID;
--3
select s.SupplierName, p.ProductName from Suppliers s
join products p on p.supplierid = s.supplierid;
--4
select o.OrderID, c.FirstName from Orders o
join Customers c on c.CustomerID = o.CustomerID;
--5
select s.name, c.CourseName
from students s
cross join courses c;
--6
select p.ProductName, o.OrderID from Products p
join  Orders o on o.ProductID = p.ProductID;
--7
select d.DepartmentName, e.name from Departments d
join Employees e on d.DepartmentID = e.DepartmentID;
--8
select s.Name, e.CourseID from Students s
join Enrollments e on e.StudentID = s.StudentID;
--9
select p.PaymentID, p.PaymentDate, p.PaymentMethod, p.amount from Payments p
join Orders o on p.OrderID = o.OrderID;
--10
select * from Products p
join Orders o on p.ProductID = o.ProductID
where Price > 100;
-- Medium (10 puzzles)
--11
select e.Name, d.DepartmentName from Departments d
join Employees e on e.DepartmentID <> d.DepartmentID;
--12
select * from Orders o
join Products p on p.ProductID = o.ProductID
where o.Quantity > p.StockQuantity;
--13
select * from Customers c
join Sales s on c.CustomerID = s.CustomerID
where s.SaleAmount >= 500;
--14
select s.Name, c.CourseName from Students S
join Enrollments E on S.StudentID = E.StudentID
join Courses C on C.CourseID = E.CourseID;
--15
select *  from Products P
join Suppliers S on P.Supplierid = S.Supplierid
where SupplierName like '%Tech%';
--16
select * from Payments P
join Orders O on P.OrderID = O.OrderID
where p.Amount < o.TotalAmount;
--17
select e.Name, d.DepartmentName from Departments D
join Employees E on D.DepartmentID = E.DepartmentID;
--18
select * from Categories C
join Products P on p.Category = c.CategoryID
where c.CategoryName in ('Electronics', 'Furniture');
--19
select * from Customers C
join Sales S on C.CustomerID = S.CustomerID
where C.Country = 'USA';
--20
select * from Customers C
join Orders O on C.CustomerID = O.CustomerID
where C.Country = 'Germany' and O.TotalAmount > 100;
--Hard (5 puzzles)(Do some research for the tasks below)
--21
select e.Name, e1.Name, e.DepartmentID, e1.DepartmentID from Employees E
join Employees E1 on e.DepartmentID <> e1.DepartmentID
and e.EmployeeID < e1.EmployeeID;
--22
select *, (o.Quantity * Pr.Price) from Payments P
join Orders O on P.OrderID = O.OrderID
join Products Pr on Pr.ProductID = O.ProductID
where p.Amount <> (o.Quantity * Pr.Price);
--23
select * from Students S
left join Enrollments E on E.StudentID = S.StudentID
left join Courses C on C.CourseID = E.CourseID
where EnrollmentID is null;
--24
select * from Employees E
join Employees M on E.EmployeeID = M.ManagerID
where M.Salary <= E.Salary; 
--25
select * from Customers C 
join Orders O on O.CustomerId = C.CustomerID
left join Payments P on P.OrderID = O.OrderID
where P.PaymentID is null;
