
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(
    materialized='incremental',
    unique_key='id',
    incremental_strategy='merge',
)}}

WITH latest_unique_rows AS (
    SELECT
        CHANGE_TYPE,
        CHANGE_TIMESTAMP,
        CHANGE_USER_ID,
        SNAPSHOT_TIMESTAMP,
        ID,
        BENEFACTOR_ID,
        PROJECT_ID,
        PARENT_ID,
        NODE_TYPE,
        CREATED_ON,
        CREATED_BY,
        MODIFIED_ON,
        MODIFIED_BY,
        VERSION_NUMBER,
        FILE_HANDLE_ID,
        NAME,
        IS_PUBLIC,
        IS_CONTROLLED,
        IS_RESTRICTED,
        SNAPSHOT_DATE,
        EFFECTIVE_ARS,
        ANNOTATIONS,
        DERIVED_ANNOTATIONS,
        VERSION_COMMENT,
        VERSION_LABEL,
        ALIAS,
        ACTIVITY_ID,
        COLUMN_MODEL_IDS,
        SCOPE_IDS,
        ITEMS,
        REFERENCE,
        IS_SEARCH_ENABLED,
        DEFINING_SQL,
        INTERNAL_ANNOTATIONS,
        VERSION_HISTORY,
        PROJECT_STORAGE_USAGE
    FROM
        {{ source('synapse_data_warehouse', 'nodesnapshots') }}
    WHERE
        SNAPSHOT_DATE >= CURRENT_DATE - INTERVAL '30 DAYS' AND
        CREATED_ON > DATE('2025-09-10')
    QUALIFY ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY change_timestamp DESC, snapshot_timestamp DESC
        ) = 1
)
SELECT
    *
FROM
    latest_unique_rows
WHERE
    NOT (CHANGE_TYPE = 'DELETE' OR BENEFACTOR_ID = '1681355' OR PARENT_ID = '1681355') -- 1681355 is the synID of the trash can on Synapse
ORDER BY
    latest_unique_rows.id ASC

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
