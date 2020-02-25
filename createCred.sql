
-- -------------------------------------------------------------------------------------
-- CreateCred.sql: The following sql code demonstrates creating a credential to be used
--              for accessing an Oracle Object Storage bucket/file
--
--   Note: In order to execute this package the user must first be granted EXECUTE 
--         privilege from the ADMIN user.
-- -------------------------------------------------------------------------------------

begin
   dbms_cloud.create_credential(
       credential_name => 'MYUSER_CREDENTIAL' ,
       username => '<cloud_tenant_user_name>' , 
       password => 'aBcDeFgH-1x2y3z999' );
end ;
