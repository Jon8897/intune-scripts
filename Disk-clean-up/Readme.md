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

The error message you received indicates that the COM class factory for the component with CLSID {00000000-0000-0000-0000-000000000000} failed to retrieve because it is not registered. This error is typically caused by a missing or improperly registered component.

In your case, it seems that the required COM component for Disk Cleanup is not registered on your system. This could be due to various reasons, such as a corrupted installation or missing system files.

To resolve this issue, you can try the following steps:

1. Open an elevated Command Prompt by right-clicking on the Command Prompt icon and selecting "Run as administrator."
2. Open an elevated PowerShell session by right-clicking on PowerShell and selecting "Run as administrator".
<pre>
regsvr32 /s DismCore.dll
regsvr32 /s DismCorePS.dll
regsvr32 /s DismHost.exe
regsvr32 /s DismProv.dll
</pre>
3. After running the commands, restart your computer to ensure the changes take effect.
4. Once your system has restarted, try running the Disk Cleanup script again to see if the issue is resolved.
