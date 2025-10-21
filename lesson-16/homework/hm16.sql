--Easy Tasks
--1
CREATE TABLE dbo.Numbers (n INT PRIMARY KEY);
WITH NumbersCTE AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM NumbersCTE
    WHERE n < 1000
)
INSERT INTO dbo.Numbers(n)
SELECT n FROM NumbersCTE
OPTION (MAXRECURSION 0);  
--2
SELECT firstname,
       (SELECT SUM(SalesAmount)
        FROM Sales s
        WHERE s.EmployeeID = e.EmployeeID) AS TotalSales
FROM Employees e;
--3
with avgsalary as(
select avg(Salary) AS AvgSalary
from Employees
)
select * from avgsalary;
--4
select p.ProductID, (select max(SalesAmount) from Sales s
where s.ProductID = p.productid) as eachprod
from Products p;
--5
WITH NumbersCTE AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2
    FROM NumbersCTE
    WHERE n * 2 < 1000000
)
SELECT *
FROM NumbersCTE
--6
WITH moresales as (
    SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(s.SalesAmount) AS TotalSales
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
select * from moresales where totalSales > 5
--7
with ProductSales as (
 select p.productid, p.productname, sum(s.SalesAmount) as total from Products p
 join sales s on p.ProductID = s.ProductID
 group by p.productid, p.productname
)
select * from ProductSales where total > 500
--8
with topsalary as (
select avg(salary) as avgsalary from Employees
)
select * from employees e
cross join topsalary t
where e.Salary > t.avgsalary
--Medium Tasks
--1
SELECT TOP 5
    dt.EmployeeID,
    dt.OrdersCount
FROM
    (SELECT 
         EmployeeID,
         COUNT(*) AS OrdersCount
     FROM Sales
     GROUP BY EmployeeID) AS dt
ORDER BY dt.OrdersCount DESC;
--2
SELECT
    dt.CategoryID,
    SUM(dt.SalesAmount) AS TotalSales
FROM
    (SELECT 
         p.CategoryID,
         s.SalesAmount
     FROM Sales s
     JOIN Products p
       ON s.ProductID = p.ProductID) AS dt
GROUP BY dt.CategoryID
ORDER BY TotalSales DESC;
--6
WITH MonthlySales AS
(
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
), salediff as
(
    SELECT
        SaleYear,
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT
    SaleYear,
    SaleMonth,
    TotalSales,
    PrevMonthSales,
    TotalSales - PrevMonthSales AS SalesDifference
FROM SaleDiff
ORDER BY SaleYear, SaleMonth;
--Difficult Tasks
--1
DECLARE @N INT = 10;

WITH FibonacciCTE AS
(
    SELECT 1 AS Position, 0 AS FibCurrent, 1 AS FibNext
    UNION ALL
    SELECT Position + 1,
           FibNext,
           FibCurrent + FibNext
    FROM FibonacciCTE
    WHERE Position < @N
)
SELECT Position, FibCurrent AS FibonacciValue
FROM FibonacciCTE
ORDER BY Position;
--2
SELECT Vals
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals,1) + ']%';
--3
DECLARE @n INT = 5;

WITH NumbersCTE AS
(
    SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    SELECT Num + 1,
           Sequence + CAST(Num + 1 AS VARCHAR(10))
    FROM NumbersCTE
    WHERE Num + 1 <= @n
)
SELECT Sequence
FROM NumbersCTE
ORDER BY Num;
--4
WITH EmployeeSales AS
(
    SELECT 
        EmployeeID, 
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
),
MaxSales AS
(
    SELECT MAX(TotalSales) AS MaxTotal
    FROM EmployeeSales
)
SELECT e.EmployeeID, e.FirstName, es.TotalSales
FROM Employees e
INNER JOIN EmployeeSales es ON e.EmployeeID = es.EmployeeID
CROSS JOIN MaxSales m
WHERE es.TotalSales = m.MaxTotal;


