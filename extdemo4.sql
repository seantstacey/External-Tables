
-- -----------------------------------------------------------------------------
-- Demo 4: Hybrid Partitioned Table
--  An In-Line Partitioned Table with with External Table partitions
-- -----------------------------------------------------------------------------

drop table hybrid_orders ;
create table HYBRID_ORDERS (
   ORDER_ID		number(12,0) not null,
   ORDER_DATE		date not null,
   ORDER_MODE		varchar2(8),
   CUSTOMER_ID		number(12,0) not null,
   ORDER_STATUS		number(2,0),
   ORDER_TOTAL		number(8,2),
   SALES_REP_ID		number(6,0),
   PROMOTION_ID		number(6,0),
   WAREHOUSE_ID		number(6,0),
   DELIVERY_TYPE	varchar2(15),
   COST_OF_DELIVERY	number(6,0),
   WAIT_TILL_ALL_AVAILABLE	varchar2(15),
   DELIVERY_ADDRESS_ID	number(12,0),
   CUSTOMER_CLASS	varchar2(30),
   CARD_ID		number(12,0),
   INVOICE_ADDRESS_ID	varchar2(12)
   )
external partition attributes (
     TYPE ORACLE_LOADER
     DEFAULT DIRECTORY EXTTAB_DIR
     ACCESS PARAMETERS (
       FIELDS TERMINATED BY ','
       (order_id, order_date DATE 'DD-MON-YY HH24.MI.SS', order_mode, customer_id, 
        order_status, order_total, sales_rep_id, promotion_id, warehouse_id, 
        delivery_type, cost_of_delivery, wait_till_all_available, delivery_address_id, 
        customer_class, card_id, invoice_address_id)
     )
     REJECT LIMIT UNLIMITED ) 
partition by range (ORDER_DATE) 
  (
    partition orders_2018 values less than (TO_DATE('01-01-2019', 'DD-MM-YYYY')),
    partition orders_2019 values less than (TO_DATE('01-01-2020', 'DD-MM-YYYY')) EXTERNAL LOCATION ('orders_2019.csv'),
    partition orders_2020 values less than (TO_DATE('01-01-2021', 'DD-MM-YYYY'))
  ) ;


  select hybrid from user_tables where table_name = 'HYBRID_ORDERS'  ;
  select count(*) from hybrid_orders partition (orders_2018)  ;
  select count(*) from hybrid_orders partition (orders_2019)  ;
  select count(*) from hybrid_orders ;

  insert into hybrid_orders values (188192,to_date ('20-FEB-19', 'DD-MON-YY'), 'online',108610,5,5731,494,493,196,'Express',4,'ship_asap',7,'Business',17045,7)
/
  insert into hybrid_orders values (188192,to_date ('20-FEB-18', 'DD-MON-YY'), 'online',108610,5,5731,494,493,196,'Express',4,'ship_asap',7,'Business',17045,7)
/
select count(*) from hybrid_orders partition (orders_2018)  ;
select count(*) from hybrid_orders 
/
