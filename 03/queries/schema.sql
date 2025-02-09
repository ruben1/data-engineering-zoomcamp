CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-447007.ny_taxi.yellow_tripdata_ext`
(
    VendorID INTEGER OPTIONS (description = 'A code indicating the LPEP provider that provided the record. 1= Creative Mobile Technologies, LLC; 2= VeriFone Inc.'),
    tpep_pickup_datetime TIMESTAMP OPTIONS (description = 'The date and time when the meter was engaged'),
    tpep_dropoff_datetime TIMESTAMP OPTIONS (description = 'The date and time when the meter was disengaged'),
    passenger_count INTEGER OPTIONS (description = 'The number of passengers in the vehicle. This is a driver-entered value.'),
    trip_distance FLOAT64 OPTIONS (description = 'The elapsed trip distance in miles reported by the taximeter.'),
    RatecodeID INTEGER OPTIONS (description = 'The final rate code in effect at the end of the trip. 1= Standard rate 2=JFK 3=Newark 4=Nassau or Westchester 5=Negotiated fare 6=Group ride'),
    store_and_fwd_flag STRING OPTIONS (description = 'This flag indicates whether the trip record was held in vehicle memory before sending to the vendor, aka "store and forward," because the vehicle did not have a connection to the server. TRUE = store and forward trip, FALSE = not a store and forward trip'),
    PULocationID INTEGER OPTIONS (description = 'TLC Taxi Zone in which the taximeter was engaged'),
    DOLocationID INTEGER OPTIONS (description = 'TLC Taxi Zone in which the taximeter was disengaged'),
    payment_type INTEGER OPTIONS (description = 'A numeric code signifying how the passenger paid for the trip. 1= Credit card 2= Cash 3= No charge 4= Dispute 5= Unknown 6= Voided trip'),
    fare_amount FLOAT64 OPTIONS (description = 'The time-and-distance fare calculated by the meter'),
    extra FLOAT64 OPTIONS (description = 'Miscellaneous extras and surcharges. Currently, this only includes the $0.50 and $1 rush hour and overnight charges'),
    mta_tax FLOAT64 OPTIONS (description = '$0.50 MTA tax that is automatically triggered based on the metered rate in use'),
    tip_amount FLOAT64 OPTIONS (description = 'Tip amount. This field is automatically populated for credit card tips. Cash tips are not included.'),
    tolls_amount FLOAT64 OPTIONS (description = 'Total amount of all tolls paid in trip.'),
    improvement_surcharge FLOAT64 OPTIONS (description = '$0.30 improvement surcharge assessed on hailed trips at the flag drop. The improvement surcharge began being levied in 2015.'),
    total_amount FLOAT64 OPTIONS (description = 'The total amount charged to passengers. Does not include cash tips.'),
    congestion_surcharge FLOAT64 OPTIONS (description = 'Congestion surcharge applied to trips in congested zones')
)
OPTIONS (
    format = 'PARQUET',
    uris = ['gs://terraform-de-zoomcamp-03/yellow_tripdata_*']
);

CREATE OR REPLACE TABLE `dtc-de-course-447007.ny_taxi.yellow_tripdata`
AS
SELECT
MD5(CONCAT(
    COALESCE(CAST(VendorID AS STRING), ""),
    COALESCE(CAST(tpep_pickup_datetime AS STRING), ""),
    COALESCE(CAST(tpep_dropoff_datetime AS STRING), ""),
    COALESCE(CAST(PULocationID AS STRING), ""),
    COALESCE(CAST(DOLocationID AS STRING), "")
)) AS unique_row_id,
*
FROM `dtc-de-course-447007.ny_taxi.yellow_tripdata_ext`;
