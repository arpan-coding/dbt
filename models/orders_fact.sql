

SELECT 
    O.OrderID,                    -- Double check spelling: OrderID
    O.OrderDate,                  -- Double check spelling: OrderDate
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD,
    O.StatusDesc,
    O.Updated_at,
    COUNT(DISTINCT O.OrderID) AS OrderCount,
    SUM(OI.TotalPrice) AS Revenue 
FROM 
    {{ ref('orders_stg') }} O     
JOIN 
    {{ ref('orderitems_stg') }} OI 
        ON O.OrderID = OI.OrderID
GROUP BY 
    O.OrderID,                    -- Must match the exact spelling above
    O.OrderDate,                  -- Must match the exact spelling above
    O.CustomerID,
    O.EmployeeID,
    O.StoreID,
    O.StatusCD,
    O.StatusDesc,
    O.Updated_at
