use master;
set nocount on

 

-- set the appropriate data file path.

declare @data_file_path varchar(255)

set @data_file_path = 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA'

 

-- create temporary table to capture file names from directory.

if object_id('tempdb..#folderandfileinfo') is not null

 drop table #folderandfileinfo

 

create table #folderandfileinfo

(

 cid int identity(1,1) primary key clustered

, subdirectory varchar(255)

, depth int

, isfile int

)

 

-- populate temporary table with file names using xp_dirtree

insert into #folderandfileinfo

(

 [subdirectory]

, [depth]

, [isfile]

)

exec master..xp_dirtree

 @data_file_path

, 1

, 1

 

-- compare files found in the OS data file location to files associated with actual live databases.

-- WARNING: this does NOT take into consideration data files that have been detached. if you have detached

-- data files check with your DBA first before you clean up old orphaned data files.

select

 'path location' = @data_file_path

, 'orphaned data files' = subdirectory

 

from

 #folderandfileinfo

where

 subdirectory like '%df' -- compares ONLY to .mdf, .ndf, and .ldf

 and subdirectory not in

 (

 select right(smf.physical_name, charindex('\', reverse('\' + smf.physical_name)) - 1)

 from

 sys.master_files smf join sys.databases sd on smf.database_id = sd.database_id

 )