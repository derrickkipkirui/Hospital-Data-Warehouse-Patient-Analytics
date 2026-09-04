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
SELECT START, COUNT(*)
FROM raw.procedures
GROUP BY START
HAVING COUNT(*) > 1 OR START IS NULL;

SELECT *
FROM raw.procedures
WHERE START = '2011-01-13T15:41:08Z';

##checking for unwanted spaces
SELECT REASONDESCRIPTION
FROM raw.procedures
WHERE REASONDESCRIPTION != TRIM(REASONDESCRIPTION);

SELECT DISTINCT PATIENT
FROM raw.procedures;

###check for duplicates
SELECT *
FROM raw.payers;

SELECT Id,COUNT(*)
FROM raw.payers
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;

##checking for unwanted spaces
SELECT ZIP
FROM raw.payers
WHERE ZIP != TRIM(ZIP);

##check for duplicates
SELECT *
FROM raw.patients;

SELECT Id,COUNT(*)
FROM raw.patients
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;

##checking for unwanted spaces
SELECT PREFIX
FROM raw.patients
WHERE PREFIX != TRIM(PREFIX);
##CHECKING NULLS
SELECT  BIRTHDATE
FROM raw.patients
WHERE BIRTHDATE = 0;

##check for duplicates
SELECT *
FROM raw.encounters;

SELECT Id,COUNT(*)
FROM raw.encounters
GROUP BY Id
HAVING COUNT(*) > 1 OR Id IS NULL;
