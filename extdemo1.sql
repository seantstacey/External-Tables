
-- -----------------------------------------------------------------------------
-- Demo 1: Inline External Tables Demo
-- 
--   Note: The external table name should not appear in either query from the 
--         USER_EXTERNAL_TABLES below
-- -----------------------------------------------------------------------------

SET DEFINE OFF

select table_name, type_name from user_external_tables 
/

select CustName, businessName, businesses.state 
from  external (
( CustName VARCHAR2(50),
  lastModified VARCHAR2(26),
  BusinessName VARCHAR2(128),
  StreetAddress VARCHAR2(128),
  City VARCHAR2(128),
  State VARCHAR2(26),
  Country VARCHAR2(50),
  Website VARCHAR2(128)
 )
type ORACLE_LOADER
     DEFAULT DIRECTORY EXTRNL_DIR
     ACCESS PARAMETERS 
       (records delimited BY NEWLINE 
           BADFILE EXTRNL_DIR:'customerdata.bad'
           DISCARDFILE EXTRNL_DIR:'customerdata.discard'
           LOGFILE EXTRNL_DIR:'customerdata.log'
           skip 1 
           fields terminated BY ';'
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           )
     LOCATION ('customerdata.csv') REJECT LIMIT UNLIMITED ) TEST_EXTN,  BUSINESSES
where test_extn.businessName = businesses.business_name 
/

select table_name, type_name from user_external_tables 
/
