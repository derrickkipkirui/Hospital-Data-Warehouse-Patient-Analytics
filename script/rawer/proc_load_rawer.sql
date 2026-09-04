/*
===========================================================================================
Store procedure: Load rawer Layer (raw -> rawer)
============================================================================================
Script purpose:
This stored procedure perfomes the ETL(Extract, Transform, Load) process to populate the 'rawer'schema table from 'raw' schema.
it perfoms the following action
  inserts,transformed and cleansed data from raw into rawer table

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/

INSERT INTO rawer.procedures(
START,
STOP,
PATIENT,
ENCOUNTER,
CODE,
DESCRIPTION,
BASE_COST,
REASONCODE,
REASONDESCRIPTION)
SELECT
STR_TO_DATE(START,'%Y-%m-%dT%TZ')AS START,
STR_TO_DATE(STOP,'%Y-%m-%dT%TZ')AS STOP,
PATIENT,
ENCOUNTER,
CODE,
DESCRIPTION,
BASE_COST,
REASONCODE,
REASONDESCRIPTION
FROM raw.procedures;


INSERT INTO rawer.payers(
Id,
NAME,
ADDRESS,
CITY,
STATE_HEADQUARTERED,
ZIP,
PHONE)
SELECT
Id,
NAME,
ADDRESS,
CITY,
STATE_HEADQUARTERED,
ZIP,
PHONE
FROM raw.payers;


INSERT INTO rawer.patients(
Id,
BIRTHDATE,
DEATHDATE,
PREFIX,
FIRST,
LAST,
SUFFIX,
MAIDEN,
MARITAL,
RACE,
ETHNICITY,
GENDER,
BIRTHPLACE,
ADDRESS,
CITY,
STATE,
COUNTY,
ZIP,
LAT,
LON)
SELECT
Id,
BIRTHDATE,
CASE WHEN DEATHDATE = 0 THEN NULL 
	ELSE DEATHDATE
END DEATHDATE,
PREFIX,
REGEXP_REPLACE(FIRST,'[^a-zA-Z]','')AS FIRST,
REGEXP_REPLACE(LAST,'[^a-zA-Z]','')AS LAST,
SUFFIX,
REGEXP_REPLACE(MAIDEN,'[^a-zA-Z]','') AS MAIDEN,
CASE WHEN MARITAL = 'M' THEN 'Married'
	WHEN MARITAL = 'S' THEN 'Single'
    ELSE 'N/A '
END MARITAL,
RACE,
ETHNICITY,
CASE WHEN GENDER = 'M' THEN 'Male'
	WHEN GENDER = 'F' THEN 'Female'
    ELSE 'N/A '
END GENDER,
BIRTHPLACE,
ADDRESS,
CITY,
STATE,
COUNTY,
ZIP,
LAT,
LON
FROM raw.patients;


INSERT INTO rawer.encounters(
Id,
START,
STOP,
PATIENT,
ORGANIZATION,
PAYER,
ENCOUNTERCLASS,
CODE,
DESCRIPTION,
BASE_ENCOUNTER_COST,
TOTAL_CLAIM_COST,
PAYER_COVERAGE,
REASONCODE,
REASONDESCRIPTION)
SELECT
Id,
STR_TO_DATE(START,'%Y-%m-%dT%TZ')AS START,
STR_TO_DATE(STOP,'%Y-%m-%dT%TZ')AS STOP,
PATIENT,
ORGANIZATION,
PAYER,
ENCOUNTERCLASS,
CODE,
DESCRIPTION,
BASE_ENCOUNTER_COST,
TOTAL_CLAIM_COST,
PAYER_COVERAGE,
REASONCODE,
REASONDESCRIPTION
FROM raw.encounters;
