{{ config(
    materialized='incremental',
    unique_key='node_id',
    incremental_strategy='merge',
    schema='latest',
    on_schema_change='append_new_columns'
)}}


WITH dedup_userprofile AS (
    SELECT
        CHANGE_TYPE,
        CHANGE_TIMESTAMP,
        CHANGE_USER_ID,
        USER_ID,
        USER_NAME,
        FIRST_NAME,
        LAST_NAME,
        EMAIL,
        LOCATION,
        COMPANY,
        POSITION,
        CREATED_ON,
        IS_TWO_FACTOR_AUTH_ENABLED,
        INDUSTRY,
        TOS_AGREEMENTS
    FROM 
        {{ ref('stg_synapse__userprofilesnapshots') }}
    WHERE
        SNAPSHOT_DATE >= CURRENT_DATE - INTERVAL '14 days'
    QUALIFY
        ROW_NUMBER() OVER (
            PARTITION BY USER_ID
            ORDER BY CHANGE_TIMESTAMP DESC, SNAPSHOT_TIMESTAMP DESC
        ) = 1
),
flatten_tos_agreemnets as (
    select
        USER_ID,
        TO_TIMESTAMP(f.value:agreedOn::NUMBER / 1000) AS TOS_AGREEMENTS_AGREEON_TIME,
        f.value:version::STRING AS TOS_AGREEMENTS_AGREEON_VERSION
    from
        dedup_userprofile,
        lateral flatten(input => TOS_AGREEMENTS) f
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY USER_ID
        ORDER BY TOS_AGREEMENTS_AGREEON_TIME DESC
    ) = 1
)
SELECT 
    * exclude (LOCATION, COMPANY, POSITION, INDUSTRY, TOS_AGREEMENTS), 
    -- TODO: Need to revisit this section after the mixture of NULL and empty strings issue being resolved in https://sagebionetworks.jira.com/browse/SWC-7215
    NULLIF(LOCATION, '') AS LOCATION, 
    NULLIF(COMPANY, '') AS COMPANY, 
    NULLIF(POSITION, '') AS POSITION, 
    NULLIF(INDUSTRY, '') AS INDUSTRY, 
FROM 
    dedup_userprofile
LEFT JOIN
    flatten_tos_agreemnets USING (USER_ID)
