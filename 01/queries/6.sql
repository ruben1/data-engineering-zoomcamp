WITH largest_tip AS (
    SELECT y."DOLocationID", MAX(y.tip_amount) AS max_tip_amount
    FROM yellow_taxi y INNER JOIN taxi_zones t ON y."PULocationID" = t."LocationID"
    WHERE DATE_PART('year', y.lpep_pickup_datetime) = '2019' AND
        DATE_PART('month', y.lpep_pickup_datetime) = '10' AND
        t."Zone" = 'East Harlem North'
    GROUP BY y."DOLocationID"
    ORDER BY max_tip_amount DESC
    LIMIT 1
)

SELECT l."DOLocationID", t."Zone", l.max_tip_amount
FROM largest_tip l INNER JOIN taxi_zones t ON l."DOLocationID" = t."LocationID";
