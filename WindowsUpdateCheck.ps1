# Define the installation results that we want to check for (Failed, SucceededWithErrors)
$installationResults = 'Failed', 'SucceededWithErrors'

# Get a list of Windows updates with the specified installation results
$updates = Get-WindowsUpdate -InstallationResult $installationResults

# Define the path to the log file
$logFile = "$env:temp\WindowsUpdate.log"

# Format the list of updates as a table and save it to the log file
$updates | Format-Table -AutoSize | Out-File -FilePath $logFile -Encoding UTF8

# Display a message indicating that the script has completed
Write-Host "Windows update check completed. Results saved to $logFile."