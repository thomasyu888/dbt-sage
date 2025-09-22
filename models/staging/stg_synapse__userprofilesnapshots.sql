

{{ config(
    materialized='view',
    schema='staging'
)}}

SELECT
    CHANGE_TYPE,
    CHANGE_TIMESTAMP,
    CHANGE_USER_ID,
    SNAPSHOT_TIMESTAMP,
    ID as USER_ID,
    USER_NAME,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    LOCATION,
    COMPANY,
    POSITION,
    SNAPSHOT_DATE,
    CREATED_ON,
    IS_TWO_FACTOR_AUTH_ENABLED,
    INDUSTRY,
    TOS_AGREEMENTS
FROM {{ source('synapse_data_warehouse', 'USERPROFILESNAPSHOT') }}
