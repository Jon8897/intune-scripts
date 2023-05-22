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
5. After the cleanup is finished, a log file will be created in your temporary directory with the name `DiskCleanup.log`. You can refer to this file for details about the cleanup operation.

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

1. Ensure that you are running the script with administrative privileges. Right-click on PowerShell and choose "Run as administrator" before executing the script.

2. Make sure that the necessary dependencies and prerequisites for DISM are installed on your system. DISM is a built-in Windows component, but it may require additional components or updates. You can try updating your Windows system to the latest version.

3. Check if the DISM component is registered on your system. Open PowerShell and run the following command to check if the COM class is registered:
<pre>
[System.Runtime.InteropServices.Marshal]::IsComObject([Dism.DismManager])
</pre>
If the command returns False, it means the COM class is not registered. In that case, you may need to repair or reinstall the Windows operating system to restore the missing COM classes.
