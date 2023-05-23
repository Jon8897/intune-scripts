# Set up the cleanup flags
$CleanupFlags = @{
    "DownloadedProgramFiles" = "$env:USERPROFILE\DownloadedProgramFiles"
    "TemporaryInternetFiles" = "$env:USERPROFILE\TemporaryInternetFiles"
    "Thumbnails" = "$env:USERPROFILE"
    "RecycleBin" = "$env:USERPROFILE\Recycle Bin"
    "TemporaryFiles" = "$env:USERPROFILE\AppData\Local\Temp"
    "DeliveryOptimizationFiles" = "$env:USERPROFILE\DeliveryOptimizationFiles"
    "SetupLogFiles" = "$env:USERPROFILE\SetupLogFiles"
}

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
            $Folder = $env:USERPROFILE + "\" + $flag
            if (-not (Test-Path $Folder)) {
                $Folder = Join-Path -Path ([System.IO.Path]::Combine([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonProgramFiles))) -ChildPath $flag
            }
            if (Test-Path $Folder) {
                try {
                    Remove-Item -Path $Folder -Recurse -Force -ErrorAction Stop
                    if (-not (Test-Path $Folder)) {
                        $LogEntry = "$DateTime - $($flag) cleaned up.`r`n"
                        Add-Content -Path $LogPath -Value $LogEntry
                    }
                    else {
                        $LogEntry = "$DateTime - Error occurred while cleaning up $($flag).`r`n"
                        Add-Content -Path $LogPath -Value $LogEntry
                    }
                }
                catch {
                    $ErrorMessage = $_.Exception.Message
                    $LogEntry = "$DateTime - Error occurred while cleaning up $($flag): $ErrorMessage`r`n"
                    Add-Content -Path $LogPath -Value $LogEntry
                }
            }
            else {
                $LogEntry = "$DateTime - Folder $($flag) does not exist.`r`n"
                Add-Content -Path $LogPath -Value $LogEntry
            }
        }
    }

    # Display a popup message to the user indicating that the cleanup is complete
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