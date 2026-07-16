
--เริ่มโปรแกรม master 
Create Database CSMinimart
--ปรับข้อมูลให้สามารถใส่ภาษาไทยได้
Alter Database CsMinimart collate Thai_CI_AS;
--เปลี่ยนข้อมูลไปใช้ CsMinimart เปลี่ยนบนเมนู
--สร้างตารางเก็บข้อมูลพนักงาน ชื่อ Employees
Create Table Employees(
     EmployeesID int identity (1,1) primary key,
     title varchar (20) null,
     firstname varchar (50)not null,
     lastname varchar (50)null,
     position varchar(50)null,
     username varchar (50) Unique,
     passwordhash varchar (255) not null,
     IsActive bit not null default 1
     )

     --ถ้าสมมุติลืมเปลี่ยนจาก Master เป็น Cs minimart  สามารถใช้คำสั่ง drop table Employees

     --ทดสอบเพิ้่มข้อมูลในตาราง Employees 
     INSERT INTO Employees 
    (Title, FirstName, LastName, Position, UserName, PasswordHash) 
VALUES 
    ('นางสาว', 'กาญจนา', 'พวงแก้ว', 'Sale Manager', 'user1', 'hashed1');
    --เมื่อเพิ่มแล้ว ทดสอบเรียกข้อมูลออกมาดู
    SELECT * FROM Employees;

    INSERT INTO Employees 
    (Title, FirstName, LastName, Position, UserName, PasswordHash) 
VALUES 
    ('นางสาว', 'พัชราภรณ์', 'สงวนศิลป์', 'Sale Manager', 'user2', 'hashed1');
    SELECT * FROM Employees;
    --สร้างตารางหมวดหมู่สินค้า Categories
    CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200)
);
    --เพิ่มข้อมูลในตาราง หมวดหมู่สินตค้า categories 
   --หมวดหมู่1
   
   INSERT INTO Categories
    (CategoryName, Description)
VALUES
    ('เครื่องดื่ม',
     'น้ำดื่ม น้ำผลไม้ ชาและกาแฟ');

     --หมวดหมู่2
     INSERT INTO Categories
    (CategoryName, Description)
VALUES
    ('เครื่องปรุง',
     'รสดี น้ำตาล เกลือชมพู');

     --หมวดหมู่3
     INSERT INTO Categories
    (CategoryName, Description)
VALUES
    ('เวชภัณฑ์',
     'ยาพาราเซตามอล ยาแก้ไอ ยาธาตุน้ำขาวตรากระต่ายบิน');

     --หมวดหมู่4
     INSERT INTO Categories
    (CategoryName, Description)
VALUES
    ('อาหารสำเร็จรูป',
     'ผลไม้กระป๋อง มามาเผ็ดเกาหลี หมาล่าฮอตพอต');


     --หมวดหมู่5
     INSERT INTO Categories
    (CategoryName, Description)
VALUES
    ('เครื่องสำอาง',
     'เบสม่วง ปากกาดอลลี่อาย คุชชั่น');

     --คำสั่งนี้ดูข้อมูลในตาราง cetegories
     SELECT *FROM Categories;


     --สร้างตาราง products
     CREATE TABLE Products (
    ProductID VARCHAR(13) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
    UnitsInStock INT NOT NULL DEFAULT 0,
    CategoryID INT NOT NULL,
    Discontinued BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Products_UnitPrice 
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Products_UnitsInStock 
        CHECK (UnitsInStock >= 0),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID) 
        REFERENCES Categories(CategoryID)
);

    --ทดสอบข้อมูล


    INSERT INTO Products
    (ProductID, ProductName, UnitPrice,UnitsInStock, CategoryID)
VALUES
    ('8858757001948', 'โค็ก', 15.00, 290, 1);
     SELECT *FROM Products;


     INSERT INTO Products
    (ProductID, ProductName, UnitPrice,
     UnitsInStock, CategoryID)
VALUES
    ('8858757009998', 'แป๊ปซี่',
     17.00, 30, 2);
      SELECT *FROM Products;



      
     INSERT INTO Products
    (ProductID, ProductName, UnitPrice,
     UnitsInStock, CategoryID)
VALUES
    ('8858998586257', 'น้ำเปล่า อควาฟิน่า',
     10.00, 80, 3);
      SELECT *FROM Products;


      INSERT INTO Products
    (ProductID, ProductName, UnitPrice,
     UnitsInStock, CategoryID)
VALUES
    ('8858998589326', 'น้ำดื่ม ทีพลัส',
     22.00, 50, 4);
      SELECT *FROM Products;


      INSERT INTO Products
    (ProductID, ProductName, UnitPrice,
     UnitsInStock, CategoryID)
VALUES
    ('8858998589314', 'ปัน ปัน ถั่วลันเตาอบกรอบ',
     25.00, 50, 5);
      SELECT *FROM Products;


      --สร้างตารางใบเสร็จ

       CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL 
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeesID)
);
--ดูวันที่และเวลา
Select GETDATE()
    

    INSERT INTO Receipts
    (EmployeeID, TotalCash)
VALUES
    (1, 115.00);

SELECT * FROM Receipts;



--เพิ่มข้อมูลในตารางใบเสร็จ

insert into Receipts (EmployeeID,TotalCash) 
Values (1,115)

--ดูข้อมูลในตารางใบเสร็จ

SELECT * FROM Receipts;

--สร้างตาราง

CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
--เพิ่มข้อมูลในตาราง
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);

    SELECT * FROM Details;

    