# SQL_Project_Business_Task


# AdventureWorks SQL Queries 📊

This repository contains a series of SQL queries designed to explore and analyze the AdventureWorks database. Each query targets a specific business question or transformation challenge, ranging from filtering and sorting data, joining multiple tables, to applying logic for segmentation and financial computations.

## 🧠 Query Descriptions

### 1. Filter Products by Color and Price
We filter out products whose colors are null, red, silver/black, or white, and only keep those within a price range of £75 to £750. We rename `StandardCost` to `price` for clarity, and sort the results by price descending.

### 2. Select Employees by Gender, Birth Year, and Hire Date
This query retrieves:
- Male employees born between 1962 and 1970, hired after 2001
- Female employees born between 1972 and 1975, hired between 2001 and 2002

### 3. Top 10 Most Expensive ‘BK’ Products
Lists the top 10 products whose product numbers start with ‘BK’, showing product ID, name, color, and price.

### 4. Contact Match Logic
Retrieves contacts where:
- The first four letters of the last name match the first four of the email
- The first letter of the first name equals the first letter of the last name
It then creates a full name column and calculates its length.

### 5. Subcategories with Long Manufacturing Time
Returns product subcategories whose average manufacturing time is 3 days or more.

### 6. Product Price Segmentation
Segments products based on their price range:
- <£200: Low Value
- £201–£750: Mid Value
- £751–£1250: Mid to High Value
- >£1250: Higher Value
Only applies to black, silver, and red products.

### 7. Count of Unique Job Titles
Simple query to count the number of distinct job titles in the employee table.

### 8. Calculate Employee Age at Hire
Finds the age of each employee at the time they were hired.

### 9. Long Service Award Eligibility
Calculates how many employees will complete 20 years of service within the next 5 years.

### 10. Years Left Until Sentiment
Estimates how many more years each employee has before reaching retirement age (65).

### 11. New Pricing Policy Based on Color
Implements a pricing strategy:
- White: +8%
- Yellow: −7.5%
- Black: +17.2%
- Multi/Silver/Silver-Black/Blue: square root × 2
Also calculates a 37.5% commission on the new price.

### 12. Sales Person and Quota Overview
Lists salespeople along with their job titles, hire dates, sick leave hours, region, and sales quota.

### 13. Comprehensive Product Sales Insights
Pulls together a rich report showing:
- Product, category, and subcategory names
- Salesperson
- Revenue
- Month and quarter of the transaction
- Region

### 14. Order and Sales Details
Displays:
- Order number, date, total due
- Customer name
- Salesperson involved
- Whether it was an online order

### 15. Product Commission and Margin Calculation
For each product, calculates:
- Commission as 14.79% of standard cost
- Margin based on dynamic standard cost adjustments depending on product color

### 16. View: Top 5 Most Expensive Products per Color
Defines a view to return the top 5 most expensive products within each product color group.

---

💡 **Note:** These queries are built on Microsoft SQL Server using the AdventureWorks sample database. Adjustments might be needed for compatibility with other environments or schemas.

---
