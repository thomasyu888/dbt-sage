{{ config(
    materialized='incremental',
    unique_key='node_id',
    incremental_strategy='merge',
    schema='latest',
    on_schema_change='append_new_columns'
)}}

WITH latest_unique_rows AS (
    SELECT
        CHANGE_TYPE,
        CHANGE_USER_ID,
        node_id,
        benefactor_node_id,
        project_node_id,
        parent_node_id,
        NODE_TYPE,
        CREATED_ON,
        created_by_user_id,
        MODIFIED_ON,
        modified_by_user_id,
        VERSION_NUMBER,
        FILE_HANDLE_ID,
        node_name,
        IS_PUBLIC,
        is_controlled_access,
        is_restricted_access,
        effective_access_requirements,
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
        {{ ref('stg_synapse__nodesnapshots') }}
    WHERE
        SNAPSHOT_DATE >= CURRENT_DATE - INTERVAL '30 DAYS' AND
        CREATED_ON > DATE('2025-09-10')
    QUALIFY ROW_NUMBER() OVER (
            PARTITION BY node_id
            ORDER BY change_timestamp DESC, snapshot_timestamp DESC
        ) = 1
)
SELECT
    *
FROM
    latest_unique_rows
WHERE
    NOT (CHANGE_TYPE = 'DELETE' OR BENEFACTOR_NODE_ID = '1681355' OR PARENT_NODE_ID = '1681355') -- 1681355 is the synID of the trash can on Synapse
ORDER BY
    latest_unique_rows.node_id ASC

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
