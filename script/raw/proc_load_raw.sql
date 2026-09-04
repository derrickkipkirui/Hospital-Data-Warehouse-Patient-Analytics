/*
===========================================================================================
Store procedure: Load raw Layer (source -> raw)
============================================================================================
Script purpose:
This stored procedure loads data into the 'raw'schema from external csv files.
it perfoms the following action
  Trancates the raw table before loading data
  confirming the data loaded is loaded correctly

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/

#loading dataset
  
TRUNCATE TABLE raw.procedures;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive (1)\\procedures.csv'
INTO TABLE raw.procedures
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS ;

SELECT *
FROM raw.procedures;

TRUNCATE TABLE raw.payers;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive (1)\\payers.csv'
INTO TABLE raw.payers
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS;

SELECT *
FROM raw.payers;

TRUNCATE TABLE raw.patients;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive (1)\\patients.csv'
INTO TABLE raw.patients
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS;

SELECT *
FROM raw.patients;

TRUNCATE TABLE raw.encounters;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive (1)\\encounters.csv'
INTO TABLE raw.encounters
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS ;

SELECT *
FROM raw.encounters;
