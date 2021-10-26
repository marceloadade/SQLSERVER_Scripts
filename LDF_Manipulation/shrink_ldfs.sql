--Looping databases and shrinking ldfs


DECLARE @DBName varchar(300)
declare @filename varchar(1000)
DECLARE @SQL nvarchar(max)

 declare loopc cursor for select d.[name] as dbname , mf.name as filename
 from sys.master_files mf 
    JOIN sys.databases d 
        ON mf.database_id = d.database_id 
		WHERE d.database_id > 4 
		and d.state_desc = 'ONLINE' 
		and mf.type_desc='LOG'
		and mf.size/128 > 512

open loopc
fetch next from loopc into @dbname,@filename
   WHILE @@FETCH_STATUS = 0 
   BEGIN
   

   set @SQL =
      N'USE [' + @DBName + N']' + CHAR(13) + CHAR(10) 
    + N'DBCC SHRINKFILE (N''' + @filename + N''' , 512, TRUNCATEONLY)' 
    + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) 
	
	exec sp_executesql @SQL

	fetch next from loopc into  @dbname,@filename
	
	END      

	close loopc
	deallocate loopc