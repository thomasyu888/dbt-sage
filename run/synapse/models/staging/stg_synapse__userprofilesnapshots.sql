
  create or replace   view DBT_TEST.synapse_staging.stg_synapse__userprofilesnapshots
  
    
    
(
  
    "CHANGE_TYPE" COMMENT $$The type of change that occurred to the user profile, e.g., CREATE, UPDATE (Snapshotting does not capture DELETE change).$$, 
  
    "CHANGE_TIMESTAMP" COMMENT $$The time when any change to the user profile was made (e.g. create or update).$$, 
  
    "CHANGE_USER_ID" COMMENT $$The unique identifier of the user who made the change to the user profile.$$, 
  
    "SNAPSHOT_TIMESTAMP" COMMENT $$The time when the snapshot was taken (It is usually after the change happened).$$, 
  
    "USER_ID" COMMENT $$The unique identifier of the user.$$, 
  
    "USER_NAME" COMMENT $$The Synapse username.$$, 
  
    "FIRST_NAME" COMMENT $$The first name of the user.$$, 
  
    "LAST_NAME" COMMENT $$The last name of the user.$$, 
  
    "EMAIL" COMMENT $$The primary email of the user.$$, 
  
    "LOCATION" COMMENT $$The location of the user.$$, 
  
    "COMPANY" COMMENT $$The company where the user works.$$, 
  
    "POSITION" COMMENT $$The position of the user in the company.$$, 
  
    "SNAPSHOT_DATE" COMMENT $$The data is partitioned for fast and cost effective queries. The snapshot_timestamp field is converted into a date and stored in the snapshot_date field for partitioning. The date should be used as a condition (WHERE CLAUSE) in the queries.$$, 
  
    "CREATED_ON" COMMENT $$The creation time of the user profile.$$, 
  
    "IS_TWO_FACTOR_AUTH_ENABLED" COMMENT $$Indicates if the user had two factor authentication enabled when the snapshot was captured.$$, 
  
    "INDUSTRY" COMMENT $$The industry/discipline that this person is associated with.$$, 
  
    "TOS_AGREEMENTS" COMMENT $$Contains the list of all the term of service that the user agreed to, with their agreed on date and version.$$
  
)

  
  
  
  as (
    

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
FROM synapse_data_warehouse.synapse_raw.USERPROFILESNAPSHOT
  );

