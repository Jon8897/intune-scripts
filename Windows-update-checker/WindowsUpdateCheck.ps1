# Install PSWindowsUpdate module if not already installed
if (!(Get-Module -Name PSWindowsUpdate)) {
    Install-Module PSWindowsUpdate -Force

    # Check if the module was installed successfully
    if (!(Get-Module -Name PSWindowsUpdate)) {
        Write-Host "Failed to install PSWindowsUpdate module. Please try again later."
        Exit
    }
}
# Import the PSWindowsUpdate module
Import-Module -Name PSWindowsUpdate

# Check for Windows updates with the specified installation results
$installationResults = 'Failed', 'SucceededWithErrors'
$updates = Get-WUList -WindowsUpdate

# Filter the list of updates based on the installation results
$updates = $updates | Where-Object { $installationResults -contains $_.Result }

# Define the path to the log file
$logFile = "$env:Desktop\WindowsUpdate.log"

if ($updates) {
    # Create a loading bar
    Write-Progress -Activity "Checking for Windows updates..." -Status "Please wait..." -PercentComplete 0

    # Format the list of updates as a table and save it to the log file
    $updates | Format-Table -AutoSize | Out-File -FilePath $logFile -Encoding UTF8

    # Upload the log file to Intune
    Set-Content -Path "$env:USERPROFILE\Desktop\WindowsUpdate.log" -Value (Get-Content $logFile -Raw) -Encoding UTF8

    # Update the loading bar
    Write-Progress -Activity "Checking for Windows updates..." -Status "Completed" -PercentComplete 100 -Completed

    # Display success message
    Write-Host "Windows updates checked successfully. Please check the log file for details."
} else {
    # Write "Update not needed" to the log file
    "Update not needed" | Out-File -FilePath $logFile -Encoding UTF8

    # Upload the log file to Intune
    Set-Content -Path "$env:USERPROFILE\Desktop\WindowsUpdate.log" -Value "Update not needed" -Encoding UTF8

    # Display success message
    Write-Host "No Windows updates needed. Please check the log file for details."
}
