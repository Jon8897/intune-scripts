# Define the installation results that we want to check for (Failed, SucceededWithErrors)
$installationResults = 'Failed', 'SucceededWithErrors'

# Get a list of Windows updates with the specified installation results
$updates = Get-WindowsUpdate -InstallationResult $installationResults

# Define the path to the log file
$logFile = "$env:temp\WindowsUpdate.log"

# Format the list of updates as a table and save it to the log file
$updates | Format-Table -AutoSize | Out-File -FilePath $logFile -Encoding UTF8

# Upload the log file to Intune
Set-Content -Path "C:\Users\jonathankeefe.ASTONBERKELEY\OneDrive - Aston Berkeley Systems Ltd\Desktop\Projects\git-projects\intune-scripts\Windows-update-checker\WindowsUpdate.log" -Value (Get-Content $logFile -Raw) -Encoding UTF8