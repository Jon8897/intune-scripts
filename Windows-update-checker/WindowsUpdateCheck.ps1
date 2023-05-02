# Check for Windows updates with the specified installation results
$installationResults = 'Failed', 'SucceededWithErrors'
$updates = Get-WUList -WindowsUpdate

# Filter the list of updates based on the installation results
$updates = $updates | Where-Object { $installationResults -contains $_.Result }

# Define the path to the log file
$logFile = "$env:Desktop\WindowsUpdate.log"

# Format the list of updates as a table and save it to the log file
$updates | Format-Table -AutoSize | Out-File -FilePath $logFile -Encoding UTF8

# Upload the log file to Intune
Set-Content -Path "$env:USERPROFILE\Desktop\WindowsUpdate.log" -Value (Get-Content $logFile -Raw) -Encoding UTF8