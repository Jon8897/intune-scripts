# Checks Windows update errors and logs them 
$updates = Get-WindowsUpdate -InstallationResult 'Failed', 'SucceededWithErrors'
$logfile = "$env:temp\WindowsUpdate.log"
$updates | Format-Table -AutoSize | Out-File -FilePath $logfile -Encoding UTF8