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

The error message encountered suggests that the COM class factory for the specified component is still not registered properly. It's possible that there may be other dependencies or issues preventing the successful registration of the component.

Here are a few suggestions you can try:

1. Ensure that you are running the commands to register the DLL files with administrative privileges. Right-click on the Command Prompt or PowerShell and choose "Run as administrator" before executing the registration commands.

2. Verify that the DLL files (DismCore.dll, DismCorePS.dll, DismHost.exe, DismProv.dll) are located in the correct directories (SysNative and System32 folders) and that they are not corrupted or missing.

3. Check if there are any antivirus or security software on your system that might be interfering with the registration process. Temporarily disable them and try registering the DLL files again.

4. Ensure that your system is up to date with the latest Windows updates. Some updates may include fixes for COM-related issues.
