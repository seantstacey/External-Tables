
-- -------------------------------------------------------------------------------------
-- Demo 10: Creating an External Table using a file stored in a bucket in Oracle 
--          Object Storage

-- Note: In order to access the file as an External Table we need:
--  (a)  Map the location of the file in the Object Storage Bucket - this is defined
--       below as both "base_URL" and "swift_URL".  Either method can be used below.
-- 
--  (b)  A CREDENTIAL must be created in the database for authentication to access the 
--       Object Storage Bucket.  An example of this is provided in createCred.sql
-- -------------------------------------------------------------------------------------

drop table CHANNELS_EXT ;

DEFINE base_URL='https://objectstorage.<AvailabilityDomain>.oraclecloud.com/p/abcDEFhijKLMnop...123579/n/abc123def/b/BUCKET_NAME/o'

DEFINE swift_URL='https://swiftobjectstorage.<AvailabilityDomain>.oraclecloud.com/v1/TENTANT_NAME/BUCKET_NAME/'


begin
 dbms_cloud.create_external_table(
    table_name =>'CHANNELS_EXT',
    credential_name =>'USER_CREDENTIAL',
    file_uri_list =>'&base_URL/channels.dat',
    format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true'),
    column_list => 'CHANNEL_ID NUMBER,
	CHANNEL_DESC VARCHAR2(20),
	CHANNEL_CLASS VARCHAR2(20),
	CHANNEL_CLASS_ID NUMBER,
	CHANNEL_TOTAL VARCHAR2(13),
	CHANNEL_TOTAL_ID NUMBER'
 );
end;
/


select * from CHANNELS_EXT 
/


