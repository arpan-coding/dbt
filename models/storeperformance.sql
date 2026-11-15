with aggregated_orders as (
    select 
        storeid,
        sum(revenue) as actualsales
    from {{ ref('orders_fact') }}
    group by storeid
)

select 
    ao.storeid,
    ao.actualsales,
    st."salestarget" as targetsales  -- Wrapped in double quotes to preserve lowercase
from aggregated_orders ao
join {{ ref('salestargets') }} st 
    on trim(cast(ao.storeid as varchar)) = trim(cast(st."storeid" as varchar)) -- Wrapped in double quotes
