
  create or replace   view DBT_TEST.synapse_staging.stg_synapse__filesnapshots
  
    
    
(
  
    "CHANGE_TYPE" COMMENT $$The type of change that occurred on the file handle, e.g., CREATE, UPDATE, DELETE.$$, 
  
    "CHANGE_TIMESTAMP" COMMENT $$The time when the change (created/updated/deleted) on the file handle is pushed to the queue for snapshotting.$$, 
  
    "CHANGE_USER_ID" COMMENT $$The unique identifier of the user who made the change to the file handle.$$, 
  
    "SNAPSHOT_TIMESTAMP" COMMENT $$The time when the snapshot was taken (usually after the change happened).$$, 
  
    "FILE_HANDLE_ID" COMMENT $$The unique identifier of the file handle (ID). Primary key for this table.$$, 
  
    "CREATED_BY_USER_ID" COMMENT $$The unique identifier of the user who created the file handle.$$, 
  
    "CREATED_ON" COMMENT $$The creation timestamp of the file handle.$$, 
  
    "MODIFIED_ON" COMMENT $$The most recent change time of the file handle.$$, 
  
    "CONCRETE_TYPE" COMMENT $$The type of the file handle (S3FileHandle, ProxyFileHandle, ExternalFileHandle, ExternalObjectStoreFileHandle, GoogleCloudFileHandle).$$, 
  
    "CONTENT_MD5" COMMENT $$The MD5 hash (using MD5 algorithm) of the file referenced by the file handle.$$, 
  
    "CONTENT_TYPE" COMMENT $$Metadata about the content of the file, e.g., application/json, application/zip, application/octet-stream.$$, 
  
    "FILE_NAME" COMMENT $$The name of the file referenced by the file handle.$$, 
  
    "STORAGE_LOCATION_ID" COMMENT $$The identifier of the environment where the physical files are stored.$$, 
  
    "CONTENT_SIZE" COMMENT $$The size of the file referenced by the file handle.$$, 
  
    "BUCKET" COMMENT $$The bucket where the file is physically stored (applicable for S3 and GCP, otherwise empty).$$, 
  
    "KEY" COMMENT $$The key name that uniquely identifies the object (file) in the bucket.$$, 
  
    "PREVIEW_FILE_HANDLE_ID" COMMENT $$The identifier of the file handle that contains a preview of the file referenced by this file handle.$$, 
  
    "IS_PREVIEW" COMMENT $$If true, the file referenced by this file handle is a preview of another file.$$, 
  
    "STATUS" COMMENT $$The availability status of the file referenced by the file handle (AVAILABLE, UNLINKED, ARCHIVED).$$, 
  
    "SNAPSHOT_DATE" COMMENT $$Partitioning field. Derived from snapshot_timestamp for cost-effective queries.$$
  
)

  
  
  
  as (
    

SELECT 
    CHANGE_TYPE,
    CHANGE_TIMESTAMP,
    CHANGE_USER_ID,
    SNAPSHOT_TIMESTAMP,
    ID AS FILE_HANDLE_ID,
    CREATED_BY AS CREATED_BY_USER_ID,
    CREATED_ON,
    MODIFIED_ON,
    CONCRETE_TYPE,
    CONTENT_MD5,
    CONTENT_TYPE,
    FILE_NAME,
    STORAGE_LOCATION_ID,
    CONTENT_SIZE,
    BUCKET,
    KEY,
    PREVIEW_ID as PREVIEW_FILE_HANDLE_ID,
    IS_PREVIEW,
    STATUS,
    SNAPSHOT_DATE
FROM
    synapse_data_warehouse.synapse_raw.FILESNAPSHOTS
  );

