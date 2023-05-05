# Check for updates using Windows Update settings
$updates = Get-WindowsUpdate -MaxUpdatesPerDownload 100 -Download -Install

# Define the path to the log file
$logFile = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\WindowsUpdate.log"

if ($updates) {
    # Create a loading bar
    Write-Progress -Activity "Checking for Windows updates..." -Status "Please wait..." -PercentComplete 0 -Verbose

    # Format the list of updates as a table and append it to the log file
    $updates | Format-Table -AutoSize | Out-File -FilePath $logFile -Append -Encoding UTF8

    # Upload the log file to Intune
    Set-Content -Path $logFile -Value (Get-Content $logFile -Raw) -Encoding UTF8

    # Update the loading bar
    Write-Progress -Activity "Checking for Windows updates..." -Status "Completed" -PercentComplete 100 -Completed -Verbose

   # Display success message
   $logMessage = "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss'). Windows updates checked successfully. Please check the log file for details."
   Write-Host $logMessage

   # Write the log message to the log file
   Add-Content -Path $logFile -Value $logMessage
} else {
    # Write "Update not needed" to the log file
    "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss'). Update not needed" | Out-File -FilePath $logFile -Append -Encoding UTF8

    # Display success message
    $logMessage = "No Windows updates needed. Please check the log file for details."
    Write-Host $logMessage

    # Write the log message to the log file
    Add-Content -Path $logFile -Value $logMessage
}