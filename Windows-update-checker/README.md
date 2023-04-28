# WindowsUpdateCheck.ps1
This PowerShell script checks for Windows updates with installation results of 'Failed' or 'SucceededWithErrors' and logs the results to a file. The log file can be uploaded to Intune as a device configuration script output to view the results for each device.

#### to run Invoke-Expression .\WindowsUpdateCheck.ps1

## Prerequisites
To use this script, you will need to have the following:

- A Microsoft Intune subscription
- Access to the Microsoft Endpoint Manager admin center
- PowerShell version 5.1 or later

## Usage
To use this script, follow these steps:

1. Sign in to the Microsoft Endpoint Manager admin center.
2. Click on "Devices" in the left-hand menu, and then click on "Scripts".
3. Click on "Add" to create a new script.
4. Copy the script code from the WindowsUpdateCheck.ps1 file in this repository.
5. Paste the code into the "Script" section of the "Add script" blade.
6. Configure any settings or parameters as needed.
7. Click on "Create" to save the script.
8. Assign the script to devices or groups of devices as needed.

## Output
This script generates a log file with the results of the Windows update check. The log file is saved to the user's temp directory with the name WindowsUpdate.log. You can upload the log file to Intune as a device configuration script output to view the results for each device.

## Uploading to Intune
To upload the log file to Intune, you can use the Set-CMDeviceConfigurationScriptResult cmdlet in PowerShell. See the script code for an example of how to upload the log file.

Note that uploading the log file to Intune may incur additional costs for storage and data transfer. You may want to configure retention policies to delete old log files after a certain period of time to manage storage costs.

### Contributing
If you have a script that you think would be useful for other Intune users, feel free to contribute it to this repository. To contribute a script, create a new file in the scripts directory with a descriptive name and the .ps1 extension. Please also include a brief description of the script in the README file.

### License
This repository is licensed under the MIT License. Please see the LICENSE file for details.

# Disclaimer #

This script is provided as-is and without warranty or support. It is your responsibility to test and validate this script before using it in a production environment. Use at your own risk.