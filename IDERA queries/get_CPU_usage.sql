select UTCCollectionDateTime
,ProcessorTimePercent
,PrivilegedTimePercent
from OSStatistics
where SQLServerID = (select SQLServerID from MonitoredSQLServers where InstanceName = 'servernamehere')
and UTCCollectionDateTime > dateadd(day,-30,getutcdate())
