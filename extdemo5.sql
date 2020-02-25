
-- ------------------------------------------------------------------------------
-- Demo 5: In-Memory External Tables
--  
--  Note:  In order for a table to be populated into the Database In-Memory 
--         Columnar Store,  the table needs to be at least 64K in size.
--         The following sample is for demonstration purposes only 
-- ------------------------------------------------------------------------------

SET DEFINE OFF
col table_name form A30

drop table DBIM_BUSINESS ;

CREATE TABLE DBIM_BUSINESS
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
           BADFILE EXTTAB_DIR:'customerdata.bad'
           DISCARDFILE EXTTAB_DIR:'customerdata.discard'
           LOGFILE EXTTAB_DIR:'customerdata.log'
           skip 1 
           fields terminated BY ';'
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
           )
     LOCATION ('customerdata.csv')
  )
  REJECT LIMIT UNLIMITED 
  INMEMORY ;

select count(*) from dbim_business ;

select table_name, inmemory, inmemory_compression 
from   user_external_tables ;

