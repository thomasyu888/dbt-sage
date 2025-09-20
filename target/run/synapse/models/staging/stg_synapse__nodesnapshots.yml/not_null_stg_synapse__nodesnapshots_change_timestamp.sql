
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select change_timestamp
from DBT_TEST.synapse_staging.stg_synapse__nodesnapshots
where change_timestamp is null



  
  
      
    ) dbt_internal_test