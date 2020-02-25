
-- --------------------------------------------------------------------------------
-- Demo6exp.sql: Using an External Table to map out a DataPump file
--
--       This demo script creates a file called micro.dmp in the file system, the
--       file can then be imported using demo6imp.sql.
--          
-- --------------------------------------------------------------------------------

SET DEFINE OFF

drop table Microbreweries ;

CREATE TABLE Microbreweries
   ORGANIZATION EXTERNAL
   (type ORACLE_DATAPUMP 
    default directory DUMP_DIR 
    location ('micro.dmp') )
 as
   select brewery_name, street_address, city, state, substr(zip, 4) zip, url 
     from BREWERIES 
    where LOCATION_TYPE = 'Micro'
      and length(BREWERY_NAME) <= 30 
      and length (STREET_ADDRESS) <= 50
      and length(URL) <= 30 
/

show con_name
select count(*) from BREWERIES 
/
select count(*) from MICROBREWERIES 
/

