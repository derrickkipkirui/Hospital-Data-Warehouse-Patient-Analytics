/*
=============================================================================================
Quality checks
=============================================================================================
Script purpose:
This script performs various quality checks for data consistency,acuracy.
unwanted spaces 
null dates 

Usage notes:
Run these checks after data loading

*/

##checking for unwanted spaces
## expectation: No result found
SELECT PREFIX
FROM rawest.clean 
WHERE PREFIX != TRIM(PREFIX);


SELECT ENCOUNTER_DESCRIPTION
FROM rawest.clean
WHERE ENCOUNTER_DESCRIPTION != TRIM(ENCOUNTER_DESCRIPTION);



SELECT ENCOUNTERCLASS
FROM rawest.clean
WHERE ENCOUNTERCLASS != TRIM(ENCOUNTERCLASS);

##CHECKING NULLS
SELECT  BIRTHDATE
FROM rawest.clean
WHERE BIRTHDATE = 0;

