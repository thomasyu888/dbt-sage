
  create or replace   view DBT_TEST.synapse_staging.stg_synapse__filedownload_events
  
    
    
(
  
    "TIMESTAMP" COMMENT $$The time when the file download event is pushed to the queue for recording, after generating the pre-signed URL.
$$, 
  
    "USER_ID" COMMENT $$PRIMARY KEY (Composite). The ID of the user who downloaded the file.
$$, 
  
    "PROJECT_NODE_ID" COMMENT $$Unique identifier of the project where the downloaded entity resides. Applicable only for FileEntity and TableEntity.
$$, 
  
    "FILE_HANDLE_ID" COMMENT $$Unique identifier of the file handle.
$$, 
  
    "DOWNLOADED_FILE_HANDLE_ID" COMMENT $$Unique identifier of the zip file handle containing the downloaded file when requested as a zip/package, otherwise the ID of the file handle itself.
$$, 
  
    "ASSOCIATION_OBJECT_ID" COMMENT $$PRIMARY KEY (Composite). Unique identifier of the Synapse object (without "syn" prefix) that wraps the file.
$$, 
  
    "ASSOCIATION_OBJECT_TYPE" COMMENT $$PRIMARY KEY (Composite). Type of the Synapse object that wraps the file, e.g., FileEntity, TableEntity, WikiAttachment, WikiMarkdown, UserProfileAttachment, MessageAttachment, TeamAttachment.
$$, 
  
    "STACK" COMMENT $$The stack (prod, dev) on which the download request was processed.
$$, 
  
    "INSTANCE" COMMENT $$The version of the stack that processed the download request.
$$, 
  
    "RECORD_DATE" COMMENT $$PRIMARY KEY (Composite). Partitioning column derived from TIMESTAMP for efficient queries. Should be used in WHERE clauses.
$$, 
  
    "SESSION_ID" COMMENT $$UUID assigned to the API request that triggered this download. Can be joined with `processedaccessrecord` on `session_id` to retrieve additional metadata.
$$, 
  
    "ROW_NUM" COMMENT $$Indexed by `USER_ID`, `ASSOCIATION_OBJECT_ID`, `ASSOCIATION_OBJECT_TYPE`, and `RECORD_DATE` to define a download event. A value of 1 is the "first" download event.
$$
  
)

  
  
  
  as (
    

SELECT
    TIMESTAMP,
    USER_ID,
    PROJECT_ID as project_node_id,
    FILE_HANDLE_ID,
    DOWNLOADED_FILE_HANDLE_ID,
    ASSOCIATION_OBJECT_ID,
    ASSOCIATION_OBJECT_TYPE,
    STACK,
    INSTANCE,
    RECORD_DATE,
    SESSION_ID,
    ROW_NUMBER() OVER (
        PARTITION BY USER_ID, ASSOCIATION_OBJECT_ID, ASSOCIATION_OBJECT_TYPE, RECORD_DATE
        ORDER BY TIMESTAMP DESC
    ) as ROW_NUM
FROM 
    synapse_data_warehouse.synapse_raw.FILEDOWNLOAD
  );

