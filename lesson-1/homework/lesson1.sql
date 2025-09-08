--Easy
/*
1. Ma'lumot, ma'lumotlar bazasi, Relatsion ma'lumotlar bazasi bir biriga bog'langan jadvallar, Table (Jadval).
2. Ma'lumotlar bilan ishlash - saqlash,qo'shish va yangilash imkoniyati,
   Xavfsizlik - foydalanuvchilarni auntefikatsiya qilish va ruxsatlarni boshqarish,
   Zaxira saqlash va ma'lumotlarni tiklash imkoniyati,
   Katta hajmdagi ma'lumotlar bilan tez va samarali ishlash,
   Power bi bilan integratsiya imkoniyati.
3. Windows Authentication, SQL server Authentication.
*/
--Medium
create database [Shooldb]

create table Students (StudentID int primary key, Name varchar(50), Age int)

/*
SQL Server - SUBD ma'lumotlar bazasini bishqarish tizimi,
SSMS (SQL Server Management Studio) - bu SQL Server bilan ishlash uchun grafik dastur,
SQL - bu so'rovlar tili va u orqali biz ma'lumot bazasiga murojaat qilishimiz mumkin.
*/
--Hard
/*1. 
   DQL (Data query language) = select (To see the data inside of a table)
   DML (Data manipulation language) = Update (To update data inside of a table) delete (To delete data inside of a table) insert (to add data inside of a table)
   DDL (Data definition language) = Create (To create databases, tables) Alter (To change structure of databases, tables) drop (deletes databases, tables) truncate (delete all rows from a table)
   DCL (Data Control Language) = Grant (give access to employees) Revoke (take back access from employees)
   TCL (Transaction Control Language) = Commit (saves data completely) Rollback (ctrl z one (step back)) - begin try
*/
--2
Insert into Students values (1, 'Diyor', 24), (2, 'Xolid', 32), (3, 'Xusan', 69) ;

/*
3. .bak fayl ni link orqali yuklab olib,
   C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup,
   Ush bu yo'l boyicha saqladik va databasesga Restore Database > Device > Add qilib AdventureWorks2022.bak faylini tanlab > OK tugmasini bosdik
*/
