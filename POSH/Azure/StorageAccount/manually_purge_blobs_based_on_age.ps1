$StorageAccountName = 'bloblabpartition01'
$StorageAccountKey = 'add here'
$ContainerName = 'bkps'
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Get-AzureStorageBlob -Container $ContainerName -Blob *.* -Context $ctx | where {$_.LastModified -le (Get-Date).AddDays(-45)} | Remove-AzureStorageBlob

#safe to share
$StorageAccountName = 'name here'
$StorageAccountKey = 'will add when executing'
$ContainerName = 'crmsbk'
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Get-AzureStorageBlob -Container $ContainerName -Blob *.* -Context $ctx | where {$_.LastModified -le (Get-Date).AddDays(-45)} | Remove-AzureStorageBlob
