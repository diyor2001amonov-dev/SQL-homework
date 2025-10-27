--Task 1:
CREATE PROCEDURE dbo.usp_CalculateEmployeeBonus
    @BonusPercentage DECIMAL(5,2)  -- e.g., 10 for 10%
AS
BEGIN
    SET NOCOUNT ON;
    CREATE TABLE #EmployeeBonus
    (
        EmployeeID INT,
        FullName NVARCHAR(200),
        Department NVARCHAR(100),
        Salary DECIMAL(18,2),
        BonusAmount DECIMAL(18,2)
    );
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT
        EmployeeID,
        FirstName + ' ' + LastName AS FullName,
        Department,
        Salary,
        Salary * @BonusPercentage / 100.0 AS BonusAmount
    FROM Employee;

    SELECT *
    FROM #EmployeeBonus;
END;
--Task 2:
CREATE PROCEDURE dbo.usp_UpdateDepartmentSalary
    @DepartmentName NVARCHAR(100),
    @IncreasePercentage DECIMAL(5,2)  
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Employee
    SET Salary = Salary * (1 + @IncreasePercentage / 100.0)
    WHERE Department = @DepartmentName;
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary
    FROM Employee
    WHERE Department = @DepartmentName;
END;
--Task 3:
MERGE INTO Products_Current AS Target
USING Products_New AS Source
    ON Target.ProductID = Source.ProductID

WHEN MATCHED THEN
    UPDATE SET 
        Target.ProductName = Source.ProductName,
        Target.Price = Source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
SELECT * FROM Products_Current;
--Task 4:

SELECT
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN t.id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree AS t
ORDER BY t.id;
-- Task 5:
SELECT 
    s.user_id,
    CAST(
        ISNULL(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 0) * 1.0 /
        NULLIF(COUNT(c.action), 0)
    AS DECIMAL(4,2)) AS confirmation_rate
FROM Signups AS s
LEFT JOIN Confirmations AS c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
--Task 6:
SELECT ID, Name, Salary
FROM Employees
WHERE Salary = (
    SELECT MIN(Salary)
    FROM Employees
);
--Task 7:
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * s.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s
        ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
