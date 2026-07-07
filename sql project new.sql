
# 3. Get month on month number of orders

SELECT
 EXTRACT( MONTH FROM order_purchase_timestamp ) as month,
EXTRACT( YEAR  FROM order_purchase_timestamp ) as year,
COUNT(*) as num_orders
from `TARGET_SQL.orders`
GROUP BY year, month
ORDER BY year, month

#2.Distribution of customers across the states of brazil

 SELECT Customer_city, customer_state,
 COUNT(DISTINCT customer_id) as customer_count
 FROM `TARGET_SQL.customers2`
 GROUP BY  customer_city, customer_state
 ORDER BY customer_count DESC;

# Get the % increase in the cost of orders from year 2017 to 2018
#(include months between Jan to Aug only).
#You can use the "payment_value" column in the payments table to get
#the cost of orders.

# STEP 1: Calculate total payment per year
with yearly_totals as (
SELECT
EXTRACT(YEAR from o.order_purchase_timestamp) as year,
SUM(p.payment_value) as total_payment
FROM `TARGET_SQL.payments` as p
JOIN `TARGET_SQL.orders` as o
ON p.order_id = o.order_id
WHERE EXTRACT(YEAR from o.order_purchase_timestamp) in (2017,2018)
and EXTRACT(month from o.order_purchase_timestamp) between 1 and 8
GROUP BY EXTRACT(YEAR from O.order_purchase_timestamp) 
),

# STEP 2: Use LEAD window function to compare each year's payments with the previous year
Yearly_comparisons AS (
SELECT
year,
total_payment,
LEAD(total_payment) over (order by year desc) as prev_year_payment
from yearly_totals
)
# STEP 3: Calculate % increase
SELECT round(((total_payment - prev_year_payment) / prev_year_payment)*100,2)
FROM yearly_comparisons;

# mean & sum of price and freight value by customer state

SELECT
c.customer_state,
AVG(Price) as avg_price
SUM(price) as sum_price
AVG(freight_value) as avg_freight,
SUM(freight_value) as sum_freight,
FROM `TARGET_SQL.orders` as o
JOIN `TARGET_SQL.order_items` as oi
ON o.order_id = oi.order_id
JOIN `TARGET_SQL.customers2` as c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state;

# Calculate days between purchasing the order delivering the order and estimated delivery.

SELECT order_id,
DATE_DIFF( DATE(order_delivered_customer_date),DATE(order_purchase_timestamp),DAY) as days_to_delivery,
DATE_DIFF( DATE(order_delivered_customer_date),DATE(order_estimated_delivery_date),DAY) as diff_estimated_delivery
from `TARGET_SQL.orders`;

# find out the top 5 states with highest & lowest average freight value

SELECT c. customer_state,
AVG(freight_value) as avg_freight_value
FROM `TARGET_SQL.orders` as o
JOIN `TARGET_SQL.order_items`as oi
ON O.order_id = oi.order_id
JOIN `TARGET_SQL.customers2` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY  avg_freight_value DESC
LIMIT 5



# find out the top 5 states with the highest and lowest average delivery time


SELECT
c.customer_state,
AVG(EXTRACT( DATE from o.order_delivered_customer_date) - EXTRACT(DATE from o.order_purchase_timestamp)) as avg_time_to_delivery
FROM `TARGET_SQL.orders` as o
JOIN `TARGET_SQL.order_items`as oi
ON O.order_id = oi.order_id
JOIN `TARGET_SQL.customers2` as c
ON o.customer_id = c.customer_id
GROUP BY customer_state
ORDER BY  avg_time_to_delivery ASC
LIMIT 5

# find the month on month no. of orders placed using different  payment types

SELECT
payment_type,
EXTRACT(YEAR from order_purchase_timestamp) as year,
EXTRACT(MONTH from order_purchase_timestamp) as month,
count(DISTINCT order_id) as order_count
FROM `TARGET_SQL.orders` as o
INNER JOIN `TARGET_SQL.payments` as p
on o.order_id = p.order_id
GROUP BY payment_type, year, month
ORDER BY payment_type, year, month

# count of orders based on the number of payment installments.

  SELECT payment_installments,
  COUNT(DISTINCT order_id) as num_orders
  FROM `TARGET_SQL.payments`
  GROUP BY payment_installments






