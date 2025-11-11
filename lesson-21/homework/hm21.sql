--1
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;
--2
select ProductName, sum(quantity) as Totalquantity,
DENSE_RANK() over (order by sum(quantity) desc) as rankbyquan
from Productsales
group by productname
order by rankbyquan;
--3
select SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID
from(select SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        Quantity,
        CustomerID, ROW_NUMBER () over (partition by customerid order by saleamount desc) as rn
from productsales)as ranked_sales
where rn =1;
--4
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
	lead (saleamount) over (order by saledate) as nextamount
	from productsales
	order by saledate;
--5
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
	lag (saleamount) over (order by saledate) as nextamount
	from productsales
	order by saledate;
--6
;with cte as(
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
	lag (saleamount) over (order by saledate) as nextamount
	from productsales
)select * from cte where CurrentSaleAmount < nextamount
order by saledate;
--7
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS lastsale,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS minussale
FROM ProductSales
ORDER BY ProductName, SaleDate;
--8
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    lead(SaleAmount) OVER (ORDER BY SaleDate) AS nextsale,
	case 
	when lead(saleamount) over(order by saledate) is null then null
	else ((lead (saleamount) over (order by saledate) - saleamount)/ saleamount)* 100
	end as prosent
FROM ProductSales
ORDER BY SaleDate;
--9
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN NULL
        ELSE CAST(SaleAmount AS DECIMAL(10,2)) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
    END AS SaleAmountRatio
FROM ProductSales
ORDER BY ProductName, SaleDate;
--10
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirstSale
FROM ProductSales
ORDER BY ProductName, SaleDate;
--11
;with cte as (
select SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
		lag(saleamount) over (partition by productName order by SaleDate) as PervAmount
		from productsales
) select * from cte where PervAmount is not null and Saleamount > PervAmount
order by productname, saledate;
--12
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS ClosingBalance
FROM ProductSales
ORDER BY SaleDate;
--13
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName
        ORDER BY SaleDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_Last3Sales
FROM ProductSales
ORDER BY ProductName, SaleDate;
--14
WITH RankedEmployees AS (
    SELECT
        EmployeeID,
        Name,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees2
)
SELECT *
FROM RankedEmployees
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM RankedEmployees
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Salary DESC;
--15
WITH SalaryCounts AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        COUNT(*) OVER (PARTITION BY Salary) AS SameSalaryCount
    FROM employees2
)
SELECT *
FROM SalaryCounts
WHERE SameSalaryCount > 1
ORDER BY Salary;
--16
WITH RankedSalaries AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM employees2
)
SELECT *
FROM RankedSalaries
WHERE SalaryRank <= 2
ORDER BY Department, Salary DESC;
--17
WITH RankedEmployees AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM employees2
)
SELECT
    EmployeeID,
    Name,
    Department,
    Salary
FROM RankedEmployees
WHERE SalaryRank = 1
ORDER BY Department;
--18
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department
        ORDER BY Salary ASC
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotal
FROM employees2
ORDER BY Department, Salary;
--19
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalSalaryByDepartment
FROM employees2
ORDER BY Department, Name;
--20
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM employees2
ORDER BY Department, Name;
--21
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM employees2
ORDER BY EmployeeID;
--23
SELECT
    EmployeeID,
    Name,
    HireDate,
    Salary,
    SUM(Salary) OVER (ORDER BY HireDate DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM employees2
ORDER BY HireDate DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;







