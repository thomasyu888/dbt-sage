
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    CHANGE_TYPE as unique_field,
    count(*) as n_records

from SAGE.DPE.int_nodes_filtered_to_latest
where CHANGE_TYPE is not null
group by CHANGE_TYPE
having count(*) > 1



  
  
      
    ) dbt_internal_test