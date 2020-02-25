
-- ----------------------------------------------------------------------------------------
--  Demo 7: Using External Tables to load JSON Objects
-- 
--  The sample file for this demo can be obtained from:
--  https://github.com/oracle/db-sample-schemas/blob/master/order_entry/PurchaseOrders.dmp
-- 
-- ----------------------------------------------------------------------------------------

SET DEFINE OFF
SET PAUSE ON
SET ECHO ON

drop table json_purchase_orders ;

CREATE TABLE json_purchase_orders (json_document BLOB)
  ORGANIZATION EXTERNAL (TYPE ORACLE_LOADER DEFAULT DIRECTORY EXTRNL_DIR
                         ACCESS PARAMETERS
                           (RECORDS DELIMITED BY 0x'0A'
                            DISABLE_DIRECTORY_LINK_CHECK
                            FIELDS (json_document CHAR(5000)))
                         LOCATION (EXTRNL_DIR:'PurchaseOrders.dmp'))
  PARALLEL
  REJECT LIMIT UNLIMITED
/


select * from json_purchase_orders 
where rownum < 2
/

select json_serialize(json_document returning varchar2 pretty) pretty_js 
from   json_purchase_orders 
where  rownum < 2
/




