/***Question 1: Retrieve information about the products with color values except null, Red, silver/black, white and 
list price between £75 and £750. Rename the column StandardCost to price. Also, sort the result in descending 
order by list price***/

SELECT 
[ProductID] 
,[Name] 
,[Color] 
,[StandardCost] AS price 
,[ListPrice] 
FROM [Production].[Product] 
WHERE  
[Color] not in ('Null','Red','Silver/black','White') 
and [ListPrice] BETWEEN 75 and 750 
ORDER BY price DESC;

/***Question 2: Find all the male employees born between 1962 to 1970 and with hire date greater than 2001 and 
female employees born between 1972 and 1975 and hire date between 2001 and 2002.***/

SELECT 
[NationalIDNumber] 
,[Gender] 
,[BirthDate] 
,[HireDate] 
FROM [HumanResources].[Employee] 
WHERE  
[Gender]='M' 
and YEAR([BirthDate]) BETWEEN 1962 AND 1970  
and YEAR([HireDate])>2001 
or  
[Gender]='F'  
and YEAR([BirthDate]) BETWEEN 1972 AND 1975  
and YEAR([HireDate]) BETWEEN 2001 AND 2002 

/***Question 3: Create a list of 10 most expensive products that have a product number beginning with ‘BK’.  
Include only the product ID, Name and colour.***/

SELECT TOP 10  
[ProductID],[Name],[Color],[ListPrice] 
FROM [Production].[Product] 
WHERE[ProductNumber] LIKE'BK%' 
ORDER BY [ListPrice] DESC; 


/***Question 4:  Create a list of all contact persons, where the first 4 characters of the last name are the same as 
the first four characters of the email address. Also, for all contacts whose first name and the last name begin with 
the same characters, create a new column called full name combining first name and the last name only. Also 
provide the length of the new column full name.***/

SELECT 
A.[FirstName] 
,A. [LastName] 
,B.[EmailAddress] 
,CONCAT([FirstName],'  ',[LastName]) AS FULL_NAME 
,LEN([FirstName]+[LastName]) AS LENTH_FULLNAME 
FROM [Person].[Person] AS A 
INNER JOIN[Person].[EmailAddress] AS B 
ON A.[BusinessEntityID] 
=  B.[BusinessEntityID] 
WHERE  
LEFT([LastName],4) =LEFT([EmailAddress],4) 
AND LEFT([FirstName],1)=LEFT([LastName],1); 


/***Question 5: Return all product subcategories that take an average of 3 days or longer to manufacture***/ 
SELECT 
PSC.Name 
,AVG([DaysToManufacture]) AS [Average Manu. Days] 
FROM [Production].[Product] AS PP 
LEFT JOIN [Production].[ProductSubcategory] AS PSC 
ON PP.ProductSubcategoryID  
=  PSC.ProductSubcategoryID 
GROUP BY PSC.Name 
HAVING  AVG([DaysToManufacture]) >= 3;


/***Question 6: Create a list of product segmentation by defining criteria that places each item in a predefined 
segment as follows. If price gets less than £200 then low value. If price is between £201 and £750 then mid 
value. If between £750 and £1250 then mid to high value else higher value.  Filter the results only for black, silver 
and red color products***/

SELECT 
[Name] 
,[ListPrice] 
,[Color] 
,CASE 
WHEN [ListPrice] >=0 AND [ListPrice]<=200 THEN 'Low Value'  
WHEN [ListPrice] <=750 THEN 'Mid_Value' 
WHEN  [ListPrice]<=1250 THEN 'Mid_to_high_Value' 
ELSE 'Higher Value' 
END AS 'Price_segmentation' 
FROM [Production].[Product] 
WHERE [Color] IN ('Black','Silver','Red') 
ORDER BY [ListPrice];


/***Question 7: How many Distinct Job title are present in the Employee table***/

SELECT COUNT (DISTINCT[JobTitle]) AS Number_distinct_Jobtitle 
FROM [HumanResources].[Employee]; 

/***Question 8: Use employee table and calculate the ages of each employee at the time of hiring***/

SELECT  
[BusinessEntityID] 
,[BirthDate] 
,[HireDate] 
,DATEDIFF(YEAR,[BirthDate],[HireDate]) AS AGE_AT_HIREDAY 
FROM [HumanResources].[Employee]

/***Question 9: How many employees will be due a long service award in the next 5 years, if long service is 20 
years?***/

SELECT 
COUNT(DATEDIFF(YY,[HireDate],DATEADD(YY,5,GETDATE()))) as years_of_work 
FROM [HumanResources].[Employee] 
WHERE DATEDIFF(YY,[HireDate],DATEADD(YY,5,GETDATE()))>=20;


/***Question 10: How many more years does each employee have to work before reaching sentiment, if sentiment 
age is 65?***/ 

SELECT 
[BusinessEntityID] 
,NationalIDNumber 
,65-Datediff(yy,[BirthDate],GETDATE()) as Years_to_work_before_Sentiment 
FROM[HumanResources].[Employee] 
WHERE 65-Datediff(yy,[BirthDate],GETDATE()) > 0


/***Question 11: Implement new price policy on the product table base on the colour of the item If white increase 
price by 8%, If yellow reduce price by 7.5%, If black increase price by 17.2% . If multi, silver, silver/black or blue 
take the square root of the price and double the value. Column should be called Newprice. For each item, also 
calculate commission as 37.5% of newly computed list price.***/

SELECT  
[Color] 
,[ListPrice] 
,CASE  
WHEN [Color] ='White' THEN CAST([ListPrice] * 1.08 AS 
Decimal(18,3)) 
WHEN [Color] ='Yellow' THEN CAST([ListPrice] * 0.925 AS 
Decimal(18,3)) 
WHEN [Color] ='Black' THEN CAST([ListPrice] * 1.172 AS 
Decimal(18,3)) 
WHEN [Color] IN ('Multi','Silver','Silver/Black','Blue') THEN 
CAST(SQRT([ListPrice]) *2 AS Decimal(18,3)) 
ELSE [ListPrice] 
END AS NewPrice 
,CASE
WHEN [Color] ='White' THEN CAST([ListPrice] * 1.08  * 0.375 AS 
Decimal(18,3)) 
WHEN [Color] ='Yellow' THEN CAST([ListPrice] * 1.075  * 0.375 AS 
Decimal(18,3)) 
WHEN [Color] ='Black' THEN CAST([ListPrice] * 1.172  * 0.375 AS 
Decimal(18,3)) 
WHEN [Color] IN ('Multi','Silver','Silver/Black','Blue') THEN 
CAST(SQRT([ListPrice]) * 2  * 0.375 AS Decimal(18,3)) 
ELSE CAST([ListPrice] * 0.375 AS Decimal(18,3)) 
END AS NewCommission 
FROM [Production].[Product] 
WHERE [Color] IS NOT NULL

/***Question 12: Print the information about all the Sales.Person and their sales quota. For every Sales person you 
should provide their FirstName, LastName, HireDate, SickLeaveHours and Region where they work***/

SELECT 
FirstName + ' ' + LastName AS SalesPerson 
,JobTitle 
,C.HireDate 
,C.SickLeaveHours 
,D.Name AS Region 
,SalesQuota 
FROM Sales.SalesPerson AS A 
INNER JOIN Person.Person AS B 
ON B.BusinessEntityID  
= A.BusinessEntityID 
INNER JOIN HumanResources.Employee AS C 
ON A.BusinessEntityID  
= C.BusinessEntityID 
LEFT JOIN Sales.SalesTerritory AS D 
ON D.TerritoryID  
= A.TerritoryID 

/***Question 13: Using adventure works, write a query to extract the following information: Product name • Product 
category name • Product subcategory name  • Sales person • Revenue • Month of transaction  • Quarter of 
transaction • Region***/

SELECT Product.Name AS [ProductName], 
ProductCategory.Name AS [ProductCategory], 
ProductSubcategory.Name AS [ProductSubcategory], 
CONCAT(FirstName, ' ', LastName) AS [SalesPersonName], 
LineTotal AS [Revenue], 
DATENAME(mm,OrderDate) AS [MonthOfTransaction], 
DATEPART(qq,OrderDate) AS [QuarterOfTransaction], 
CASE 
WHEN UPPER(SalesTerritory.Name) = UPPER(CountryRegion.Name) 
THEN CountryRegion.Name 
ELSE CONCAT(SalesTerritory.Name, ' of ', CountryRegion.Name) 
END AS [SalesRegion] 
FROM Sales.SalesOrderHeader 
INNER JOIN Sales.SalesOrderDetail 
ON Sales.SalesOrderHeader.SalesOrderID
         = Sales.SalesOrderDetail.SalesOrderID 
     INNER JOIN Production.Product 
        ON Sales.SalesOrderDetail.ProductID 
         = Production.Product.ProductID 
      LEFT JOIN Production.ProductSubcategory 
        ON Production.Product.ProductSubcategoryID 
         = Production.ProductSubcategory.ProductSubcategoryID 
      LEFT JOIN Production.ProductCategory 
        ON Production.ProductSubcategory.ProductCategoryID 
         = Production.ProductCategory.ProductCategoryID 
     INNER JOIN Person.Person 
        ON Sales.SalesOrderHeader.SalesPersonID 
         = Person.Person.BusinessEntityID 
     INNER JOIN Sales.SalesTerritory 
        ON Sales.SalesOrderHeader.TerritoryID 
         = Sales.SalesTerritory.TerritoryID 
     INNER JOIN Person.CountryRegion 
        ON Sales.SalesTerritory.CountryRegionCode 
         = Person.CountryRegion.CountryRegionCode;

/***Question 14: Display the information about the details of an order i.e. order number, order date, amount of order, 
which customer gives the order and which salesman works for that customer and how much commission he gets 
for an order.***/
  
SELECT  
 A.SalesOrderID 
 ,A.OrderDate 
 ,A.TotalDue 
 ,OnlineOrderFlag 
 ,C.Name AS CustomerName 
 ,FirstName + ' ' + LastName AS SalesPerson 
 
FROM Sales.SalesOrderHeader AS A 
 
 LEFT JOIN Sales.Customer AS B 
  ON B.CustomerID  
  = A.CustomerID 
 
 LEFT JOIN Sales.Store AS C 
  ON B.StoreID  
  = C.BusinessEntityID 
 
 LEFT JOIN Person.Person AS D 
  ON D.BusinessEntityID  
  = A.SalesPersonID 


    
/***Question 15: For all the products calculate  • Commission as 14.790% of standard cost,  • Margin, if standard 
cost is increased or decreased as follows: o Black: +22%, o Red: -12% o Silver: +15% o Multi: +5% o White: Two 
times original cost divided by the square root of cost o For other colors, standard cost remains the same***/
 
 SELECT 
  [Name] 
 ,[Color] 
 ,[StandardCost] 
 ,ListPrice 
 ,CAST([StandardCost]*0.14790 AS DECIMAL(18,2)) AS Commission 
 ,CASE 
  WHEN [Color]='Black' THEN Listprice-([StandardCost]*1.22) 
  WHEN [Color]='Red' THEN  Listprice-([StandardCost] * 0.88) 
  WHEN [Color]='Silver' THEN  Listprice -([StandardCost]*1.15) 
  WHEN [Color]='Multi' THEN  Listprice-([StandardCost]*0.05) 
  WHEN [Color]='White' THEN  Listprice -(([StandardCost]*2)/(SQRT([StandardCost]*0.14790))) 
  ELSE  [StandardCost] 
  END AS 'Margin' 
  FROM[Production].[Product] 
  WHERE Standardcost <> 0;
 
/***Question 16: Create a view to find out the top 5 most expensive products for each color***/

CREATE VIEW Expen_products AS ( 
SELECT  
pp.[name] AS [Name] 
,pp.color Color 
,pp.Listprice 
,DENSE_RANK() OVER (PARTITION BY pp.color ORDER BY pp.listprice 
DESC) 'Ranked' 
FROM Production.Product pp 
) 
SELECT * FROM Expen_products WHERE Ranked <=5 