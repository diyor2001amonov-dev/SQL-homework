--Easy Tasks
--1
select CONCAT(employee_id, '-' + first_name + last_name) from employees
--2
update employees set 
phone_number = replace(phone_number, '124', '999');
--3
select first_name as firstname, len(First_name) as len_name from employees
where left(First_name, 1) in ('A', 'J', 'M')
order by First_name;
--4
select manager_id, sum(salary) from employees 
group by manager_id;
--5
SELECT year1,
       GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;
--6
select * from cinema where description <> 'boring' and id%2=1
--7
SELECT *
FROM SingleOrder
ORDER BY (CASE WHEN Id = 0 THEN 1 ELSE 0 END), Id;
--8
SELECT COALESCE(id, ssn, passportid, itin) AS FirstNonNullValue
FROM person;
--Medium Tasks
--1
select left(FullName, CHARINDEX(' ', FullName) -1) as FirstName,
SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
) AS MiddleName,
right (FullName, CHARINDEX(' ', FullName) +1) as LastName
from Students
--2
SELECT *
FROM Orders
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'CA'
)
AND DeliveryState = 'TX';
--3
SELECT GroupColumn,
       STRING_AGG(ColumnName, ', ') AS ConcatenatedValues
FROM DMLTable
GROUP BY GroupColumn;
--4
SELECT *
FROM Employees
WHERE (LEN(FIRST_NAME + LAST_NAME) - LEN(REPLACE(FIRST_NAME + LAST_NAME, 'a', ''))) >= 3;
--5
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 END) AS EmployeesOver3Years,
    ROUND(
        COUNT(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS PercentageOver3Years
FROM Employees
GROUP BY Department_ID;
--Difficult Tasks
--1
SELECT
    StudentID,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID ROWS UNBOUNDED PRECEDING) AS CumulativeSum
FROM Students
ORDER BY StudentID;
--2
WITH SharedBirthdays AS (
    SELECT Birthday
    FROM Student
    GROUP BY Birthday
    HAVING COUNT(*) > 1
)
--3
SELECT
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END
ORDER BY Player1, Player2;
--4
SELECT
    REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '', 'g') AS UppercaseLetters,
    REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '', 'g') AS LowercaseLetters,
    REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '', 'g') AS Numbers,
    REGEXP_REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '', 'g') AS OtherCharacters;
