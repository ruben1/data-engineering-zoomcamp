{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
    where fare_amount > 0 and trip_distance > 0 and lower(payment_type_description) in ('cash', 'credit card')
),
trips_data_perc as (
    select 
        service_type,
        pickup_year,
        pickup_month,
        PERCENTILE_CONT(fare_amount, 0.90) OVER w as p90_fare_amount,
        PERCENTILE_CONT(fare_amount, 0.95) OVER w as p95_fare_amount,
        PERCENTILE_CONT(fare_amount, 0.97) OVER w as p97_fare_amount,
    from trips_data
    WINDOW w AS (PARTITION BY service_type, pickup_year, pickup_month)
)
select DISTINCT *
from trips_data_perc
order by service_type, pickup_year, pickup_month
