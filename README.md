# External-Tables
Oracle Database - External Table samples and datasets

This repository includes code samples and sample data for accessing Oracle External Tables.

The following datasets are provided as sample data-sets.  Please note the data in these samples is fictitious.

*This repo is for demonstration purposes only. Comments and issues may or may not be responded to.*

## Datasets:
- customerdata.csv
- orders_2019.csv
- p1_sailboats.csv
- p2_sailboats.csv
- p3_sailboats.csv
- p4_sailboats.csv

## Scripts:

### createCred.sql
This script contains SQL code required to create an Oracle cloud credential in the database.  The credential can then be used to access the Oracle Object Storage.

### extdemo0.sql
This script provides a simple demonstration of using a regular External Table.  

### extdemo1.sql
This script demonstrates an inline External Table. This form of external table is ephemeral in that the definition is only persisted during the life of the sql code. There is no requirement to drop the external table once the operation has completed.

### extdemo2.sql
There is little to demonstrate in script itself,  the main purpose of this demonstration is to show simultaneous access to a single External Table from multiple pluggable databases.

### extdemo3.sql
This script demonstrates how an External Table can be partitioned.  In this example we are Range partitioning based on multiple csv files.  This approach can help with performance as reads from the External Table can be parallelized.  This approach can also be useful when working with multiple data streams. 

### extdemo4.sql
This script demonstrates Oracle Hybrid Partitioned Tables.  In this instance we are are creating a range-partitioned table.  The warmer (more recent) data is stored inside the database and the colder (older) data is stored in an external table.
  
### extdemo5.sql
This script demonstrates how an External Table can be populated into the Oracle Database In-Memory Columnar Store. Be aware that for this script to see any benefit, the dataset  will need to be larger than 64K.

### extdemo6exp.sql
This is Part One of a demonstration of using External Tables with the DATAPUMP Access driver.  In this example we generate a datapump file from the results of a table select statement from the database.  The subset could be based on the output of a join.  This example creates a datapump dump file.  

### extdemo6imp.sql
This is Part Two of a demonstration of using External Tables with the DATAPUMP Access driver. In this example we create an external table in a different database (or Pluggable Database) then the database where we created the external table from.  The dump file can then be loaded into this using the External Table approach or datapump.   

### extdemo7.sql
This script demonstrates using an External Table to load a raw JSON file using the DATAPUMP Access driver.  The benefit of the DATAPUMP access driver in this case is that it can simplify working with BLOB objects and can be parallelized for speeding up data ingest.  

### extdemo10.sql
This script demonstrates creating an External Table using a file stored in a bucket in Oracle Object Storage.  This script relies on the Cloud Credential being already created in the database - this can be done using the demoscript- createCred.sql.

