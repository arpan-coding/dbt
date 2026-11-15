{{ config(materialized='table') }}

with combined_sales_data as (
    select
        o.orderid,
        o.orderdate,
        o.storeid,
        c.customerid,
        c.city,
        -- Dynamically map cities to country regions
        case 
            when lower(trim(c.city)) in ('new york', 'chicago', 'los angeles', 'houston', 'phoenix', 'seattle', 'miami', 'boston', 'denver') then 'US'
            when lower(trim(c.city)) in ('london', 'manchester', 'birmingham', 'liverpool', 'leeds') then 'UK'
            when lower(trim(c.city)) in ('tokyo', 'singapore', 'mumbai', 'seoul', 'bangkok') then 'Asia'
            else 'Other / International'
        end as country_region,
        oi.quantity,
        oi.unitprice as unit_sell_price,
        -- Pulling real wholesale costs from the products table (using a fallback value of 40% if product matrix is blank)
        coalesce(p.price * 0.60, oi.unitprice * 0.55) as unit_purchase_cost
    from {{ ref('orders_stg') }} o
    join {{ ref('orderitems_stg') }} oi 
        on o.orderid = oi.orderid
    join {{ ref('customers_stg') }} c 
        on o.customerid = c.customerid
    left join {{ source('landing', 'products') }} p
        on oi.productid = p.productid
)

select
    orderdate as sales_date,
    country_region,
    sum(quantity * unit_sell_price) as total_revenue,
    sum(quantity * unit_purchase_cost) as total_cost,
    sum(quantity * unit_sell_price) - sum(quantity * unit_purchase_cost) as total_profit
from combined_sales_data
group by orderdate, country_region
