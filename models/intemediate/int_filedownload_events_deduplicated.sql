
{{ config(
    materialized='table',
    schema='latest',
)}}


WITH dedup_filedownload AS (
    SELECT
        TIMESTAMP,
        USER_ID,
        PROJECT_NODE_ID,
        FILE_HANDLE_ID,
        DOWNLOADED_FILE_HANDLE_ID,
        ASSOCIATION_OBJECT_ID,
        ASSOCIATION_OBJECT_TYPE,
        STACK,
        INSTANCE,
        RECORD_DATE,
        SESSION_ID
    FROM 
        {{ ref('stg_synapse__filedownload_events') }}
    WHERE
        ASSOCIATION_OBJECT_ID IS NOT NULL 
        AND USER_ID IS NOT NULL 
        AND ASSOCIATION_OBJECT_TYPE IS NOT NULL 
        AND RECORD_DATE IS NOT NULL
        AND RECORD_DATE >= DATE('2025-09-01')
        AND ROW_NUM = 1
)
SELECT 
*
FROM 
    dedup_filedownload