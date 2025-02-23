{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select ft.tripid, 
    ft.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    ft.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    ft.pickup_datetime, 
    ft.dropoff_datetime, 
    ft.dispatching_base_num,
    ft.sr_flag,
    ft.affiliated_base_number,
    EXTRACT(YEAR FROM ft.pickup_datetime) as pickup_year,
    EXTRACT(QUARTER FROM ft.pickup_datetime) as pickup_quarter,
    CONCAT(EXTRACT(YEAR FROM ft.pickup_datetime), '/', EXTRACT(QUARTER FROM ft.pickup_datetime)) AS pickup_year_quarter,
    EXTRACT(MONTH FROM ft.pickup_datetime) as pickup_month
from fhv_tripdata as ft
inner join dim_zones as pickup_zone
on ft.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on ft.dropoff_locationid = dropoff_zone.locationid