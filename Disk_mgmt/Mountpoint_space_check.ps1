Get-WmiObject Win32_Volume  -computername COMPUTERNAME | 
Select-Object driveletter,Label,@{Name='freespace';Expression={[math]::Round($_.freespace/1GB,2)}},@{Name='capacity';Expression={[math]::Round($_.capacity/1GB,2)}}
# As in https://www.sqlserver-dba.com/2021/06/get-free-disk-space-for-mount-points-using-powershell-.html
# replace COMPUTERNAME with the name of the remote computer you want to check mountpoint space.
