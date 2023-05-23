# Define the folders to be cleaned up and their corresponding paths
$CleanupFolders = @{
    "DownloadedProgramFiles" = [Environment]::GetFolderPath("CommonProgramFiles") + "\$env:DownloadedProgramFiles"
    "TemporaryInternetFiles" = [Environment]::GetFolderPath("InternetCache") + "\$env:TemporaryInternetFiles"
    "Thumbnails" = [Environment]::GetFolderPath("CommonPictures") + "\$env:Thumbnails"
    "RecycleBin" = [Environment]::GetFolderPath("Desktop") + "\$env:RecycleBin"
    "TemporaryFiles" = [Environment]::GetFolderPath("Temp") + "\$env:Temp"
    "DeliveryOptimizationFiles" = [Environment]::GetFolderPath("LocalApplicationData") + "\$env:DeliveryOptimization"
    "SetupLogFiles" = [Environment]::GetFolderPath("LocalApplicationData") + "\$env:SetupLogFiles"
}

# Define the cleanup flags
$CleanupFlags = @{
    "DownloadedProgramFiles" = $False
    "TemporaryInternetFiles" = $True
    "Thumbnails" = $True
    "RecycleBin" = $True
    "TemporaryFiles" = $True
    "DeliveryOptimizationFiles" = $False
    "SetupLogFiles" = $False
}

# Display a popup message to the user indicating that the cleanup is in progress
$CleanupOptions = New-Object -ComObject "WScript.Shell"
$CleanupOptions.Popup("Performing Disk Cleanup. Please wait...", 0, "Disk Cleanup", 64)

# Define the schedule for the disk cleanup
$Trigger = New-JobTrigger -Daily -At "07:00 AM"   # Modify the time as per your requirements

# Define the script block to be executed
$Action = {
    # Display a popup message to the user indicating that the cleanup is in progress
    $CleanupOptions = New-Object -ComObject "WScript.Shell"
    $CleanupOptions.Popup("Performing Disk Cleanup. Please wait...", 0, "Disk Cleanup", 64)

    # Set the log file path
    $LogPath = "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\DiskCleanup.log"

    try {
        # Create or append to the log file
        $DateTime = Get-Date
        $LogEntry = "$DateTime - Disk Cleanup started.`r`n"
        Add-Content -Path $LogPath -Value $LogEntry

        # Clean up each specified folder and log the result
        foreach ($flag in $CleanupFlags.Keys) {
            if ($CleanupFlags[$flag]) {
                Write-Host "Cleaning up $flag"
                $Folder = $CleanupFolders[$flag]
                if ([string]::IsNullOrWhiteSpace($Folder)) {
                    Write-Host "Folder path for $flag is empty."
                    $LogEntry = "$DateTime - Folder path for $flag is empty.`r`n"
                    Add-Content -Path $LogPath -Value $LogEntry
                    continue
                }
                if (-not (Test-Path $Folder)) {
                    Write-Host "Folder $flag does not exist."
                    $LogEntry = "$DateTime - Folder $flag does not exist.`r`n"
                    Add-Content -Path $LogPath -Value $LogEntry
                    continue
                }
                try {
                    Remove-Item -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue -ErrorVariable RemoveError > $null
                    if (-not $RemoveError) {
                        Write-Host "$flag cleaned up."
                        $LogEntry = "$DateTime - $flag cleaned up.`r`n"
                        Add-Content -Path $LogPath -Value $LogEntry
                    }
                    else {
                        Write-Host "Error occurred while cleaning up $($flag): $RemoveError"
                        $LogEntry = "$DateTime - Error occurred while cleaning up $($flag): $RemoveError`r`n"
                        Add-Content -Path $LogPath -Value $LogEntry
                    }
                }
                catch {
                    $ErrorMessage = $_.Exception.Message
                    Write-Host "Error occurred while cleaning up $($flag): $ErrorMessage"
                    $LogEntry = "$DateTime - Error occurred while cleaning up $($flag): $ErrorMessage`r`n"
                    Add-Content -Path $LogPath -Value $LogEntry
                }
            }
        }

        # Display a popup message to the user indicating that the cleanup is complete
        $CleanupOptions = New-Object -ComObject "WScript.Shell"
        $CleanupOptions.Popup("Disk Cleanup completed successfully.", 0, "Disk Cleanup", 64)
    }
    catch {
        # Write an error log entry if any error occurs
        $ErrorMessage = $_.Exception.Message
        $DateTime = Get-Date
        $ErrorLogEntry = "$DateTime - Error occurred during Disk Cleanup:`r`n$ErrorMessage`r`n"
        Add-Content -Path $LogPath -Value $ErrorLogEntry

        # Display a popup message to the user indicating the error
        $CleanupOptions.Popup("An error occurred during Disk Cleanup. Please check the log file for details.", 0, "Disk Cleanup Error", 16)
    }
}

# Register the scheduled job
Register-ScheduledJob -Name "DiskCleanupJob" -Trigger $Trigger -ScriptBlock $Action