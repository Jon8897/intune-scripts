# Disk Cleanup Script

This script performs disk cleanup by removing unnecessary files from your system. It utilizes the DISM (Deployment Image Servicing and Management) tool to perform the cleanup operations.

## Prerequisites

- Windows operating system
- PowerShell

### Where to find Logs

<pre>
C:\ProgramData\Microsoft\IntuneManagementExtension\Logs
</pre>

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

#### Removing DISM as causing to many un-fixable  errors. ####S

##### TEST 1 ##### 

###### 22/05/2023 ######

- 22/05/2023 17:07:12 - Disk Cleanup started.
  - Checked pc for results and nothing was cleaned 
  - Need to figure out issues

- 23/05/2023 - Disk cleanup Logging Errors
 - Errors are now being logged to see what issues I am facing

##### ISSUES #####

- Program ran said it was successfully but all my files are still full and nothing has been deleted.

1. Permission issues: Ensure that the user running the script has sufficient permissions to delete files/folders in the specified locations.

2. Folder paths: Verify that the folder paths specified in the cleanup flags ($CleanupFlags) are correct for your system. You can update them if necessary.

3. Silent errors: It's possible that errors are occurring during the cleanup process, but the -ErrorAction SilentlyContinue parameter is suppressing the error messages. You can remove this parameter temporarily to see if any error messages are displayed.

4. Confirmation prompts: If there are confirmation prompts during the deletion process, the script may be waiting for user input, causing it to appear as if no cleanup is being performed. To bypass confirmation prompts, you can use the -Confirm:$false parameter with the Remove-Item cmdlet.

- I recommend checking the permissions, verifying the folder paths, and removing the -ErrorAction parameter to troubleshoot the issue further. Additionally, review the log file (C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\DiskCleanup.log) to see if any errors or relevant information are logged.