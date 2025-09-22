-- imported the data using Tabke data import

use monday_coffee_house;

-- finding null values
SELECT *
FROM city
WHERE city_id IS NULL;

SELECT *
FROM city
WHERE city_name IS NULL;

SELECT *
FROM city
WHERE population IS NULL;

SELECT *
FROM city
WHERE estimated_rent IS NULL;

SELECT *
FROM city
WHERE city_rank IS NULL;

Select * from customers
where customer_id IS null;

select * from customers
where city_id is null;

select * from products
where product_id is null;

select * from products
where product_name is null;

select * from products
where price is null;

select * from sales
where sale_id is null;

select * from sales 
where sale_date is null;

select * from sales
where product_id is null;

select * from sales
where quantity is null;

select * from sales
where customer_id is null;

select * from sales
where total_amount is null;

select * from sales
where rating is null;

-- checking for duplicates in customers table
select customer_id, customer_name,city_id, count(*) as Duplicates
from customers
group by customer_id, customer_name, city_id
having count(*)>1;

-- to find a mismatch between tables
SELECT 
    s.total_amount,
    s.quantity,
    p.price,
    (s.quantity * p.price) AS calculated_price
FROM sales s
JOIN products p 
    ON s.product_id = p.product_id
WHERE s.total_amount != (s.quantity * p.price);

-- comprehensive analysis
select 
s.sale_id,
s.sale_date,
s.quantity,
s.product_id,
s.customer_id,
s.total_amount,
s.rating,
c.customer_name,
c.city_id,
ci.city_name,
ci.city_rank,
ci.estimated_rent,
ci.population,
p.product_name,
p.price
from sales s
join products p 
on s.product_id=p.product_id
join customers c
on 
s.customer_id=c.customer_id
join city ci
on 
c.city_id=ci.city_id
order by s.sale_date Desc;

-- total sales per city
select
ci.city_name,
sum(s.total_amount) as total_sales
from sales s
join customers c
on 
s.customer_id=c.customer_id
join city ci
on 
ci.city_id=c.city_id
group by ci.city_name

order by total_sales desc;

-- total transactions per city
select
ci.city_name,
count(s.sale_id) as total_transactions_per_city
from sales s
join customers c
on 
s.customer_id=c.customer_id
join city ci
on 
ci.city_id=c.city_id
group by ci.city_name
order by total_transactions_per_city desc;

-- counting unique customers
select 
ci.city_name,
count( DISTINCT customer_name) As Unique_customers
from sales s
join customers c on
s.customer_id=c.customer_id
join city ci on
c.city_id=ci.city_id
group by city_name
order by Unique_customers desc;

-- Avg order value per city
select 
ci.city_name,
Avg(s.total_amount) as Avg_order_value_per_city
from sales s
join customers c
on s.customer_id=c.customer_id
join city ci
on c.city_id=ci.city_id
group by city_name
order by Avg_order_value_per_city desc;

-- product demand per city
select
ci.city_name,
count(s.product_id) as product_demand_per_city
from sales s
join products p
on s.product_id=p.product_id
join customers c
on s.customer_id=c.customer_id
join city ci 
on c.city_id=ci.city_id
group by city_name
order by product_demand_per_city desc;

-- monthly sales trends
SELECT
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    SUM(s.total_amount) AS total_sales,
    COUNT(s.sale_id) AS total_orders,
    AVG(s.total_amount) AS avg_order_value
FROM sales s
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY month;

-- top 3 cities based on sales
select
ci.city_name,
sum(s.total_amount) as total_sales
from sales s
join customers c
on 
s.customer_id=c.customer_id
join city ci
on 
ci.city_id=c.city_id
group by ci.city_name
order by total_sales desc
limit 3;

-- top 3 cities based on unique customers

select 
ci.city_name,
count( DISTINCT customer_name) As Unique_customers
from sales s
join customers c on
s.customer_id=c.customer_id
join city ci on
c.city_id=ci.city_id
group by city_name
order by Unique_customers desc
Limit 3;

-- top 3 cities based on order count
select
ci.city_name,
count(s.sale_id) as total_sales_per_city
from sales s
join customers c
on 
s.customer_id=c.customer_id
join city ci
on 
ci.city_id=c.city_id
group by ci.city_name
order by total_sales_per_city desc
limit 3;

/*Final Recommendations
1. Expand Coffee Shop Locations**: Increase the number of coffee shops in cities where sales are high and demand is strong.
2. Boost Sales in Average Markets**: In cities with average sales, implement strategies to increase revenue, such as offering discounts and introducing loyalty programs. For example, customers could earn a "bean" for each coffee purchased, and after collecting five beans, they could receive a complimentary coffee.
3. Open Shops in High-Traffic Areas: Consider opening new shops in locations with high foot traffic, such as stadiums, shopping malls, and universities, to enhance sales.
4. Special Offers for Students and Professionals: Create targeted promotions for students and working professionals to attract these key demographics. */
