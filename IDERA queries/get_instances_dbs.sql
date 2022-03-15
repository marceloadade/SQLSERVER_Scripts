select
ms.InstanceName,db.DatabaseName
from MonitoredSQLServers ms inner join SQLServerDatabaseNames db on db.SQLServerID = ms.SQLServerID
where ms.Active = 1
order by InstanceName
