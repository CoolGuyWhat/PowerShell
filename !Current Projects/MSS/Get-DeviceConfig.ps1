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
    https://vwiki.co.uk/SSH_Client_(PowerShell)



    ############
    Credits
    ############

    Developed original working code
    https://stackoverflow.com/questions/24436507/execute-multiple-commands-via-ssh-and-powershell


    ############
    Last Working Run
    ############



#>
<#

    .Synopsis
    Short description
    .DESCRIPTION
    Long description
    .EXAMPLE
    Example of how to use this cmdlet
    .EXAMPLE
    Another example of how to use this cmdlet

    function Get-DeviceConfig
    {

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Param1,

        # Param2 help description
        [int]
        $Param2
    )

    Begin
    {
    }
    Process
    {
    }
    End
    {
    }
    }
#>

# Checks if Renci dll is on the machine and stops if the library is not found in the location specified
$sshtestpath = 'C:\SSH\lib\net40\Renci.SshNet.dll'
if(!(Test-Path -path $sshtestpath)) 
{
  Write-Verbose -Message 'Please Extract Renci.sshnet.dll to the Path specified' -Verbose
  Write-Verbose -Message 'See Script comments for Details' -Verbose
  Exit
} 
Write-Verbose -Message 'Loading SSH Library dll ...' -Verbose

[void][reflection.assembly]::LoadFrom( (Resolve-Path $DllPath) )

# Connect to MSS Sophos

Set-Location -Path 'C:\Program Files\OpenSSH\'

[string]$ssh = 'C:\Program Files\OpenSSH\ssh.exe'
[string]$arguments = '192.162.1.1 :l Admin'

Invoke-Expression -command "$ssh $arguments"
Invoke-Command -ComputerName $PC -ScriptBlock {& 'C:\Program Files\OpenSSH\ssh.exe''192.168.1.1 -l admin'}
