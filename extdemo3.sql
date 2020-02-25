
-- --------------------------------------------------------------------------------
-- Demo 3: Creating a Partitioned External Table

-- Note: In order to access an External Table we need to first create a
--       DIRECTORY object for where the External Table will be located as follows:
-- 
--       CREATE OR REPLACE DIRECTORY EXTTAB_DIR AS '/home/oracle/Downloads';
--       GRANT READ ON DIRECTORY EXTTAB_DIR TO <USER>;
--       GRANT WRITE ON DIRECTORY EXTTAB_DIR TO <USER>;

-- --------------------------------------------------------------------------------

SET DEFINE OFF
SET ECHO ON

drop table SAILBOATS ;

SET PAUSE ON

CREATE TABLE sailboats 
( 
  Id 		number(3) not null,
  Manufacturer 	varchar2(26),
  Model 	varchar2(26),
  year 		number(4),
  LOA 		number(38, 2),
  Beam 		number(38),
  Draft 	number,
  Displacement 	number,
  Price 	number(38,2),
  Cabins 	number,
  Heads 	number,
  Hull 		varchar2(10),
  Rig 		varchar2(20),
  Engine 	varchar2(20),
  Fuel 		varchar2(10),
  HorsePower 	varchar2(10),
  Notes 	varchar2(30)
)
ORGANIZATION EXTERNAL
  (  TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXTRNL_DIR
     ACCESS PARAMETERS 
       (records delimited BY NEWLINE 
           fields terminated by ','
           OPTIONALLY ENCLOSED BY '"' AND '"'
           lrtrim
           missing field VALUES are NULL
        )
  )
PARTITION BY RANGE (Id)
 ( partition P1 values less than (61)  LOCATION ('p1_sailboats.csv') ,
   partition P2 values less than (120) LOCATION ('p2_sailboats.csv') ,
   partition P3 values less than (185) LOCATION ('p3_sailboats.csv') ,
   partition P4 values less than (300) LOCATION ('p4_sailboats.csv')
  ) 
  REJECT LIMIT UNLIMITED;

pause 

select * from SAILBOATS ;
pause Press Enter to Continue...

select * from user_external_tables ; 
pause Press Enter to Continue...

select count(*) from SAILBOATS partition (P2);
