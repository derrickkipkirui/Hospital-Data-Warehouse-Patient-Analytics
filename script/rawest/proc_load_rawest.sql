/*
===========================================================================================
Store procedure: Load Rawest Layer (rawer -> rawest)
============================================================================================
Script purpose:
This stored procedure perfomes the ETL(Extract, Transform, Load) process to populate the 'rawest'schema table from 'rawer' schema.
it perfoms the following action
  Trancates the rawest table before loading data
  inserts,transformed and cleansed data from rawer into rawest table

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/


TRUNCATE TABLE rawest.clean;
INSERT INTO  rawest.clean(
PREFIX ,
FIRST_NAME ,
LAST_NAME ,
MAIDEN_NAME ,
AGE,
AGE_GROUP,
BIRTHDATE ,
DEATHDATE ,
GENDER ,
MARITAL ,
RACE ,
ETHNICITY ,
CITY ,
STATE ,
ENCOUNTER_START ,
PROCEDURE_START ,
ENCOUNTER_STOPS ,
PROCEDURE_STOPS ,
ENCOUNTER_DESCRIPTION ,
PROCEDURE_DESCRIPTION ,
ENCOUNTERCLASS ,
PROCEDURE_COST ,
BASE_ENCOUNTER_COST ,
TOTAL_CLAIM_COST ,
PAYER_COVERAGE ,
PAYER_NAME  
)
SELECT
TRIM(pt.PREFIX) AS PREFIX,
TRIM(pt.FIRST) AS  FIRST_NAME,
TRIM(pt.LAST) AS LAST_NAME ,
pt.MAIDEN ,
TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,en.START) AS AGE,
CASE WHEN pt.DEATHDATE IS NOT NULL THEN
CASE WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,pt.DEATHDATE) < 18 THEN '0-17'
	WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,pt.DEATHDATE) < 45 THEN '18-44'
    WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,pt.DEATHDATE) < 65 THEN '45-64'
    ELSE'65+'
		END
	ELSE
CASE WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,en.START) < 18 THEN '0-17'
	WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,en.START) < 45 THEN '18-44'
    WHEN TIMESTAMPDIFF(YEAR ,pt.BIRTHDATE,en.START) < 65 THEN '45-64'
    ELSE'65+'
    END
END AGE_GROUP,
pt.BIRTHDATE,
pt.DEATHDATE,
pt.GENDER  ,
CASE WHEN pt.MARITAL = 'N/A ' THEN 'Unknown'
	ELSE pt.MARITAL
END AS MARITAL ,
pt.RACE ,
pt.ETHNICITY ,
pt.CITY ,
pt.STATE ,
en.START ,
pr.START ,
en.STOP  ,
pr.STOP ,
en.DESCRIPTION ,
pr.DESCRIPTION ,
en.ENCOUNTERCLASS,
pr.BASE_COST ,
en.BASE_ENCOUNTER_COST,
en.TOTAL_CLAIM_COST,
en.PAYER_COVERAGE,
py.NAME
FROM rawer.procedures pr
LEFT JOIN rawer.encounters en
ON pr.ENCOUNTER = en.Id
LEFT JOIN rawer.patients pt
ON pr.PATIENT = pt.Id 
LEFT JOIN rawer.payers py
ON en.PAYER = py.Id;
