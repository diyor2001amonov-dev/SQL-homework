--Easy-Level 

/*
1 - Bulk Insert bu sql serverda ma'lumotni tashqi fayldan yuklab olishga yordam beradi 
(masalan, txt, csv, exel fayllardan) va table belgilangan tablega ma'lumotni yuklab berdai;
2 - Sqlga 4 ta yuklab bo'laydigan formatlar bu (CSV, TXT, Excel, XML);
5 - masalan Name VARCHAR(50) NOT NULL bo'lsa bu maydon majburiy va u bo'sh bo'lishi mumkin emas, 
NULL esa uni teskarisi va unda bosh maydonlar bo'lishi mumkin;
10 - IDENTITY funksiya ustunga avtobatik ketma ket son berib borish uchun ishlatiladi;
*/
create table Products (
ProductID int primary key, 
ProductName VARCHAR(50), 
Price DECIMAL(10,2)
);
insert into Products values 
(1, 'Carrot', 7000.00), 
(2, 'Beer', 71000.00), 
(3, 'Egg', 31000.00);
alter table Products
add constraint UQ_ProductName unique (ProductName);
-- Tepadagi alter zapros ProductName ustundi unikal ustun deb hisobladi;
alter table Products 
add CategoryID INT;
create table Categoties (
CategoryID int primary key,
CategoryName varchar(100) unique
);
--Medium-Level
Bulk insert Products 
from 'C:\Users\diyor\OneDrive\Desktop\????? ?????\text.txt'
with(
fieldterminator = ',' --vergul bilan ustundi ajratadi 
rowterminator = '\n' -- enter tugmasidek ishlaydi yani yagi qatordan boshlash uchun
fristrow = 1 -- ustundi birinchi qatordan oladi
);
alter table Products 
add constraint FK_Products_Categories 
foreign key (CategoryID) references Categoties(CategoryID); 
/*
13 - PRIMARY KEY Jadvalda faqat 1 ta bo‘lishi mumkin,
Avtomatik ravishda NOT NULL (bo‘sh qoldirib bo‘lmaydi),
Qatorlarni noyob aniqlash uchun ishlatiladi;
UNIQUE KEY
Jadvalda bir nechta bo‘lishi mumkin,
Ustun qiymatlari takrorlanmas bo‘lishi kerak, lekin 1 marta NULL ruxsat etiladi,
Qo‘shimcha cheklov sifatida ishlatiladi;
*/
alter table Products
add constraint CHK_Products_Price check (Price > 0);
alter table Products 
add Stock int not null default(0);
select ProductID,
       ProductName,
       isnull(Price, 0) as Price,
       CategoryID,
       Stock
from Products;
/*
17 - FOREIGN KEY — bu jadvaldagi ustunni boshqa jadvaldagi PRIMARY KEY (yoki UNIQUE KEY) ga bog‘lovchi cheklov.
*/

create table Customers (
CustomerID int primary key,
FullName varchar(100) not null,
Age int check (Age > 18)
);
create table People (
PeopleID int identity (100,10) primary key
);
create table OrderDetails(
OrderID int not null,
ProductID int not null,
Primary key (OrderID, ProductID)
);

/*
21 - Isnull - faqat 2 ta argument qabul qiladi 
masalan - SELECT ISNULL(Price, 0) AS Price
FROM Products;

Coalesce - bir necha argument qabul qiladi 
masalan - SELECT COALESCE(Discount, Price, 0) AS FinalPrice
FROM Products;
va birinchi null bo'lmagan qiymatni qaytaradi;
*/
create table Employees(
EmpID int primary key,
Email varchar(100) unique
);
CREATE TABLE Orders (
    OrderID   INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

