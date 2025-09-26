
#Run the following command to add and update dob column in employee table
select * from employee;
alter table  employee add dob date;
#update employee set dob = dateadd(year,-1*emp_age,getdate());
UPDATE employee
SET dob = DATE_SUB(CURDATE(), INTERVAL emp_age YEAR);
select * from employee;
#1- write a query to print emp name , their manager name and diffrence in their age (in days) 
#for employees whose year of birth is before their managers year of birth
#using self join on  e.manager_id=m.emp_id
select e.emp_name,m.emp_name,
datediff(e.dob,m.dob) as diff_days
from employee as e
inner join employee as m
on e.manager_id=m.emp_id
WHERE YEAR(e.dob) < YEAR(m.dob);

#2.write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
select * from superstore_orders;
select so.sub_category
from superstore_orders as so
left join  returns as r
on so.order_id=r.order_id
WHERE MONTH(STR_TO_DATE(so.order_date, '%m/%d/%Y')) = 11
group by so.sub_category
having count(r.order_id)=0;

#3.write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
select m.emp_name as manager_name,group_concat(e.emp_name,',') as employee_name
from employee as e
inner join employee as m
on e.manager_id=m.emp_id
group by m.emp_name;


#4- write a query to get number of business days between order_date and ship_date (exclude weekends). 
#Assume that all order date and ship date are on weekdays only.     
SELECT 
  order_id,
  (
    DATEDIFF(STR_TO_DATE(ship_date, '%m/%d/%Y'),
             STR_TO_DATE(order_date, '%m/%d/%Y')) + 1
    - (FLOOR((DATEDIFF(STR_TO_DATE(ship_date, '%m/%d/%Y'),
                       STR_TO_DATE(order_date, '%m/%d/%Y'))
       + DAYOFWEEK(STR_TO_DATE(order_date, '%m/%d/%Y'))) / 7) * 2)
    - (CASE WHEN DAYOFWEEK(STR_TO_DATE(order_date, '%m/%d/%Y')) = 1 THEN 1 ELSE 0 END)
    - (CASE WHEN DAYOFWEEK(STR_TO_DATE(ship_date, '%m/%d/%Y')) = 7 THEN 1 ELSE 0 END)
  ) AS diff_businessdays
FROM superstore_orders;
#5- write a query to print below 3 columns
#category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
select category,
sum(case when year(STR_TO_DATE(order_date, '%m/%d/%Y'))='2019' then sales end) as sales_2019,
sum(case when year(STR_TO_DATE(order_date, '%m/%d/%Y'))='2020' then sales end) as sales_2020
from superstore_orders
group by category;
select * from superstore_orders;
#6- write a query print top 5 cities in west region by average no of days between order date and ship date.
select city,
avg(datediff(str_to_date(order_date, '%m/%d/%y'),str_to_date(ship_date, '%m/%d/%y'))) as avg_days
from superstore_orders
where region='west'
group by city
order by avg_days
limit 5;
#7- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)
select e1.emp_name as emp_name, e2.emp_name as manager_name,e3.emp_name as senior_manager_name
from employee as e1
inner join employee as e2 on e1.manager_id=e2.emp_id
inner join employee as e3 on e2.manager_id=e3.emp_id;
#8-write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
#customer_name, first_name,last_name
#LOCATE(' ', full_name) finds the first space position from the left.
select customer_name,trim(substring(customer_name,1,locate(' ',customer_name))) as first_name,
SUBSTRING_INDEX(customer_name, ' ', -1) AS last_name,
SUBSTRING(customer_name, LOCATE(' ', customer_name) + 1) as last_2_names
from superstore_orders;
#9- 
create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

#write a query to print below output using drivers table. 
#Profit rides are the no of rides where end location and end_time of a ride is same as start location ans start time of the next ride for a driver
#id, total_rides , profit_rides
#dri_1,5,1
#dri_2,2,0
select d1.id,count(d1.id) as total_rides,count(d2.id) as profit_rides
from drivers d1
left join drivers d2
on d1.id=d2.id and d1.end_time=d2.start_time and d1.end_loc=d2.start_loc
group by d1.id;
/*
10-write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies */
select 'category' as hierarchy_type,category as hierarchy_name,
sum(case when region='west' then sales end) as total_sales_in_west_region,
sum(case when region='east' then sales end) as total_sales_in_east_region
from superstore_orders
group by category
union all
select 'sub_category', sub_category,
sum(case when region='west' then sales end) as total_sales_in_west_region,
sum(case when region='east' then sales end) as total_sales_in_east_region
from superstore_orders
group by sub_category
union all
select 'ship_mode',ship_mode,
sum(case when region='west' then sales end) as total_sales_in_west_region,
sum(case when region='east' then sales end) as total_sales_in_east_region
from superstore_orders
group by ship_mode
