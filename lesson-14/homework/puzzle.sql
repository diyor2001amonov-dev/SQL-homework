--1
SELECT
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM
    TestMultipleColumns
WHERE
    CHARINDEX(',', Name) > 0;
--2
select * from TestPercent
where strs like '%[%]%' ESCAPE '\';
--3
SELECT value AS Part
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');
--4
SELECT *
FROM testDots
WHERE (LEN(Vals) - LEN(REPLACE(Vals, '.', ''))) > 2;
--5
select * from employee E
join Employee M on e.managerid = m.ID
where e.salary > m.salary;
--6
select  
	Employee_ID,
    First_Name,
    Last_Name,
    Hire_Date,
    DATEDIFF(YEAR, Hire_Date, GETDATE()) AS YearsOfService from employees
where datediff(year, hire_date, getdate())> 10 and 
datediff(year, hire_date, getdate())< 15;
--Medium Tasks
--1
select  
	w1.id,
    w1.recordDate,
    w1.temperature from weather w1
join weather w2 on datediff(day, w2.recorddate, w1.recorddate) = 1
where w1.temperature > w2.temperature;
--2
select player_id, min(event_date) as first_login from Activity
group by player_id;
--3
SELECT value AS third_fruit
FROM STRING_SPLIT(fruit_list, ',', 1)
WHERE ordinal = 3;
--4
select 
case
	when year(GETDATE())-YEAR(HIRE_DATE)<1 then 'New Hire'
	when year(GETDATE())-YEAR(HIRE_DATE) between 1 and 5 then 'Junior'
	when year(GETDATE())-YEAR(HIRE_DATE) between 5 and 10 then 'Mid-Level'
	when year(GETDATE())-YEAR(HIRE_DATE) between 10 and 20 then 'Senior'
	else 'Veteran' end	
from employees;
--5
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS IntegerValue
FROM GetIntegers;
--Difficult Tasks
--3
select a1.* from Activity a1
join (select player_id,min(event_date) sana from Activity group by player_id) a2 on a1.player_id = a2.player_id and a1.event_date=a2.sana;
