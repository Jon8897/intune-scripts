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

# Create a DISM session and component, and configure the log file location and verbosity
$CleanupManager = New-Object -ComObject "Dism.DismManager"
$CleanupSession = $CleanupManager.CreateSession()

$CleanupSession.LogPath = "C:\Windows\Logs\DISM\dism.log"
$CleanupSession.LogLevel = 1

$CleanupProvider = $CleanupManager.CreateComponent("Cleanup-Image")

# Clear any pending cleanup operations
$CleanupProvider.RevertPendingActions()

# Perform the Disk Cleanup operation using the cleanup flags
$CleanupProvider.CleanupImage("/StartComponentCleanup /ResetBase", $CleanupFlags)
$CleanupProvider.CleanupImage("/ResetBase", $CleanupFlags)

# Display a popup message to the user indicating that the cleanup is complete
$CleanupOptions.Popup("Disk Cleanup completed successfully.", 0, "Disk Cleanup", 64)