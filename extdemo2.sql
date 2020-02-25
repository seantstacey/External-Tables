
-- -----------------------------------------------------------------------------
-- Demo 2: Sharing External Tables across multiple PDBS
-- 
-- -----------------------------------------------------------------------------

SET DEFINE OFF
SET PAGES 0

-- CREATE OR REPLACE DIRECTORY EXTTAB_DIR AS '/home/oracle/Downloads';
-- GRANT READ ON DIRECTORY EXTTAB_DIR TO <USER>;
-- GRANT WRITE ON DIRECTORY EXTTAB_DIR TO <USER>;

-- drop table EXT_TABLE;

CREATE TABLE EXT_TABLE 
( CustName VARCHAR2(50),
  lastModified VARCHAR2(26),
  BusinessName VARCHAR2(128),
  StreetAddress VARCHAR2(128),
  City VARCHAR2(128),
  State VARCHAR2(26),
  Country VARCHAR2(50),
  Website VARCHAR2(128) )
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
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
     LOCATION ('customerdata.csv')
  )
  REJECT LIMIT UNLIMITED;

-- select * from EXT_TABLE ;
-- select * from BUSINESSES ;

select a.custName, a.businessName, a.state 
from  EXT_TABLE a,  BUSINESSES b
where a.businessName = b.business_name 
/

