--1
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
);

INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * s.UnitPrice) AS TotalRevenue
FROM Sales s
WHERE MONTH(s.SaleDate) = MONTH(GETDATE())
  AND YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;
--2
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products AS p
INNER JOIN Sales AS s 
    ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductID, 
    p.ProductName, 
    p.Category;
--3
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT 
        @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales AS s
    INNER JOIN Products AS p
        ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;
--4
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products AS p
    INNER JOIN Sales AS s
        ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
--5
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;  
    IF @Number < 2
        SET @IsPrime = 0;
    ELSE
    BEGIN
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @IsPrime = 0;
                BREAK;
            END;
            SET @i = @i + 1;
        END;
    END;
    DECLARE @Result VARCHAR(3);
    SET @Result = CASE WHEN @IsPrime = 1 THEN 'Yes' ELSE 'No' END;
    RETURN @Result;
END;
--6
CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE
(
    Number INT
)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@i);
        SET @i = @i + 1;
    END;
    RETURN;
END;
--7
DECLARE @N INT = 2;

SELECT 
    CASE 
        WHEN COUNT(DISTINCT salary) >= @N 
        THEN (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            OFFSET (@N - 1) ROWS FETCH NEXT 1 ROW ONLY
        )
        ELSE NULL
    END AS NthHighestSalary;
--8
SELECT TOP 1
    id,
    COUNT(*) AS num
FROM
(
    SELECT requester_id AS id, accepter_id AS friend_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id FROM RequestAccepted
) AS Friends
GROUP BY id
ORDER BY num DESC;
--10
SELECT 
    RowNumber,
    MAX(testcase) OVER (ORDER BY RowNumber 
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
FROM gaps
ORDER BY RowNumber;





