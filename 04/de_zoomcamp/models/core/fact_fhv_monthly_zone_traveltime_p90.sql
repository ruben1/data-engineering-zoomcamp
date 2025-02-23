{{ config(materialized='table') }}

with trips_data as (
    select 
        *,
        TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) as trip_duration,
    from {{ ref('dim_fhv_trips') }}
),
trips_data_perc as (
    select 
        pickup_year,
        pickup_month,
        pickup_borough,
        pickup_zone,
        dropoff_borough,
        dropoff_zone,
        PERCENTILE_CONT(trip_duration, 0.90) OVER (PARTITION BY pickup_year, pickup_month, pickup_locationid, dropoff_locationid) as p90_trip_duration,
        ROW_NUMBER() OVER (PARTITION BY pickup_year, pickup_month, pickup_locationid, dropoff_locationid) as row_num
    from trips_data
)
select pickup_year,
    pickup_month,
    pickup_borough,
    pickup_zone,
    dropoff_borough,
    dropoff_zone,
    p90_trip_duration
from trips_data_perc
where row_num = 1
order by pickup_year, pickup_month
