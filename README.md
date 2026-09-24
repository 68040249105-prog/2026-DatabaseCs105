[SQLBEGIN TRANSACTION02.sql](https://github.com/user-attachments/files/32599727/SQLBEGIN.TRANSACTION02.sql)
--lab 24/09/69

--ตรวจสอบ emplyee product
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID = 'ALFKI';


--เริ้่มต้น transation

USE Northwind;
BEGIN TRANSACTION;
INSERT INTO Orders
(CustomerID, EmployeeID,
 OrderDate, RequiredDate, Freight)
VALUES
('ALFKI', 1, GETDATE(),
 DATEADD(DAY,7,GETDATE()), 50.00);

 --ดู order ที่พึ่งสร้าง
 SELECT SCOPE_IDENTITY()
  AS NewOrderID;


  --เพิ่มสินค้าใน order
  INSERT INTO [Order Details]
(OrderID, ProductID,
 UnitPrice, Quantity, Discount)
SELECT
 11078, ProductID,
 UnitPrice, 2, 0
FROM Products
WHERE ProductID = 1;

--ตรวจ orders
SELECT *FROM Orders
WHERE OrderID = 11078;

--ตรวจ oder Details
SELECT *FROM [Order Details]
WHERE OrderID = 11078;

--ตรวจผลหลัง commit
SELECT *
FROM Orders
WHERE OrderID = 11078;

--เริ้่มต้น transation ใหม่

BEGIN TRANSACTION;

INSERT INTO Orders
(CustomerID, EmployeeID,
 OrderDate, RequiredDate, Freight)
VALUES
('ALFKI', 1, GETDATE(),
 DATEADD(DAY,7,GETDATE()), 75.00);

 -- เก็บค่า order ที่พึ่งสร้างและนำไปตรวจสอบภายหลัง 
 SELECT SCOPE_IDENTITY()
  AS RollbackOrderID;

  -- เพอิ่มสินค้าใน product 1
  INSERT INTO [Order Details]
(OrderID, ProductID,
 UnitPrice, Quantity, Discount)
SELECT
 11080, ProductID,
 UnitPrice, 1, 0
FROM Products
WHERE ProductID = 1;

---- เพิ่มสินค้าใน product 2
INSERT INTO [Order Details]
 (OrderID, ProductID,
  UnitPrice, Quantity, Discount)
SELECT
 11080, ProductID,
 UnitPrice, 2, 0
FROM Products
WHERE ProductID = 2;
--ตรวจสอบข้อมูลก่ิอน roll back
SELECT *FROM Orders
WHERE OrderID =11080;

--ตรวจสอบข้อมูลใน oder Details
SELECT *FROM [Order Details]
WHERE OrderID =11080;



rollback


