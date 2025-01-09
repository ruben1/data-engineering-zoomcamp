WITH trips AS (
    SELECT trip_distance FROM yellow_taxi WHERE DATE(lpep_pickup_datetime) >= '2019-10-01' AND DATE(lpep_dropoff_datetime) < '2019-11-01'
)

SELECT COUNT(*)
FROM trips
WHERE trip_distance <= 1
UNION ALL
SELECT COUNT(*)
FROM trips
WHERE trip_distance > 1 AND trip_distance <= 3
UNION ALL
SELECT COUNT(*)
FROM trips
WHERE trip_distance > 3 AND trip_distance <= 7
UNION ALL
SELECT COUNT(*)
FROM trips
WHERE trip_distance > 7 AND trip_distance <= 10
UNION ALL
SELECT COUNT(*)
FROM trips
WHERE trip_distance > 10;
