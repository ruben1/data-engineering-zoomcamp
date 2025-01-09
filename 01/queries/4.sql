SELECT DATE(lpep_pickup_datetime), MAX(trip_distance)
FROM yellow_taxi
WHERE DATE(lpep_pickup_datetime) IN ('2019-10-11', '2019-10-24', '2019-10-26', '2019-10-31')
GROUP BY DATE(lpep_pickup_datetime);
