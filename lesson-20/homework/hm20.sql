--1
select * from #sales as s
where exists (
select * FROM #sales AS s1
    WHERE s.saleid = s1.saleID
      AND s1.saleDate >= '2024-03-01'
      AND s1.saleDate < '2024-04-01'
);
--2
select Product, sum(quantity * price) as total_revenue from #sales 
group by product
having sum(quantity * price) = (select max(total_revenue) from (
select sum(quantity * price) as total_revenue 
from #sales 
group by product) as sub
);
--3
SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT DISTINCT (Quantity * Price) AS SaleAmount
    FROM #Sales
) AS s
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);
--4
select month(saledate) as month,
sum(dailyprice) as totalprice
from (
select saledate, 
sum (quantity * price) as dailyprice from #sales
group by saledate
) as dailysales
group by month(saledate)
order by month;
--5
SELECT DISTINCT s1.SaleID
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.SaleID = 2           
      AND s1.Product = s2.Product 
      AND s1.SaleID <> s2.SaleID
);
--6
SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
--7
WITH RecursiveFamily AS (
    SELECT ParentId AS PID, ChildID AS CHID
    FROM Family
    UNION ALL
    SELECT rf.PID, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f
      ON rf.CHID = f.ParentId
)
SELECT PID, CHID
FROM RecursiveFamily
ORDER BY PID, CHID;
--8
select * from #orders o
where o.deliverystate = 'TX' 
and exists(
select 1 
from #orders o2
where o2.customerID = o.CustomerId
and o2.deliverystate = 'CA'
);
--9
UPDATE #residents
SET fullname = SUBSTRING(
                    address, 
                    CHARINDEX('name=', address) + 5, 
                    CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - (CHARINDEX('name=', address) + 5)
                )
WHERE fullname IS NULL 
   OR fullname = '' 
   OR fullname <> SUBSTRING(
                        address, 
                        CHARINDEX('name=', address) + 5, 
                        CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - (CHARINDEX('name=', address) + 5)
                  );
--10
;
with ketish1 as(
select case when r.departurecity ='Tashkent' then 'Tashkent' else null end	depart1  
		,r.arrivalcity dest1, cost
from #Routes r
where case when r.departurecity ='Tashkent' then 'Tashkent' else null end is not null
),
ketish2 as(
select   k.depart1,k.dest1,
		r.arrivalcity dest2, r.cost+k.cost narx
from #Routes r
join ketish1 k on k.dest1=r.departurecity

),
ketish3 as(
select   
k.depart1
,k.dest1
,k.dest2
,r.arrivalcity dest3
,(isnull(r.cost,0)+ k.narx) som
from ketish2 k 
left join #Routes r on  k.dest2=r.departurecity
),
ketish4 as(
select   
k.depart1
,k.dest1
,k.dest2
,k.dest3
,r.arrivalcity dest4
, (isnull(r.cost,0)+ k.som) summa
from ketish3 k 
left join #Routes r on  k.dest3=r.departurecity
),
narx as(
select depart1,max(summa) maks,min(summa) minim from ketish4 group by depart1
)

select k.* from ketish4 k
join narx n on n.depart1=k.depart1 and (k.summa=n.maks or k.summa=n.minim)
order by k.summa
--11
;WITH ProductGroups AS (
    SELECT 
        *,
        SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END)
            OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GroupID
    FROM #RankingPuzzle
)
SELECT 
    ID,
    Vals,
    RANK() OVER (PARTITION BY GroupID ORDER BY ID) AS RankInGroup,
    GroupID AS ProductGroup
FROM ProductGroups
ORDER BY ID;
--12
select e.employeename,
e.department,
e.salesamount
from #employeesales e
where e.salesamount > (
select avg (salesamount)
from #employeesales
where department = e.department
);
--13
select distinct *
from #employeesales e
where not exists (select 1 from #employeesales e1 where e1.salesmonth = e.salesmonth and e1.salesamount = e.salesamount)
--14
SELECT DISTINCT e.EmployeeName, p.Name AS ProductName, p.Category
FROM #EmployeeSales e
JOIN Products p ON e.Department = p.Category
WHERE NOT EXISTS (
    SELECT DISTINCT m.SalesMonth
    FROM #EmployeeSales m
    WHERE m.SalesYear = 2024
      AND NOT EXISTS (
          SELECT 1
          FROM #EmployeeSales s
          WHERE s.EmployeeName	= e.EmployeeName
            AND s.SalesMonth = m.SalesMonth
            AND s.SalesYear = 2024
      )
)
ORDER BY e.EmployeeName, p.Name;
--15
SELECT Name, Category, Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);
--16
SELECT Name, Category, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);
--17
SELECT Name, Category
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
);
--18
SELECT Name, Category, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);
--19
SELECT DISTINCT p.Name, p.Category, p.Price
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p.Category
);
--20
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);
--21
SELECT p.Name, p.Category, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name, p.Category
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQty)
    FROM (
        SELECT SUM(o2.Quantity) AS TotalQty
        FROM Orders o2
        GROUP BY o2.ProductID
    ) AS sub
);
--22
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);
--23
SELECT TOP 1 
    p.Name, 
    p.Category, 
    SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name, p.Category
ORDER BY SUM(o.Quantity) DESC;


