/*
=============================================================================================
Quality checks
=============================================================================================
Script purpose:
This script performs various quality checks for data consistency,acuracy.
It includes checks for null or duplicates 
unwanted spaces and data consistency

Usage notes:
Run these checks after data loading

*/


##checking duplicates
## expectation No results
SELECT *
FROM rawer.procedures;

SELECT START, COUNT(*)
FROM rawer.procedures
GROUP BY START
HAVING COUNT(*) > 1 OR START IS NULL;

SELECT *
FROM rawer.procedures
WHERE START = '2011-01-13T15:41:08Z';

##checking for unwanted spaces
## expectation: No result found
SELECT REASONDESCRIPTION
FROM rawer.procedures
WHERE REASONDESCRIPTION != TRIM(REASONDESCRIPTION);

SELECT DISTINCT PATIENT
FROM rawer.procedures;

###check for duplicates
##expectation : No results
SELECT *
FROM rawer.payers;

SELECT Id,COUNT(*)
FROM rawer.payers
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;

##checking for unwanted spaces
##expectation: No result
SELECT ZIP
FROM rawer.payers
WHERE ZIP != TRIM(ZIP);

##check for duplicates
## expectation: No results
SELECT *
FROM rawer.patients;


SELECT Id,COUNT(*)
FROM rawer.patients
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;

##checking for unwanted spaces
##expectation: No result
SELECT PREFIX
FROM rawer.patients
WHERE PREFIX != TRIM(PREFIX);
##CHECKING NULLS
SELECT  BIRTHDATE
FROM rawer.patients
WHERE BIRTHDATE = 0;

##check for duplicates
## expectation: No results
SELECT *
FROM rawer.encounters;


SELECT Id,COUNT(*)
FROM raw.encounters
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;
