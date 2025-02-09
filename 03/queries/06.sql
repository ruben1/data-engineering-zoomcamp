SELECT DISTINCT(VendorID)
FROM `dtc-de-course-447007.ny_taxi.yellow_tripdata_partitioned`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';