# Set up the cleanup flags
$CleanupFlags = @{
    "DownloadedProgramFiles" = $True
    "TemporaryInternetFiles" = $True
    "Thumbnails" = $True
    "RecycleBin" = $True
    "TemporaryFiles" = $True
    "DeliveryOptimizationFiles" = $True
    "SetupLogFiles" = $True
}

# Display a popup message to the user indicating that the cleanup is in progress
$CleanupOptions = New-Object -ComObject "WScript.Shell"
$CleanupOptions.Popup("Performing Disk Cleanup. Please wait...", 0, "Disk Cleanup", 64)

# Set the log file path
$LogPath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\DiskCleanup.log"

try {
    # Create or append to the log file
    $DateTime = Get-Date
    $LogEntry = "$DateTime - Disk Cleanup started.`r`n"
    Add-Content -Path $LogPath -Value $LogEntry

    # Create a DISM session and component
    $CleanupManager = New-Object -ComObject "Dism.DismManager"
    $CleanupSession = $CleanupManager.CreateSession()

    # Clear any pending cleanup operations
    $CleanupProvider = $CleanupManager.CreateComponent("Cleanup-Image")
    $CleanupProvider.RevertPendingActions()

    # Perform the Disk Cleanup operation using the cleanup flags
    $CleanupProvider.CleanupImage("/StartComponentCleanup /ResetBase", $CleanupFlags)
    $CleanupProvider.CleanupImage("/ResetBase", $CleanupFlags)

    # Write a log entry with the current date and time
    $DateTime = Get-Date
    $LogEntry = "$DateTime - Disk Cleanup completed successfully.`r`n"
    Add-Content -Path $LogPath -Value $LogEntry

    # Display a popup message to the user indicating that the cleanup is complete
    $CleanupOptions.Popup("Disk Cleanup completed successfully.", 0, "Disk Cleanup", 64)
}
