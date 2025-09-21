# Analytics-Bootcamp 
# SQL for analytics

Introduction to SQL, DDL/DML/DQL, filtering, sorting, aggregation, joins, window functions, CTEs, subqueries, stored procedures, indexing, views, recursive CTEs. Includes portfolio projects (e.g., credit card transactions, hotel bookings).

# Top 18 SQL Questions Using JOINs
A collection of **18 SQL practice questions** focusing on mastering different types of `JOIN`s to combine and analyze relational datasets.  
This project is part of my SQL learning journey (inspired by Namaste SQL Bootcamp by Ankit Bansal).

---

## 📚 Topics Covered
- **INNER JOIN** – Matching records across tables.
- **LEFT JOIN / RIGHT JOIN** – Preserving rows from one table.
- **FULL OUTER JOIN** – Combining all rows, matching where possible.
- **SELF JOIN** – Joining a table with itself.
- **CROSS JOIN** – Cartesian products.
- **Multiple JOINs** – Combining more than two tables.
- **Aliasing & Filtering** – Clean query writing with `AS` and `WHERE`.
- **Aggregation with JOINs** – `GROUP BY`, `HAVING` on multi-table results.

---

## 📝 Sample Questions
Some example tasks from the 18-question set:
# 🗄️ 18 SQL Questions Using JOINs

A collection of **18 SQL practice questions** focusing on mastering different types of `JOIN`s to combine and analyze relational datasets.  
This project is part of my SQL learning journey (inspired by Namaste SQL Bootcamp by Ankit Bansal).

1. write a query to get total sales for each profit group. Profit groups are defined as  
profit < 0 -> Loss
profit < 50 -> Low profit
profit < 100 -> High profit
profit >=100 -> very High profit


2. orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.


3.  write a query to get total profit, first order date and latest order date for each category
   
4.  write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category (validate the output using excel)

   
5. create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);
insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

5. write a query to find students who have got same marks in Physics and Chemistry.
   
6.  write a query to find total number of products in each category.

7.  write a query to find top 5 sub categories in west region by total quantity sold

8.  write a query to find total sales for each region and ship mode combination for orders in year 2020
   
10.  write a query to get region wise count of return orders
    
10- write a query to get category wise sales of orders that were not returned

11- write a query to print dep name and average salary of employees in that dep .

12- write a query to print dep names where none of the emplyees have same salary.

13- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

14- write a query to find cities where not even a single order was returned.

15- write a query to find top 3 subcategories by sales of returned orders in east region

16- write a query to print dep name for which there is no employee

17- write a query to print employees name for which dep id is not present in dept table

18. write a query to print 3 columns : category, total_sales and (total sales of returned orders)
---

---

## 🛠️ Tech & Tools
- **SQL Dialect**: MySQL 
- **Tables Used**: `customers`, `orders`, `employees`, `departments`, `products`, etc.



