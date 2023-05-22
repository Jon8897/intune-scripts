# Disk Cleanup Script

This script performs disk cleanup by removing unnecessary files from your system. It utilizes the DISM (Deployment Image Servicing and Management) tool to perform the cleanup operations.

## Prerequisites

- Windows operating system
- PowerShell

## Usage

1. Open PowerShell.
2. Navigate to the directory where the script is located.
3. Run the script by executing the following command: .\diskcleanup.ps1
4. Follow the on-screen prompts and wait for the disk cleanup to complete.
5. After the cleanup is finished, a log file will be created in your directory with the name `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\DiskCleanup.log`. You can refer to this file for details about the cleanup operation.

## Cleanup Flags

The script uses the following cleanup flags to determine which files to remove. You can modify these flags in the script to customize the cleanup process according to your needs:

- DownloadedProgramFiles
- TemporaryInternetFiles
- Thumbnails
- RecycleBin
- TemporaryFiles
- DeliveryOptimizationFiles
- SetupLogFiles

## Troubleshooting

The error message you encountered indicates that the COM class factory for the component with CLSID {00000000-0000-0000-0000-000000000000} could not be retrieved. This error is typically caused by the component not being registered on your system.

In the case of the Disk Cleanup script using the DISM (Deployment Image Servicing and Management) tool, the COM component is required for performing the cleanup operations.

To resolve this issue, you can try the following steps:

1. Make sure you are running the script on a Windows operating system.
2. Open an elevated PowerShell session by right-clicking on PowerShell and selecting "Run as administrator".
3. Check if the necessary DLLs (Dynamic-Link Libraries) for DISM are registered correctly by running the following commands:
<pre>
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
</pre>

4. After running the above commands, try running the Disk Cleanup script again to see if the error is resolved.

If the issue persists, it's possible that there may be other underlying issues with the DISM component or your system configuration. In such cases, you may need to troubleshoot further or consider alternative disk cleanup methods.