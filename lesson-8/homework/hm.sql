--Easy-Level Tasks
--1
select category, count(*) 
from Products
group by Category;
--2
select Category, avg(price) 
from Products
group by Category
having Category = 'Electronics';
--3
select * from Customers
where City like 'L%';
--4
select * from Products
where ProductName like '%er';
--5
select * from Customers
where Country like '%A';
--6
select max(Price) from Products;
--7
select *, case
when StockQuantity < 30 then 'Low Stock'
else 'Sufficient' end 
from Products;
--8
select Country, sum(CustomerID) 
from Customers
group by Country;
--9
select min(Quantity), max(Quantity) from Orders;
--Medium-Level Tasks
--10
select o.CustomerID from orders o
left join invoices i on o.CustomerID = i.CustomerID
where o.OrderDate between '2023-01-01' and '2023-02-01'
and i.invoiceid is null
--11
SELECT ProductName
FROM Products
UNION ALL
SELECT ProductName
FROM Products_Discounted;
--12
SELECT ProductName
FROM Products
UNION 
SELECT ProductName
FROM Products_Discounted;
--13
select year(OrderDate),
avg(TotalAmount)
from orders
group by year(OrderDate);
--14
select ProductName, Price, 
case
 when Price < 100 then 'Low'
 when Price between 100 and 500 then 'Mid'
 when Price > 500 then 'High'
 else 'null' end
from Products;
--15
SELECT district_name, [2012], [2013]
INTO Population_Each_Year
FROM
(
    SELECT 
        district_name,
        Year,
        Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;
--16
select ProductID, sum(SaleAmount) 
from Sales
group by ProductID;
--17
select * from Products
where ProductName like '%oo%';
--18
SELECT Year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM
(
    SELECT 
        district_name,
        Year,
        Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;
--Hard-Level Tasks
--19
select top 3 CustomerID, sum(TotalAmount) as Totalspent
from Invoices
group by CustomerID
order by Totalspent DESC;
--20
SELECT 
    district_name,
    Year,
    Population
INTO City_Population
FROM Population_Each_Year
UNPIVOT
(
    Population FOR Year IN ([2012], [2013])
) AS Unpvt;
--21
SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM Products p
LEFT JOIN Sales s
    ON p.ProductID = s.ProductID
GROUP BY p.ProductName;
--22
SELECT 
    Year,
    district_name,
    Population
INTO City_Population
FROM Population_Each_City
UNPIVOT
(
    Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS Unpvt;

