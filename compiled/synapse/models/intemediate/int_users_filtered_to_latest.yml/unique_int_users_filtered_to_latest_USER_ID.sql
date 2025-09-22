
    
    

select
    USER_ID as unique_field,
    count(*) as n_records

from DBT_TEST.synapse_latest.int_users_filtered_to_latest
where USER_ID is not null
group by USER_ID
having count(*) > 1


