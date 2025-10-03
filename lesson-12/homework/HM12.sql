--1
Select * from Person p 
left join Address a on p.personId = a.personId
--2
Select emp.name from Employee emp 
join Employee Man on emp.managerId = man.id
where emp.salary > man.salary
--3
Select email, count(*) from Emails
group by email
having count(*) > 1
--4
delete a from Email2 a
join Email2 b on a.email = b.email and a.id > b.id
--5
Select g.* from Boys b
right join girls g
on b.ParentName = g.ParentName
where b.id is null
--6
SELECT  custid,
		sum(CASE WHEN freight < 50 then 0 else unitprice*qty*(1 - discount) end) TotalsalesOver50,
		min(freight) minWeight
FROM [TSQL2012].[Sales].[Orders] o
LEFT JOIN [TSQL2012].[Sales].[OrderDetails] od
on o.orderid = od.orderid
group by custid
--7
select *  from Cart1 C1
full outer join Cart2 C2 on c1.item = c2.item
order by c2.item 
--8
select c.name from Customers C
left join Orders O on C.ID = O.CustomerID
where o.CustomerID is null;
--9
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
       ON s.student_id = e.student_id 
      AND e.subject_name = sub.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
