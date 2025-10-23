-- 1
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
    r.Region,
    d.Distributor,
    ISNULL(s.Sales, 0) AS Sales
FROM 
    Regions r
CROSS JOIN 
    Distributors d
LEFT JOIN 
    #RegionSales s
    ON s.Region = r.Region
    AND s.Distributor = d.Distributor
ORDER BY 
    r.Region,
    d.Distributor;
--2
SELECT 
    m.name
FROM 
    Employee e
JOIN 
    Employee m 
    ON e.managerId = m.id
GROUP BY 
    m.name
HAVING 
    COUNT(e.id) >= 5;
--3
SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM 
    Products p
JOIN 
    Orders o 
    ON p.product_id = o.product_id
WHERE 
    o.order_date >= '2020-02-01'
    AND o.order_date < '2020-03-01'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;
--4
SELECT 
    CustomerID,
    Vendor
FROM (
    SELECT 
        CustomerID,
        Vendor,
        SUM(count) AS TotalOrders,
        RANK() OVER (
            PARTITION BY CustomerID 
            ORDER BY SUM(count) DESC
        ) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) AS ranked
WHERE rnk = 1;
--5
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

-- 0 and 1 are not prime
IF @Check_Prime <= 1
    SET @isPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
--6
WITH DeviceLocation AS (
    SELECT
        Device_id,
        Location,
        SUM(Signals) AS TotalSignalsPerLocation
    FROM device
    GROUP BY Device_id, Location
),
MaxLocation AS (
    SELECT
        Device_id,
        Location AS max_signal_location,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY TotalSignalsPerLocation DESC) AS rn
    FROM DeviceLocation
)
SELECT 
    d.Device_id,
    COUNT(DISTINCT d.Location) AS no_of_location,
    m.max_signal_location,
    SUM(d.Signals) AS no_of_signals
FROM device d
JOIN MaxLocation m 
    ON d.Device_id = m.Device_id
WHERE m.rn = 1
GROUP BY d.Device_id, m.max_signal_location
ORDER BY d.Device_id;
--7
SELECT 
    EmpID,
    EmpName,
    Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE Deptid = e.Deptid
);
--8
WITH TicketMatches AS (
    SELECT
        t.TicketID,
        COUNT(*) AS MatchingNumbers
    FROM Tickets t
    JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
),
TicketWinnings AS (
    SELECT
        TicketID,
        CASE 
            WHEN MatchingNumbers = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN MatchingNumbers > 0 THEN 10
            ELSE 0
        END AS Winnings
    FROM TicketMatches
)
SELECT 
    SUM(Winnings) AS TotalWinnings
FROM TicketWinnings;
--10
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n + 1 <= (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n
    ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
