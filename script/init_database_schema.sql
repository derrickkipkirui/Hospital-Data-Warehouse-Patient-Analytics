/*
============================================================================
Create Schemas
=============================================================================
Script Purpose:
This script creates a new schemas,the script sets up three schemas :'raw', 'rawer' and 'rawest'.

WARNING:
Running this script will drop the schemas if it exists.All data in the database will be permanently deleted.Proceed with caution
and ensure you have proper backups before runing the script.
*/

#creating schemas
CREATE SCHEMA raw;
CREATE SCHEMA rawer;
CREATE SCHEMA rawest;
