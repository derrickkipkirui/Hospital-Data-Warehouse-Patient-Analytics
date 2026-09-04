/*
==========================================================================
DDL Script: Create rawest table
==========================================================================
Script purpose:
This script creates table in the rawest schema dropping existing table if they already exists.
Run this script to re-define the DDL structure of 'rawest' table.
its a clean, enriched, and businnes ready dataset

Usage
it can be quired directly for analytics and reporting
*/



DROP TABLE IF EXISTS rawest.clean;
CREATE TABLE rawest.clean(
PREFIX VARCHAR(50),
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
MAIDEN_NAME VARCHAR(50),
AGE INT,
AGE_GROUP VARCHAR(50),
BIRTHDATE DATE,
DEATHDATE DATE,
GENDER VARCHAR(50),
MARITAL VARCHAR(50),
RACE VARCHAR(50),
ETHNICITY VARCHAR(50),
CITY VARCHAR(50),
STATE VARCHAR(50),
ENCOUNTER_START DATETIME,
PROCEDURE_START DATETIME,
ENCOUNTER_STOPS DATETIME,
PROCEDURE_STOPS DATETIME,
ENCOUNTER_DESCRIPTION VARCHAR(100),
PROCEDURE_DESCRIPTION VARCHAR(100),
ENCOUNTERCLASS VARCHAR(50),
PROCEDURE_COST INT,
BASE_ENCOUNTER_COST FLOAT,
TOTAL_CLAIM_COST FLOAT,
PAYER_COVERAGE FLOAT,
PAYER_NAME VARCHAR(50)
);
