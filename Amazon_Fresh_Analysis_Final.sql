create database Amazon_Fresh_Analysis;  
use Amazon_Fresh_Analysis;
Select *from customers;
select * from order_details;
select *from orders;
select * from products;
select * from reviews;
select *from suppliers;
#Task1
#craeting Primary key for the customers table.
#checking all CustomerID values are unique and not NULL
#checking for duplicate customerIDs.
select customerID,count(*) As Duplicate_Rows from customers group by CustomerID having count(*)>1;
#checking for NUll customerIDs
select *from customers where CustomerID is Null;
#There is No Duplictae and Null values in CustomerID so craeting Primary key for the customers table.
desc customers;
Alter table customers modify CustomerID VARCHAR(100);
Alter table customers add primary key (customerID);
#verify the primary key.
SHOW CREATE TABLE customers;
#craeting Primary key and foreign key to the orders table.
select * from orders;
#checking all  OrdreIDs and CustomerIDs values are unique and not NULL
#checking for duplicate OrdreIDs and CustomerIDs.
select OrderID,CustomerID,count(*) AS duplicate_rows from orders group by OrderID having count(*)>1;
#checking for NUll  OrdreIDs and CustomerIDs.
select * from orders where OrderID is null;
select * from orders where CustomerID is null;
#There is No Duplictae and Null values in  OrdreIDs and CustomerIDs so craeting Primary key and foreign key to the Ordres table.
desc orders;
Alter table orders modify orderID varchar(100),modify customerID varchar(100);
Alter table orders ADD primary key (orderID);
Alter table orders ADD foreign key (CustomerID) REFERENCES Customers(CustomerID);
SHOW CREATE TABLE Orders;
#creating primary key to suppliers table
#checking all ProductID values are unique and not NULL
#checking for duplicate SupplerIDs.
select SupplierID,count(*) AS duplicate_rows from suppliers group by SupplierID having count(*)>1;
#checking for NUll SupplierIDs
select * from suppliers where SupplierID is null;
#There is No Duplictae and Null values in SupplierID so craeting Primary key to the Suppliers table.
select *from suppliers;
desc suppliers;
Alter table suppliers modify SupplierID varchar(100);
Alter Table suppliers add primary key (supplierID);
show create table suppliers;
#Creating Primary key and foreign key to the products table.
#checking all ProductID values are unique and not NULL
#checking for duplicate ProductIDs.
select productID,count(*) AS duplicate_rows from products group by ProductID having count(*)>1;
#checking for NUll customerIDs
select * from products where ProductID is null;
#There is No Duplictae and Null values in ProductID so craeting Primary key to the Products table.
select* from products;
desc products;
Alter table products modify ProductID varchar(100),modify SupplierID varchar(100);
Alter table products add primary key (productID);
select distinct SupplierID from Products where SupplierID not in (select SupplierID from Suppliers);
select COUNT(*) AS MissingSupplierCount from Products p left join Suppliers s ON p.SupplierID = s.SupplierID  where s.SupplierID IS null;
INSERT INTO Suppliers (SupplierID, SupplierName, ContactPerson, Phone, City, State)
select distinct p.SupplierID,'Unknown Supplier' AS SupplierName,null AS ContactPerson,null AS Phone,null AS City,null AS State
from Products p left join Suppliers s on p.SupplierID = s.SupplierID where s.SupplierID is null;
Alter table products add foreign key (supplierID) references suppliers(supplierID);
#Creating Primary key and foreign key to the order_details table.
select * from order_details;
#checking all OrdreID and ProductID values are unique and not NULL
#checking for duplicate OrdreID and ProductID.
select orderID,productID,count(*) AS duplicate_rows from order_details group by orderID,ProductID having count(*)>1;
#The order_details table have duplicate values so wa are not able to create primary key so assigning both columns as forgien keys.
#checking for NUll customerIDs
select * from order_details where ProductID is null;
select * from order_details where OrderID is null;
#There is No  Null values in OrdreID and ProductID.
#craeting Foreign key to the Products table.
select* from order_details;
desc order_details;
ALTER TABLE order_details add foreign key(OrderID) REFERENCES Orders(OrderID);
ALTER TABLE order_details add foreign key(ProductID) REFERENCES Products(ProductID);
show create table order_details;
#Creating Primary key and foreign key to reviews table.
select * from reviews;
#checking all ReviewID,ProductID and CustomerID values are unique and not NULL
#checking for duplicate values ReviewID,ProductID and CustomerID.
select ReviewID,productID,CustomerID,count(*) AS duplicate_rows from reviews group by ReviewID,ProductID,CustomerID having count(*)>1;
#There is No Duplictae values in  ReviewID,ProductID and CustomerID. so craeting Primary key to the Products table.#checking for NUll customerIDs
select * from reviews where ReviewID is null;
select * from reviews where ProductID is null;
select * from reviews where CustomerID is null;
#There is No  Null values in ReviewID,ProductID and CustomerID.
#craeting Primary key and foreign key to the reviewa table
select* from reviews;
desc reviews;
Alter table reviews modify ReviewID varchar(100),modify ProductID varchar(100),modify CustomerID varchar(100);
ALTER TABLE reviews add primary key (ReviewID);
ALTER TABLE reviews add foreign key(ProductID) references Products(ProductID);
ALTER TABLE reviews add foreign key(customerID) references Customers(CustomerID);
show create table reviews;
#Task2 will be added in Ms word File
#Check Manually for Primary key,Foreign Key
show create table customers;
show create table products;
show create table products_new;
show create table categories;
show create table SubCategories;
show create table Orders;
show create table suppliers;
show create table Order_Details;
show create table Reviews;
#Task3
#Retrieve all customers from a specific city.
select * from customers where City='Bettyport';
#Fetch all products under the "Fruits" category.
select * from products where Category = 'fruits';
#Task 4 - Write DDL statements to recreate the Customers table with the following constraints:
#CustomerID as the primary key,Ensure Age cannot be null and must be greater than 18.,Add a unique constraint for Name.
create table Customers_1(CustomerID varchar(100) primary key,Name varchar(100) UNIQUE,Age INT NOT NULL CHECK (Age > 18),
Gender varchar(20),City varchar(100),State varchar(100),Country varchar(100),SignupDate date,PrimeMember varchar(10));
insert into Customers_1(CustomerID, Name, Age, Gender, City, State, Country, SignupDate, PrimeMember) VALUES
('017f1542-c856-480a-ba7a-0669181327be', 'Traci Walters', 26, 'Male', 'Bettyport', 'Wisconsin', 'India', '2020-07-18', 'Yes'),
('a923d2e4-987b-4e0d-9b5f-9b1b9e22f011', 'Mia Johnson', 32, 'Female', 'Greenland', 'Texas', 'USA', '2021-02-05', 'No'),
('b5a3c842-d772-4d94-8c31-8a87b720a34b', 'Rahul Mehta', 29, 'Male', 'Mumbai', 'Maharashtra', 'India', '2022-09-10', 'Yes'),
('c7f9a124-91a2-4f77-8301-5a38b31b7e3d', 'Emily Davis', 35, 'Female', 'London', 'England', 'UK', '2019-11-20', 'No'),
('d48a21ef-6782-4231-8d45-2e893f04b14a', 'Ahmed Khan', 40, 'Male', 'Dubai', 'Dubai', 'UAE', '2023-03-15', 'Yes');
insert into Customers_1(CustomerID, Name, Age, Gender, City, State, Country, SignupDate, PrimeMember) VALUES
('e91a4c20-8235-45e8-bbc1-f8fbd8a87902', 'Sophia Patel', 28, 'Female', 'Ahmedabad', 'Gujarat', 'India', '2021-05-10', 'Yes'),
('f53c41d5-7a61-4a9f-9e60-3b4cefa836cb', 'Liam Brown', 34, 'Male', 'New York', 'New York', 'USA', '2022-01-18', 'No'),
('a25c92e3-5bfa-4e89-b4a8-5fba5c08484d', 'Olivia Garcia', 30, 'Female', 'Madrid', 'Madrid', 'Spain', '2023-02-20', 'Yes'),
('b8d54fe4-943f-4b43-9a8e-942fd8271cde', 'Noah Wilson', 27, 'Male', 'Toronto', 'Ontario', 'Canada', '2020-12-14', 'No'),
('c19b8e43-842b-4b7e-8d9a-72e1d3b2a22f', 'Aarav Nair', 31, 'Male', 'Bangalore', 'Karnataka', 'India', '2021-10-03', 'Yes'),
('d76e24e2-61a2-4951-9ac2-f8c4eae9b3c2', 'Emma Thompson', 29, 'Female', 'Melbourne', 'Victoria', 'Australia', '2022-04-08', 'No'),
('e21f35b5-72a1-48c3-93b4-37f4bcb6dc84', 'Lucas Kim', 33, 'Male', 'Seoul', 'Seoul', 'South Korea', '2021-07-15', 'Yes'),
('f67d13b9-25e8-4e4a-9a7c-8e0c0fd7cf53', 'Chloe Martin', 24, 'Female', 'Paris', 'Île-de-France', 'France', '2023-05-05', 'Yes'),
('g12f49a8-914c-41e2-8e5c-7f1c9a442b13', 'Ethan Clark', 38, 'Male', 'Los Angeles', 'California', 'USA', '2020-09-09', 'No'),
('h87b24d9-67ac-4d93-9f51-98f3aaf04e21', 'Isabella Rossi', 36, 'Female', 'Rome', 'Lazio', 'Italy', '2021-03-12', 'Yes');
select * from customers_1;
#Task5 - Insert 3 new rows into the Products table using INSERT statements
select * from products;
Insert into Products(ProductID, ProductName, Category, SubCategory, PricePerUnit, StockQuantity, SupplierID) values
('f11b423a-39b1-4fd0-8e84-2e74b3b8d6c1', 'Golden Mango', 'Fruits', 'Tropical', 150.00, 500, '898ca408-050f-49be-b083-00eedf4bd064'),
('a2c35c44-9d8b-4f8c-b8f1-b3b5b2b67a8f', 'Organic Spinach', 'Vegetables', 'Leafy Greens', 80.00, 300, '0658c953-98c4-4d00-bf29-4fbfe4aca4cd'),
('b8d9a4c3-3fd2-4b0f-b7e1-2c1ad58b29a4', 'Almond Milk', 'Beverages', 'Dairy Alternatives', 220.00, 200, '70c9a542-3c8a-4b64-a90c-7dfdd6b04a99');
select * from products where category='Fruits' and ProductName='Golden Mango';
select ProductID,count(*) as Duplicate_row from products group by ProductID having count(*)>1;
#Task 6 - Update the stock quantity of a product where ProductID matches a specific ID.
update products set StockQuantity=140 where productID ='02c7c358-da33-4586-8e32-5e459b7394fc';
#Task 7 - Delete a supplier from the Suppliers table where their city matches a specific value.
set sql_safe_updates=0;
select * from suppliers;
delete from suppliers where city='Jessefurt';
#Task 8 -  Use SQL constraints
#Add a CHECK constraint to ensure that ratings in the Reviews table are between 1 and 5.
select	*from reviews;
alter table reviews add constraint check_rating check (Rating between 1 and 5);
show create table Reviews;
insert into Reviews (ReviewID, ProductID, CustomerID, Rating, ReviewText) values ('a001', 'b001', 'c001', 6, 'Exellent product!'); 
#Add a DEFAULT constraint for the PrimeMember column in the Customers table (default value: "No").
select * from customers;
desc customers;
alter table customers modify PrimeMember varchar(100);
alter table customers alter primeMember set default'No';
show create table customers;
#Task 9 
#WHERE clause to find orders placed after 2024-01-01.
select *from orders;
select * from orders where OrderDate > '2024-01-01';
#HAVING clause to list products with average ratings greater than 4.
select * from reviews;
select ProductID,avg(rating) AS Average_rating from reviews group by ProductID having avg(rating)>4;
#GROUP BY and ORDER BY clauses to rank products by total sales.
select * from products;
select * from order_details;
select p.productID,p.Productname,sum(od.quantity*od.unitprice) As Total_sales from order_details od inner join
products p on od.ProductID=p.ProductID group by p.ProductID,p.ProductName order by Total_sales Desc;
#Task 10 - Identifying High-Value Customers
#Amazon Fresh wants to identify top customers based on their total spending. We will:
select * from customers;
select * from orders;
select * from order_details;
#1.Calculate each customer's total spending.
select c.CustomerID,c.Name,sum(od.quantity*od.unitprice) As Total_Spending from customers c inner join
orders o on c.CustomerID=o.customerID inner join order_details od on o.OrderID=od.OrderID group by c.CustomerID,c.Name
order by Total_Spending desc;
#2.Rank customers based on their spending.
select c.customerID,c.name,sum(od.quantity*od.unitprice) As Total_Spending,Rank() over(order by sum(od.quantity*od.unitprice) desc) as Rank_Position from customers c inner join
orders o on c.CustomerID=o.customerID inner join order_details od on o.OrderID=od.OrderID group by c.CustomerID,c.Name;
#3.Identify customers who have spent more than ₹5,000.
select c.CustomerID,c.Name,sum(od.quantity*od.unitprice) As Total_Spending from customers c inner join
orders o on c.CustomerID=o.customerID inner join order_details od on o.OrderID=od.OrderID group by c.CustomerID,c.Name 
having sum(od.quantity*od.unitprice)>5000 order by Total_Spending desc;
#Task 11 - Use SQL to:
select * from customers;
select * from orders;
select * from order_details;
select * from products;
#Join the Orders and OrderDetails tables to calculate total revenue per order.
select o.orderID,sum(od.quantity*od.unitprice) As Total_Revenue from orders o inner join order_details od 
on o.orderID=od.OrderID group by OrderID order by Total_Revenue desc;
#Identify customers who placed the most orders in a specific time period.
select c.Name,c.CustomerID,count(o.orderID) As Total_Orders from customers c inner join orders o
on c.CustomerID=o.customerID where o.OrderDate between '2025-01-01' and '2025-10-01' 
group by c.Name,c.CustomerID order by Total_Orders Desc;
#Find the supplier with the most products in stock.
select s.supplierID,s.suppliername,sum(p.stockQuantity) As Total_Stock from suppliers s inner join products p
on s.SupplierID=p.SupplierID group by s.SupplierID,s.SupplierName order by Total_Stock desc;
select SupplierID,sum(StockQuantity) As Total_Stock from Products group by SupplierID order by Total_Stock desc;
#Task 12: Normalize the Products table to 3NF:
#Separate product categories and subcategories into a new table.
#Create foreign keys to maintain relationships.
create table Categories(CategoryID VARCHAR(50) primary key,CategoryName VARCHAR(100) not null);
insert into Categories(CategoryID, CategoryName) select distinct UUID(), Category FROM Products;
create table SubCategories_Clean AS select UUID() AS SubCategoryID,p.SubCategory AS SubCategoryName,min(c.CategoryID) AS CategoryID
FROM Products p JOIN Categories c ON p.Category = c.CategoryName GROUP BY p.SubCategory;
alter table SubCategories_Clean RENAME TO SubCategories;
alter table subcategories add foreign key (categoryID) references categories(categoryID);
insert into SubCategories(SubCategoryID, SubCategoryName, CategoryID) select distinct UUID(), p.SubCategory, c.CategoryID
FROM Products p JOIN Categories c ON p.Category = c.CategoryName;
create table Products_New(ProductID VARCHAR(100) primary key,ProductName VARCHAR(100) not null,SubCategoryID VARCHAR(50),
PricePerUnit decimal(10,2),StockQuantity int,SupplierID VARCHAR(100),FOREIGN KEY (SubCategoryID) REFERENCES SubCategories(SubCategoryID),
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID));
insert into Products_New(ProductID, ProductName,SubCategoryID,PricePerUnit,StockQuantity,SupplierID) select  
p.ProductID,p.ProductName,s.SubCategoryID,p.PricePerUnit,p.StockQuantity,p.SupplierID FROM Products p JOIN SubCategories s 
ON p.SubCategory = s.SubCategoryName;
#Checking atomicity.
select * from Products_New where ProductName LIKE '%,%' OR SubCategoryID is null;
#There is no values retrun so 1NF satisfied
#Checking foreign key integrity.
select count(*) AS InvalidSubCategories from Products_New p left join SubCategories s on p.SubCategoryID = s.SubCategoryID
where s.SubCategoryID IS NULL;
select count(*) AS InvalidSuppliers from Products_New p left join Suppliers sup on p.SupplierID = sup.SupplierID
where sup.SupplierID is null;
#The output retrun 0 referential integrity 3NF are valid.
#Task 13 - Write a subquery to
#Identify the top 3 products based on sales revenue.
select p.ProductID,p.ProductName,TotalRevenue FROM Products p inner join
(select ProductID,sum(Quantity * UnitPrice) AS TotalRevenue from Order_Details group by ProductID) AS RevenueData
on p.ProductID = RevenueData.ProductID order by TotalRevenue desc limit 3;
#Find customers who haven’t placed any orders yet.
select c.CustomerID,c.Name from Customers c left join Orders o on c.CustomerID = o.CustomerID where o.OrderID IS NULL;
#Task 14 - Provide actionable insights
#Which cities have the highest concentration of Prime members
select * from customers;
select city,count(*) As PrimeMember_Count from customers where primeMember='yes' group by city order by PrimeMember_Count desc;
#What are the top 3 most frequently ordered categories?
#For this task we use Normalized tables
select c.CategoryName,count(od.ProductID) AS Total_Orders from Order_Details od inner join Products_new p on od.ProductID = p.ProductID
join SubCategories sc on p.SubCategoryID = sc.SubCategoryID join Categories c on sc.CategoryID = c.CategoryID
group by c.CategoryName order by Total_Orders desc limit 3;