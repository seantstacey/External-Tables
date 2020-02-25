-- ---------------------------------------------------------------------------------
-- Demo 0: Creating an External Table

-- Note: In order to access an External Table we need to first create a DIRECTORY
--       object in the database to indicate where the file being mapped as an  
--       External Table will be located.  The same location will be used to hold 
--       the BADFILE, DISCARDFILE and LOGFILE. The DIRECTORY is created as follows:
-- 
--       CREATE OR REPLACE DIRECTORY EXTRNL_DIR AS '/home/oracle/Downloads';
--       GRANT READ ON DIRECTORY EXTRNL_DIR TO <USER>;
--       GRANT WRITE ON DIRECTORY EXTRNL_DIR TO <USER>;
--
-- ---------------------------------------------------------------------------------

SET DEFINE OFF
SET PAGES 0 

set echo on
set pause on
drop table EXTTAB;

CREATE TABLE EXTTAB 
( CustName VARCHAR2(50),
  lastModified VARCHAR2(26),
  BusinessName VARCHAR2(128),
  StreetAddress VARCHAR2(128),
  City VARCHAR2(128),
  State VARCHAR2(26),
  Country VARCHAR2(50),
  Website VARCHAR2(128)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXTRNL_DIR
     ACCESS PARAMETERS 
       (records delimited BY NEWLINE 
           BADFILE EXTRNL_DIR:'Customerdata.bad'
           DISCARDFILE EXTRNL_DIR:'Customerdata.discard'
           LOGFILE EXTRNL_DIR:'Customerdata.log'
           skip 1 
           fields terminated BY ';'
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           )
     LOCATION ('customerdata.csv')
  )
  REJECT LIMIT UNLIMITED;

-- select * from EXTTAB ;

select a.custName, a.businessName, a.state 
from  EXTTAB a,  BUSINESSES b
where a.businessName = b.businessName 
/

