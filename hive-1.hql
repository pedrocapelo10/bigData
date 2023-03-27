-- QUERY 1 - What is the accumulated number of taxi trips per month?

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
  ROW FORMAT DELIMITED FIELDS TERMINATED BY '\u0059';

LOAD DATA LOCAL INPATH 'Taxi_Trips_151MB.csv' OVERWRITE INTO TABLE taxis_table;

DROP VIEW IF EXISTS taxis_table_proc;

CREATE VIEW taxis_table_proc AS
SELECT SUBSTRING(pickup_datetime,1,2) as mes
FROM taxis_table;
--query 1
SELECT mes,COUNT(mes) as total_trips FROM taxis_table_proc GROUP BY mes ORDER by mes;