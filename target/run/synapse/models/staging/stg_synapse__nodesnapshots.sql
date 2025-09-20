
  create or replace   view DBT_TEST.synapse_staging.stg_synapse__nodesnapshots
  
    
    
(
  
    "CHANGE_TYPE" COMMENT $$The type of change that occurred on the node, e.g., CREATE, UPDATE, DELETE.$$, 
  
    "CHANGE_TIMESTAMP" COMMENT $$The time when the change (created/updated/deleted) on the node is pushed to the queue for snapshotting.$$, 
  
    "CHANGE_USER_ID" COMMENT $$The unique identifier of the user who made the change to the node.$$, 
  
    "SNAPSHOT_TIMESTAMP" COMMENT $$The time when the snapshot was taken (usually after the change happened).$$, 
  
    "NODE_ID" COMMENT $$The unique identifier of the node (ID).$$, 
  
    "BENEFACTOR_NODE_ID" COMMENT $$The identifier of the ancestor node providing permissions (can be the node itself).$$, 
  
    "PROJECT_NODE_ID" COMMENT $$The project where the node resides. Empty for DELETE changes.$$, 
  
    "PARENT_NODE_ID" COMMENT $$The unique identifier of the parent in the node hierarchy.$$, 
  
    "NODE_TYPE" COMMENT $$The type of the node (project, folder, file, table, link, entityview, dockerrepo, submissionview, dataset, datasetcollection, materializedview, virtualtable).$$, 
  
    "CREATED_ON" COMMENT $$The creation time of the node.$$, 
  
    "CREATED_BY_USER_ID" COMMENT $$The unique identifier of the user who created the node.$$, 
  
    "MODIFIED_ON" COMMENT $$The most recent change time of the node.$$, 
  
    "MODIFIED_BY_USER_ID" COMMENT $$The unique identifier of the user who last modified the node.$$, 
  
    "VERSION_NUMBER" COMMENT $$The version of the node on which the change occurred, if applicable.$$, 
  
    "FILE_HANDLE_ID" COMMENT $$The unique identifier of the file handle if the node is a file, null otherwise.$$, 
  
    "NODE_NAME" COMMENT $$The name of the node.$$, 
  
    "IS_PUBLIC" COMMENT $$If true, READ permission is granted to all users (including anonymous) at snapshot time.$$, 
  
    "IS_CONTROLLED_ACCESS" COMMENT $$If true, an access requirement managed by the ACT is set on the node.$$, 
  
    "IS_RESTRICTED_ACCESS" COMMENT $$If true, a terms-of-use access requirement is set on the node.$$, 
  
    "SNAPSHOT_DATE" COMMENT $$Partitioning field. Derived from snapshot_timestamp for cost-effective queries.$$, 
  
    "EFFECTIVE_ACCESS_REQUIREMENTS" COMMENT $$List of access requirement IDs that apply to the entity at the time of the snapshot.$$, 
  
    "ANNOTATIONS" COMMENT $$JSON representation of user-assigned entity annotations.$$, 
  
    "DERIVED_ANNOTATIONS" COMMENT $$JSON representation of schema-derived entity annotations.$$, 
  
    "VERSION_COMMENT" COMMENT $$A short description assigned to this node version.$$, 
  
    "VERSION_LABEL" COMMENT $$A short label assigned to this node version.$$, 
  
    "ALIAS" COMMENT $$Alias assigned to a project entity if present.$$, 
  
    "ACTIVITY_ID" COMMENT $$Reference to the activity ID assigned to the node.$$, 
  
    "COLUMN_MODEL_IDS" COMMENT $$List of column IDs assigned to the schema (for tables, views, etc.).$$, 
  
    "SCOPE_IDS" COMMENT $$List of entity IDs included in the scope (for entity/submission views).$$, 
  
    "ITEMS" COMMENT $$List of entity references included in the scope (for dataset, dataset collections).$$, 
  
    "REFERENCE" COMMENT $$Reference to the linked target (for Link entities).$$, 
  
    "IS_SEARCH_ENABLED" COMMENT $$For table-like entities (EntityView, MaterializedView, etc.), whether full-text search is enabled.$$, 
  
    "DEFINING_SQL" COMMENT $$For SQL-driven tables (MaterializedView, VirtualTable), the underlying SQL query.$$, 
  
    "INTERNAL_ANNOTATIONS" COMMENT $$JSON of internal annotations (dataset checksum, size, count, etc.).$$, 
  
    "VERSION_HISTORY" COMMENT $$List of entity versions at snapshot time.$$, 
  
    "PROJECT_STORAGE_USAGE" COMMENT $$For project nodes, includes storage usage data per storage location.$$
  
)

  
  
  
  as (
    

SELECT
    CHANGE_TYPE,
    CHANGE_TIMESTAMP,
    CHANGE_USER_ID,
    SNAPSHOT_TIMESTAMP,
    ID as node_id,
    BENEFACTOR_ID as benefactor_node_id,
    PROJECT_ID as project_node_id,
    PARENT_ID as parent_node_id,
    NODE_TYPE,
    CREATED_ON,
    CREATED_BY as created_by_user_id,
    MODIFIED_ON,
    MODIFIED_BY as modified_by_user_id,
    VERSION_NUMBER,
    FILE_HANDLE_ID,
    NAME AS node_name,
    IS_PUBLIC,
    IS_CONTROLLED AS is_controlled_access,
    IS_RESTRICTED AS is_restricted_access,
    SNAPSHOT_DATE,
    EFFECTIVE_ARS AS effective_access_requirements,
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
    synapse_data_warehouse.synapse_raw.nodesnapshots
  );

