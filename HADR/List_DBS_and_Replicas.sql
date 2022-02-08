select distinct d.name, d.compatibility_level, d.state_desc,
im.ag_name,
rs.synchronization_state_desc,
(select primary_replica from sys.dm_hadr_availability_group_states where group_id = rs.group_id ) as Primary_Replica
from sys.databases d left join sys.dm_hadr_database_replica_states rs
on d.database_id = rs.database_id
left join sys.dm_hadr_name_id_map im on im.ag_id=rs.group_id
where d.database_id > 4
order by d.compatibility_level

