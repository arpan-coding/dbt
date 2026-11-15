/* This will check the business logic: If the revenue  of any order is -ve, it will be a failure */
SELECT OrderID
FROM {{ ref('orders_fact')}}
WHERE Revenue < 0
