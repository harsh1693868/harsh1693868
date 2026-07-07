# 1. Import the dataset and do usual exploratory analysis steps like checking the
 #structure & characteristics of the dataset:
# 1. Data type of all columns in the "customers" table.
# 2. Get the time range between which the orders were placed.
# 3. Count the Cities & States of customers who ordered during the given
# period.

select * from `TARGET_SQL.customers2`
LIMIT 10

select * from `TARGET_SQL.geolocation`
limit 5

# Get the time range between which the orders were placed
SELECT
 min(order_purchase_timestamp) as start_time,
max(order_purchase_timestamp) as end_time
FROM `TARGET_SQL.orders`

# Count the Cities & States of customers who ordered during the given
# period.

SELECT
 c.customer_city,  c. customer_state
FROM `TARGET_SQL.orders` as o
JOIN `TARGET_SQL.customers2`as c
ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM O.order_purchase_timestamp) = 2018
AND EXTRACT (MONTH FROM order_purchase_timestamp) BETWEEN 1 AND 3;
