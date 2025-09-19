-- Puzzle 1:
SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS val1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS val2
FROM InputTbl;

SELECT DISTINCT 
       LEAST(col1, col2) AS val1,
       GREATEST(col1, col2) AS val2
FROM InputTbl;
-- Puzzle 2:
SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);

select * from TestMultipleZero
where (a + b + c + d) <> 0;
-- Puzzle 3:
select * from section1
where id % 2 = 1;
-- Puzzle 4:
select min(id) as ID
from section1;
-- Puzzle 5:
select max(id) as ID
from section1;
-- Puzzle 6:
select * 
from section1 where name like 'b%';
-- Puzzle 7:
select * from ProductCodes
where Code like '%\_%' escape '\';
