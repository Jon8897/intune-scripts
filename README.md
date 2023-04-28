# Intune Scripts
This repository contains a collection of scripts for use with Microsoft Intune. These scripts can be used to automate common tasks, manage devices more efficiently, and improve the security of your environment.

## Prerequisites
To use these scripts, you will need to have the following:

- A Microsoft Intune subscription
- Access to the Microsoft Endpoint Manager admin center
- PowerShell version 5.1 or later

Usage
To use these scripts, follow these steps:

Sign in to the Microsoft Endpoint Manager admin center.
Click on "Devices" in the left-hand menu, and then click on "Scripts".
Click on "Add" to create a new script.
Copy the script code from the relevant file in this repository.
Paste the code into the "Script" section of the "Add script" blade.
Configure any settings or parameters as needed.
Click on "Create" to save the script.
Assign the script to devices or groups of devices as needed.
Scripts
Here are some of the scripts included in this repository:

WindowsUpdateCheck.ps1: A script that checks for Windows updates and logs the results to a file.
DiskCleanup.ps1: A script that runs the built-in Disk Cleanup tool to free up disk space on a device.
FileBackup.ps1: A script that copies important files to a cloud storage service, such as OneDrive or SharePoint.
AntivirusCheck.ps1: A script that checks for the presence of an antivirus solution on a device, and logs the results.
FirewallConfiguration.ps1: A script that configures the built-in Windows firewall on a device to block inbound traffic from certain ports or IP addresses.
Contributing
If you have a script that you think would be useful for other Intune users, feel free to contribute it to this repository. To contribute a script, create a new file in the scripts directory with a descriptive name and the .ps1 extension. Please also include a brief description of the script in the README file.

License
This repository is licensed under the MIT License. Please see the LICENSE file for details.

Disclaimer
These scripts are provided as-is and without warranty or support. It is your responsibility to test and validate these scripts before using them in a production environment. Use at your own risk.