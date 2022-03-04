use SSISAudit;
GO
declare @PackageName nvarchar(255)='packegename' -- <- change the name of the package here:
declare @ExecutionID uniqueidentifier
select top 1 * from [dbo].[SSISPackageExecutionLog] where PackageName=@PackageName order by LogID desc
select top 1 @ExecutionID=ExecutionID from [dbo].[SSISPackageExecutionLog] where PackageName=@PackageName order by LogID desc
select @ExecutionID
select LogDate,SourceName,MessageDescription,* from [dbo].[SSISTaskExecutionAlerts] where EventType='E' and ExecutionID=@ExecutionID order by LogID
