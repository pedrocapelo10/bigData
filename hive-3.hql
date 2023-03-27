-- QUERY 3 - What is the expected charge/cost of a taxi ride, given the pickup region ID, the weekday

DROP TABLE IF EXISTS taxis_table;

CREATE TABLE taxis_table (
  trip_id CHAR(50),
  taxi_id CHAR(50),
  pickup_datetime CHAR(25),
  dropoff_datetime CHAR(25),
  trip_seconds INT,
  trip_miles INT,
  pickup_id_region CHAR(50),
  dropoff_id_region CHAR(50),
  pickup_community_area INT,
  dropoff_community_area INT,
  fare FLOAT,
  tips FLOAT,
  tolls FLOAT,
  extras FLOAT,
  trip_total FLOAT,
  payment_type CHAR(50),
  company CHAR(50),
  pickup_centroid_latitude FLOAT,
  pickup_centroid_longitude FLOAT,
  pickup_centroid_location CHAR(50),
  dropoff_centroid_latitude FLOAT,
  dropoff_centroid_longitude FLOAT,
  dropoff_centroid_location CHAR(50))
  
  ROW FORMAT DELIMITED FIELDS TERMINATED BY '\u0059' ;

LOAD DATA LOCAL INPATH 'Taxi_Trips_151MB.csv' OVERWRITE INTO TABLE taxis_table;

DROP VIEW IF EXISTS taxis_table_proc;

CREATE VIEW taxis_table_proc AS
SELECT from_unixtime(unix_timestamp(SUBSTRING(pickup_datetime,1,10),'MM/dd/yy'),'u') as week , pickup_datetime as pickup_date, trip_total as cost_t, pickup_id_region as id_pickup_region
FROM taxis_table 
WHERE pickup_id_region!='';

DROP VIEW IF EXISTS table_result;

CREATE VIEW table_result AS
SELECT CONCAT(id_pickup_region,'_',week,'_',SUBSTRING(pickup_date,12,2),SUBSTRING(pickup_date,21,4)) as pickupRegion_weekday_hour, cost_t as cost_total
FROM taxis_table_proc;

--query 3
SELECT pickupRegion_weekday_hour,format_number(AVG(cost_total),2) as AVG_TRIP_COST FROM table_result GROUP BY  pickupRegion_weekday_hour



