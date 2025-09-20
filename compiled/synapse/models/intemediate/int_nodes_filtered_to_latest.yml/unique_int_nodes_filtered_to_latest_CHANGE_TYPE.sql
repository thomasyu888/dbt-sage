
    
    

select
    CHANGE_TYPE as unique_field,
    count(*) as n_records

from SAGE.DPE.int_nodes_filtered_to_latest
where CHANGE_TYPE is not null
group by CHANGE_TYPE
having count(*) > 1


