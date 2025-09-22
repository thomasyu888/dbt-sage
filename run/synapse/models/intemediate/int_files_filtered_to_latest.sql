
  
    

create or replace transient table DBT_TEST.synapse_latest.int_files_filtered_to_latest
    
  (
    file_handle_id integer,
    change_type TEXT,
    change_user_id integer,
    created_by_user_id integer,
    created_on timestamp,
    modified_on timestamp,
    concrete_type TEXT,
    content_md5 TEXT,
    content_type TEXT,
    file_name TEXT,
    storage_location_id integer,
    content_size integer,
    bucket TEXT,
    key TEXT,
    preview_file_handle_id integer,
    is_preview boolean,
    status TEXT
    
    )

    
    
    
    as (
    select file_handle_id, change_type, change_user_id, created_by_user_id, created_on, modified_on, concrete_type, content_md5, content_type, file_name, storage_location_id, content_size, bucket, key, preview_file_handle_id, is_preview, status
    from (
        

WITH dedup_filesnapshots AS (
    SELECT
        *
    FROM
        DBT_TEST.synapse_staging.stg_synapse__filesnapshots
    WHERE
        SNAPSHOT_DATE >= CURRENT_DATE - INTERVAL '30 days' AND NOT IS_PREVIEW AND
        CREATED_ON > DATE('2025-09-10')
    QUALIFY
        ROW_NUMBER() OVER (
            PARTITION BY file_handle_ID
            ORDER BY CHANGE_TIMESTAMP DESC, SNAPSHOT_TIMESTAMP DESC
        ) = 1
)
SELECT 
    CHANGE_TYPE,
    CHANGE_USER_ID,
    file_handle_ID,
    CREATED_BY_user_id,
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
    PREVIEW_file_handle_ID,
    IS_PREVIEW,
    STATUS,
FROM 
    dedup_filesnapshots
WHERE
    CHANGE_TYPE != 'DELETE'
    ) as model_subq
    )
;


  