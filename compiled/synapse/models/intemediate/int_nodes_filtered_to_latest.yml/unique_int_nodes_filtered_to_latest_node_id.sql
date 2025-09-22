
    
    

select
    node_id as unique_field,
    count(*) as n_records

from DBT_TEST.synapse_latest.int_nodes_filtered_to_latest
where node_id is not null
group by node_id
having count(*) > 1


