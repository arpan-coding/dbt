select
    sales_date,
    total_revenue,
    total_cost,
    total_profit
from {{ ref('regional_sales_performance') }}
where country_region = 'US'
