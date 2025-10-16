--1
SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
--2
select id, product_name, price
from products
where price > (select avg(price) from products);
--3
select * from Employees
where department_id = (select id from departments where department_name = 'sales')
--4
select * from customers
where customer_id not in (select customer_id from orders)
--5
SELECT *
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);
--6
SELECT e.id, e.name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);
--7
SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
--8
select * from students s
join grades g on s.student_id = g.student_id
where g.grade = (select max(grade) from grades where course_id = g.course_id);
--10
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
AND salary < (SELECT MAX(salary) FROM employees);
