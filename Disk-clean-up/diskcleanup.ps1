# Define the folders to be cleaned up and their corresponding paths
$CleanupFolders = @{
    "DownloadedProgramFiles" = [Environment]::GetFolderPath("CommonProgramFiles")
    "TemporaryInternetFiles" = [Environment]::GetFolderPath("InternetCache")
    "Thumbnails" = [Environment]::GetFolderPath("CommonPictures")
    "RecycleBin" = [Environment]::GetFolderPath("Desktop") + "\Recycle Bin"
    "TemporaryFiles" = [Environment]::GetFolderPath("Temp")
    "DeliveryOptimizationFiles" = [Environment]::GetFolderPath("LocalApplicationData") + "\Microsoft\Windows\DeliveryOptimization"
    "SetupLogFiles" = [Environment]::GetFolderPath("LocalApplicationData") + "\Microsoft\Windows\Setup\Logs"
}

# Define the cleanup flags
$CleanupFlags = @{
    "CompressOldFiles" = $false
    "RemoveOldUpdates" = $true
}

# Perform cleanup for each specified folder
$CleanupFolders.Keys | ForEach-Object {
    $folderName = $_
    $folderPath = $CleanupFolders[$folderName]

    Write-Host "$(Get-Date) - Disk Cleanup started."
    Write-Host "Folder Name: $folderName"
    Write-Host "Folder Path: $folderPath"

    if ($folderPath -eq $null) {
        Write-Host "Error: Folder path is null for $folderName"
        continue
    }

    if (Test-Path $folderPath) {
        Write-Host "$(Get-Date) - Folder $folderName exists. Running cleanup..."
        Remove-Item -Path $folderPath -Recurse -Force
        Write-Host "$(Get-Date) - Cleanup of folder $folderName completed."
    } else {
        Write-Host "$(Get-Date) - Folder $folderName does not exist."
    }
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
            $Folder = $CleanupFolders[$flag]
            if (-not (Test-Path $Folder)) {
                Write-Host "Folder $flag does not exist."
                $LogEntry = "$DateTime - Folder $flag does not exist.`r`n"
                Add-Content -Path $LogPath -Value $LogEntry
                continue
            }
            try {
                Remove-Item -Path $Folder -Recurse -Force -ErrorAction Stop
                if (-not (Test-Path $Folder)) {
                    Write-Host "$flag cleaned up."
                    $LogEntry = "$DateTime - $flag cleaned up.`r`n"
                    Add-Content -Path $LogPath -Value $LogEntry
                }
                else {
                    Write-Host "Error occurred while cleaning up $flag."
                    $LogEntry = "$DateTime - Error occurred while cleaning up $flag.`r`n"
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