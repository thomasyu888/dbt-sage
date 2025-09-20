
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select CHANGE_TYPE
from DBT_TEST.synapse_latest.int_nodes_filtered_to_latest
where CHANGE_TYPE is null



  
  
      
    ) dbt_internal_test