SELECT y."PULocationID", t."Zone", SUM(y.total_amount) AS location_total_amount
FROM yellow_taxi y INNER JOIN taxi_zones t ON y."PULocationID" = t."LocationID"
WHERE DATE(y.lpep_pickup_datetime) = '2019-10-18'
GROUP BY "PULocationID", t."Zone"
HAVING SUM(y.total_amount) > 13000;
