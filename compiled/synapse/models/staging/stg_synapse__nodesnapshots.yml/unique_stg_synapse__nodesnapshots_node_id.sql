
    
    

select
    node_id as unique_field,
    count(*) as n_records

from DBT_TEST.synapse_staging.stg_synapse__nodesnapshots
where node_id is not null
group by node_id
having count(*) > 1


