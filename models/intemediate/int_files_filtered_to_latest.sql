{{ config(
    materialized='incremental',
    unique_key='file_handle_id',
    incremental_strategy='merge',
    schema='latest',
    on_schema_change='append_new_columns'
)}}

WITH dedup_filesnapshots AS (
    SELECT
        *
    FROM
        {{ ref('stg_synapse__filesnapshots') }}
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
