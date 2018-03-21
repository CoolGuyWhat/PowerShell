<#
    ############
    Get-DeviceConfig
    ############

    Author   : Aaron Price
    Company  : MSS IT
    Purpose  : SSH and Get configs of remote networked devices.
    Error Log: C:\Logs\

    ############
    Change Log
    ############
 
    Date: 09/03/2018 | Installed OpenSSH for PowerShell | Download here: https://github.com/PowerShell/Win32-OpenSSH/releases
    Date: 09/03/2018 | Project Started

    ############
    TO DO
    ############

    1. [ ] Fix Errors with Commands in Comment Block

    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    PowerShell SSH
    https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ssh-remoting-in-powershell-core?view=powershell-6


    ############
    Credits
    ############




    ############
    Last Working Run
    ############



#>

# Checks if OpenSSH is installed on the machine
if(!(Test-Path 'C:\Program Files\OpenSSH')) 
{
  Write-Verbose -Message 'Please install OpenSSH' -Verbose
  Write-Verbose -Message 'See Script comments for Details' -Verbose
  Pause
} 
Write-Verbose -Message 'Pause didnt work' -Verbose


# Creates Log Directory if it doesn't exist
$path = 'C:\temp\PSLog'
if(!(Test-Path $path))
 {
   New-Item -ItemType Directory -Force -Path $path
 }

# Writes Log File
"$Time 
$ErrorMessage" | Out-File C:\Logs\*Logfilename*.log -Append

