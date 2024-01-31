/* Question # 3 */
SELECT COUNT(*) FROM green_tripdata_data
WHERE CAST(lpep_pickup_datetime AS DATE) = '2019-09-18'
AND CAST(lpep_dropoff_datetime AS DATE) = '2019-09-18'
-----------------

/* Question # 4 */ 
SELECT DISTINCT "pick_date", MAX("trip_dist") FROM (
SELECT DISTINCT CAST("lpep_pickup_datetime" AS DATE) AS "pick_date", MAX("trip_distance") AS "trip_dist" FROM green_tripdata_data
GROUP BY "lpep_pickup_datetime"
ORDER BY CAST("lpep_pickup_datetime" AS DATE) DESC
) AS T1
GROUP BY "pick_date"
ORDER BY MAX("trip_dist") DESC
LIMIT 1
--------------------------

/* Question # 5 - */

SELECT * FROM (SELECT DISTINCT "Borough", SUM("total_amount") AS "Total_Amount" FROM
(SELECT T1.*, T2."Borough" FROM green_tripdata_data AS T1
LEFT JOIN zone_data AS T2 ON T1."PULocationID" = T2."LocationID"
WHERE CAST(T1."lpep_pickup_datetime" AS DATE) = '2019-09-18' AND T2."Borough" <> 'Unknown'
)
AS T3
GROUP BY "Borough"
ORDER BY "Total_Amount" DESC
LIMIT 3
) AS T4
WHERE "Total_Amount" > 50000
----------------------------

/* Question # 6 - */ 

SELECT "DOZone","tip_amount" FROM
(SELECT tbl.*, T3."Zone" AS "DOZone" FROM
(SELECT T1.*, T2."Zone" AS "PUZone" FROM green_tripdata_data AS T1
LEFT JOIN zone_data AS T2 ON T1."PULocationID" = T2."LocationID"
WHERE DATE_PART('YEAR',CAST(T1."lpep_pickup_datetime" AS DATE)) = 2019 
AND DATE_PART('MONTH',CAST(T1."lpep_pickup_datetime" AS DATE)) = 9  
AND T2."Zone" = 'Astoria') AS tbl
LEFT JOIN zone_data AS T3 ON T3."LocationID" = tbl."DOLocationID")
AS T4
ORDER BY "tip_amount" DESC
LIMIT 1