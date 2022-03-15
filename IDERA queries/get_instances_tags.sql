select ms.SQLServerID,
ms.InstanceName,t.Name as IDERATAG
from MonitoredSQLServers ms inner join ServerTags st on st.SQLServerId = ms.SQLServerID
inner join Tags t on t.Id = st.TagId
where ms.Active = 1
