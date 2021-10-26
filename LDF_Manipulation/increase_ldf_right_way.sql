--loop to create the right LOG file
declare @initial_size int = 8192, @increase_size int =0

declare @sql_command nvarchar(2000)


while (@initial_size+@increase_size <= 204800) --change here
BEGIN
set @sql_command = N'alter database <<dbname>> modify file --change here
(name = <<logfiledbname>>, size = '+cast(@initial_size+@increase_size as nvarchar(10))+' Mb);'

exec sp_executesql @statement = @sql_command
set @increase_size = @increase_size+8192

END