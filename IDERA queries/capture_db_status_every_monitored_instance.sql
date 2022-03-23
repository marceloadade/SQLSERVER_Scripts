SET NOCOUNT ON

DECLARE @SQL NVARCHAR(2000)

drop table if exists #dbinfo

create table #dbinfo (
        [server_name] varchar(128)
      , [database_name] varchar(128)
      , [state_desc] varchar(128)
        )
      
DECLARE @server_name varchar(128)
      , @database_name varchar(128)
      , @state_desc varchar(128)
     

DECLARE C1 CURSOR
    FOR SELECT       
        InstanceName 
         FROM SQLdmRepository.dbo.MonitoredSQLServers
         WHERE Active = 1 and MaintenanceModeEnabled = 0
         and ServerVersion not like '8%'
           
    OPEN C1
    FETCH NEXT FROM C1
     INTO @Server_name

WHILE @@FETCH_STATUS = 0
      BEGIN

      set @SQL = N'select a.sname,a.name, state_desc
      from openrowset(''SQLNCLI'',''Server='+@server_name+''+';Trusted_Connection=yes;'',
      ''select @@servername as sname,name, state_desc from sys.databases;''
      ) as a;'
      print @sql
      begin try
      INSERT INTO #dbinfo(server_name,database_name,state_desc) EXEC (@SQL)
      FETCH NEXT FROM C1
      INTO @Server_name
      end try
      
      begin catch
      print @server_name
      print error_message()
      FETCH NEXT FROM C1
      INTO @Server_name
      end catch
END
CLOSE C1
DEALLOCATE C1

SELECT * FROM #dbinfo

select a.sname,a.name, state_desc
      from openrowset('SQLNCLI','Server=JAXSQLBIDEV01;Trusted_Connection=yes;',
      'select @@servername as sname,name, state_desc from sys.databases;'
      ) as a;

      select a.sname,a.name, state_desc
      from openrowset('SQLNCLI','Server=JAXSQLBIQA01;Trusted_Connection=yes;',
      'select @@servername as sname,name, state_desc from sys.databases;'
      ) as a;
