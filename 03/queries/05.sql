CREATE OR REPLACE TABLE `dtc-de-course-447007.ny_taxi.yellow_tripdata_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
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