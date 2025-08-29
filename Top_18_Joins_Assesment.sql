#1- write a query to get total sales for each profit group. Profit groups are defined as  
#profit < 0 -> Loss
#profit < 50 -> Low profit
#profit < 100 -> High profit
#profit >=100 -> very High profit

create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');

select 
case
when profit < 0 then 'loss'
when profit < 50 then 'low Profit'
when profit < 100  then 'High profit'
else 'very high profit'
end as profit_bucket
,sum(sales) as total_sales
from superstore_orders
group by
case
when profit < 0 then 'loss'
when profit < 50 then 'low Profit'
when profit < 100  then 'High profit'
else 'very high profit'
end;

#2- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
#write a query to find order ids where there is only 1 product bought by the customer.
select order_id 
from superstore_orders
group by order_id
having count(order_id)=1;

#3- write a query to get total profit, first order date and latest order date for each category
select * from superstore_orders;
select category,sum(profit) as total_profit,min(order_date)as first_order_date,
max(order_date)as latest_order_date
from superstore_orders
group by category;

#4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category (validate the output using excel)
select * from superstore_orders;
select sub_category
from superstore_orders
group by sub_category
having avg(profit) > max(profit)/2;

#5.
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

#5.write a query to find students who have got same marks in Physics and Chemistry.
select student_id,marks from exams
where subject in ('Chemistry','physics')
group by student_id,marks
having count(*)=2;

#6- write a query to find total number of products in each category.
select category,count(distinct product_id) as total_no_products
from superstore_orders
group by category;

#7.write a query to find top 5 sub categories in west region by total quantity sold
select sub_category,sum(quantity) as total_quantity 
from superstore_orders
where region='west'
group by sub_category
order by total_quantity desc
limit 5;

# write a query to find total sales for each region and ship mode combination for orders in year 2020
select * from superstore_orders;
SELECT region,ship_mode,SUM(sales) AS total_sales
FROM superstore_orders
#STR_TO_DATE(order_date, '%m/%d/%Y') converts the text '2/26/2021' to a proper date.
WHERE STR_TO_DATE(order_date, '%m/%d/%Y') #year-date-month
      BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY region, ship_mode
ORDER BY region, ship_mode;

 #write a query to get region wise count of return orders
 select * from returns;
 select o.region,count(distinct o.order_id) as return_order_count
 from superstore_orders as o
 join returns as r
 on o.order_id=r.order_id
 group by o.region;
 
 #10- write a query to get category wise sales of orders that were not returned
 select o.category,sum(o.sales) as total_sales
 from superstore_orders as o
 left join returns as r
 on o.order_id=r.order_id
 where r.order_id is null
 group by category;

#11- write a query to print dep name and average salary of employees in that dep .
select  d.dep_name,avg(e.salary) as average_salary
from employee as e
join dept as d
on e.dept_id=d.dep_id
group by d.dep_name;
#12- write a query to print dep names where none of the emplyees have same salary.
select  d.dep_name
from employee as e
join dept as d
on e.dept_id=d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary);

#13. write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
select o.sub_category
from superstore_orders as o
join returns as r
on o.order_id=r.order_id
group by o.sub_category
having count(distinct r.return_reason)=3;
#select * from 
#14- write a query to find cities where not even a single order was returned.
select o.city
from superstore_orders as o
left join returns as r
on o.order_id=r.order_id
group by o.city
having count(r.order_id)=0;
#15- write a query to find top 3 subcategories by sales of returned orders in east region
select o.sub_category,sum(sales) as total_sales
from superstore_orders as o
inner join returns as r
on o.order_id=r.order_id
where region='East'
group by o.sub_category
order by total_sales desc
limit 3;

#16- write a query to print dep name for which there is no employee

select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
where e.dept_id is null;

#17- write a query to print employees name for which dep id is not present in dept table
select e.emp_name
from dept d 
right join employee e on e.dept_id=d.dep_id
where d.dep_id is null;

#18- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
select o.category ,sum(o.sales) as total_sales,sum(case when r.order_id is not null then sales end) as total_sale_returned
from superstore_orders o
left join returns r on o.order_id=r.order_id
group by o.category




