WITH LastRestores AS
(
SELECT
    DatabaseName = [d].[name] ,
   -- [d].[create_date] ,
 --   [d].[compatibility_level] ,
  --  [d].[collation_name] ,
    r.restore_date,
    RowNum = ROW_NUMBER() OVER (PARTITION BY d.Name ORDER BY r.[restore_date] DESC)
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.[restorehistory] r ON r.[destination_database_name] = d.Name
where database_id > 4
)
SELECT DatabaseName,Restore_date
FROM [LastRestores]
where RowNum = 1
order by 2