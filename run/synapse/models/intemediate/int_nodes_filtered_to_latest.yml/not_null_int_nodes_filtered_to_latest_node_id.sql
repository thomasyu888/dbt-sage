
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select node_id
from DBT_TEST.synapse_latest.int_nodes_filtered_to_latest
where node_id is null



  
  
      
    ) dbt_internal_test