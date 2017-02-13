--1:Return all category names with their descriptions from the Categories table.
SELECT CategoryName, [Description]
FROM Categories



--2:Return the contact name, customer id, and company name of all Customers in London
SELECT ContactName, CustomerID, CompanyName
FROM Customers
WHERE City = 'London'

--3:Return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
select * 
from Suppliers
where (ContactTitle = 'Marketing Manager' OR ContactTitle='Sales Representative') AND Fax IS NOT NULL

--4:Return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.
select OrderID, CustomerID,RequiredDate,Freight
from Orders
where (RequiredDate between '1997-01-01' AND '1998-01-01') AND Freight<100

--5:Return a list of company names and contact names of all the Owners from the Customer table from Mexico, Sweden and Germany.
select * 
from Customers
where ContactTitle = 'Owner' AND Country IN ('Mexico','Sweden','Germany')

--6:Return a count of the number of discontinued products in the Products table.
select COUNT(Discontinued) AS 'Number of discontinued products'
from Products
where Discontinued = 1

--7:Return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
select * 
from Categories
where CategoryName LIKE 'Co%'

--8:Return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
select CompanyName, City, Country, [Address]
from Suppliers
where [Address] LIKE '%rue%'
order by CompanyName

--9:Return the product id and the total quantities ordered for each product id in the Order Details table.
select ProductID, SUM(Quantity) AS 'Total quantities ordered for each product'
from [Order Details]
group by ProductID
order by ProductID

--10:Return the customer name and customer address of all customers with orders that shipped using Speedy Express.
select c.ContactName, c.Address, s.CompanyName
from Orders o 
inner join Customers c ON o.CustomerID = c.CustomerID
inner join Shippers s ON o.ShipVia = s.ShipperID
where s.CompanyName = 'Speedy Express'
order by ContactName

--11:Return a list of Suppliers that have regions. The list should contain company name, contact name, contact title and region.
select CompanyName, ContactName, ContactTitle, Region
from Suppliers
where Region is not null
order by Region

--12:Return all product names from the Products table that are condiments.
select p.ProductName
from Products p
inner join Categories c ON p.CategoryID = c.CategoryID
where CategoryName ='Condiments'
order by p.ProductName

--13:Return a list of customer names who have no orders in the Orders table.

select c.CustomerID, o.OrderID
from Orders o full outer join  Customers c ON c.CustomerID=o.CustomerID
where o.OrderID IS NULL
group by c.CustomerID, o.OrderID

--14:Add a shipper named 'Amazon' to the Shippers table using SQL.
insert into Shippers(CompanyName,Phone)
values('Amazon','123-456-7890')

select * 
from Shippers

--15:Change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
UPDATE Shippers
SET CompanyName='Amazon Prime Shipping' 
Where ShipperID=4

select * 
from Shippers

--16:Return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
select s.CompanyName, ROUND(SUM(Freight),0) AS 'Freight Total'
from Orders o
inner join Shippers s ON o.ShipVia=s.ShipperID
group by s.CompanyName
order by s.CompanyName

--17:Return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
select (LastName + ', ' + FirstName) AS 'DisplayName'
from Employees

--18:Add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
insert into Customers(CustomerID,CompanyName,ContactName,ContactTitle,Address,City,PostalCode,Country,Phone)
values('GIO','AmazingTech','Giovanni Balarezo', 'Owner','1954 Transite Ave', 'San Diego','92154','USA','(619) 734-5895')
insert into Orders(CustomerID, OrderDate,ShipVia,ShipAddress,ShipCity,ShipPostalCode,ShipCountry)
values('GIO','2017-02-8','4','101 W Broadway','San Diego', '92101', 'USA')
insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
values(
(select TOP 1 OrderID from Orders where CustomerID = 'GIO' ),
(select ProductID from Products where ProductName ='Grandma''s Boysenberry Spread'),
(select UnitPrice from Products where ProductName= 'Grandma''s Boysenberry Spread'),
13,
0 
)



select * 
from Customers

select * 
from Orders

select * from [Order Details]


--19:Remove yourself and your order from the database.
Delete From [Order Details]
Where OrderID=(Select TOP 1 OrderID from Orders Where CustomerID='GIO')
Delete From Orders 
WHere CustomerID='GIO'
Delete From Customers
Where CustomerID = 'GIO'

SELECT * From [Order Details]
Where OrderID=(Select TOP 1 OrderID from Orders Where CustomerID='GIO')
SELECT * From Orders 
WHere CustomerID='GIO'
SELECT * From Customers
Where CustomerID = 'GIO'

--20:Return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
select * from Products where UnitsInStock>100 order by UnitsInStock




