
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select file_handle_id
from DBT_TEST.synapse_staging.stg_synapse__filesnapshots
where file_handle_id is null



  
  
      
    ) dbt_internal_test