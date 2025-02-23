{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
select 
    service_type,
    pickup_year_quarter, 
    pickup_year,
    pickup_quarter,
    SUM(total_amount) as quarterly_revenue,
    (SELECT SUM(prev_ft.total_amount)
     FROM trips_data AS prev_ft
     WHERE service_type = ft.service_type AND prev_ft.pickup_year_quarter = CONCAT(ft.pickup_year - 1, '/', ft.pickup_quarter)
    ) AS prev_quarterly_revenue,
    SAFE_DIVIDE(
        SUM(ft.total_amount) - 
        (SELECT SUM(prev_ft.total_amount)
         FROM trips_data AS prev_ft
         WHERE service_type = ft.service_type AND prev_ft.pickup_year_quarter = CONCAT(ft.pickup_year - 1, '/', ft.pickup_quarter)
        ),
        (SELECT SUM(prev_ft.total_amount)
         FROM trips_data AS prev_ft
         WHERE service_type = ft.service_type AND prev_ft.pickup_year_quarter = CONCAT(ft.pickup_year - 1, '/', ft.pickup_quarter)
        )
    ) AS yoy_growth_rate
from trips_data as ft
group by service_type, pickup_year_quarter, pickup_year, pickup_quarter