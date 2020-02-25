
-- --------------------------------------------------------------------------------
-- Demo6imp.sql: Using an External Table to import a DataPump file
--
--       This demo script imports a file called micro.dmp the file was 
--       created using demo6exp.sql.
--          
-- --------------------------------------------------------------------------------

SET DEFINE OFF


SET DEFINE OFF
SET ECHO ON

show con_name
drop table Microbreweries ;

CREATE TABLE Microbreweries
 (
  brewery_name   varchar2(30),
  street_address varchar2(50),
  city 		 varchar2(30),
  state 	 varchar2(20),
  zip 		 varchar2(12),
  url 		 varchar2(30) 
 )   
 ORGANIZATION EXTERNAL
  ( type ORACLE_DATAPUMP 
    default directory DUMP_DIR 
    location ('micro.dmp') 
   );
    
select count(*) from MICROBREWERIES 
/

