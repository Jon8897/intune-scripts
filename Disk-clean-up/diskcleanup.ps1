# Register DISM DLLs
$WinDir = $env:windir
$SysNativeFolder = Join-Path -Path $WinDir -ChildPath 'SysNative'
$System32Folder = Join-Path -Path $WinDir -ChildPath 'System32'

# Register the DLLs from the SysNative folder
$DismDLLs = @('DismCore.dll', 'DismCorePS.dll', 'DismHost.exe', 'DismProv.dll')
$DismDLLs | ForEach-Object {
    $DllPath = Join-Path -Path $SysNativeFolder -ChildPath $_
    if (Test-Path $DllPath) {
        regsvr32 /s $DllPath
    }
}

# Register the DLLs from the System32 folder
$DismDLLs | ForEach-Object {
    $DllPath = Join-Path -Path $System32Folder -ChildPath $_
    if (Test-Path $DllPath) {
        regsvr32 /s $DllPath
    }
}

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
catch {
    # Write an error log entry if any error occurs
    $ErrorMessage = $_.Exception.Message
    $DateTime = Get-Date
    $ErrorLogEntry = "$DateTime - Error occurred during Disk Cleanup:`r`n$ErrorMessage`r`n"
    Add-Content -Path $LogPath -Value $ErrorLogEntry

    # Display a popup message to the user indicating the error
    $CleanupOptions.Popup("An error occurred during Disk Cleanup. Please check the log file for details.", 0, "Disk Cleanup Error", 16)
}