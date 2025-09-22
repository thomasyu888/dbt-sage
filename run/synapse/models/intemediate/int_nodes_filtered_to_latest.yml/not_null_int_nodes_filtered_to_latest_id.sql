
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from SAGE.DPE_my_custom_schema.int_nodes_filtered_to_latest
where id is null



  
  
      
    ) dbt_internal_test