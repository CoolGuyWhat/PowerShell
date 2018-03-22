<#
    ############
    Get-BitLockerRecovery
    ############

    Author   : Aaron Price
    Company  : AFG
    Purpose  : Function for AFG IT to quickly retrieve the BitLocker Password and LAPS Key if necessary from a Computer in AD
    Error Log: ---

    ############
    Change Log
    ############

    Date: 14/09/2017 | Project started
    Date:         '' | Added initial Script
    Date:         '' | Get-ADComputer doesnt retrieve required AD Attributes :(
    Date: 19/09/2017 | Updated Logic with $Credential if statements to correctly execute
    Date:         '' | Added Yes/No Prompt for Authentication
    Date: 21/09/2017 | Removed Y/N Prompt and added switch variables
    Date:         '' | Fixed if statement logic for if,if not $Credentials -eq $null
    Date: 22/09/2017 | Added Check-LoadedModule function
    Date: 26/09/2017 | Testing Check-LoadedModule function is working correctly. >$LoadedModules should return value | Isnt
    Date:         '' | Tested $BLkey works and fixed Write-host
    Date:         '' | Changed Parameter $Computer to $PC to avoid confusion with $ENV:ComputerName
    Date:         '' | Removed the Write-Host Outputs because it doesn't format correctly. Replaced with Write-Output and added $Output variables
    Date: 27/09/2017 | Skinned back script to barebones and Tested. Formatted. Running correctly.
    Date: 28/09/2017 | Added an Alias for the function
    Date:         '' | Trimmed the Outputs so there aren't huge spaces between the outputs
    Date: 22/03/2018 | Discovered that the -Laps wasnt retreving the Attribte Correctly. Reconfigured to Get-ADObject to work properly.


    ############
    TO DO
    ############

    1. [X] Test Working
    2. [-] Get Last User Logged on $Computer - Looks like it might have to be set in different function
    3. [X] Confirm LAPS Password is working
    4. [-] Fix Check-LoadedModule Function
    5. [X] Rename msFVE-RecoveryPassword output to BitLocker Recovery Key
    6. [X] Get Output working correctly | Investigate different options to Output to console
    7. [ ] Add OS and OS Version to Output

    ############
    Sources
    ############

    https://ramblingcookiemonster.github.io/Building-PowerShell-Functions-Best-Practices/

    # Reference
    http://jackstromberg.com/tag/msfve-recoverypassword/

    # Yes No Prompt
    https://technet.microsoft.com/en-us/library/ff730939.aspx

    <#
    .Synopsis
    Gets BitLocker Recovery key
    .DESCRIPTION
    Gets the BitLocker Recovery key which is stored as an Active Directory Attribute and LAPS Password for the Computer specified in the Parameter
    .PARAMETER PC
    The Computer name of the machine you need to retrieve the data from
    .PARAMETER Laps
    Switch Parameter if this is in the cmdlet, it will output the LAPS Password as well with the Output (See Example 2)
    .EXAMPLE 1
    Get-BitLockerRecovery 'Company-PC100'
    .EXAMPLE 2
    Get-BLR 'Company-PC101' -Laps
#>

function Get-BitLockerRecovery
{
  [CmdletBinding()]
  [Alias('Get-BLR')]
  Param
  (
    # PC Name of Target Computer
    [Parameter(Mandatory = $true,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true)]
    [string]$PC,

    # Switch to retrieve LAPS Key if specified in cmdlet
    [Parameter(Mandatory = $false)]
    [switch]$Laps
  )

  Begin
  {
    Import-Module ActiveDirectory

    # Get-ADObject needs the Computers Distinguished Name to get the Properties
    $ComputerName = Get-ADComputer -Identity $PC
    $FullComputerName = $ComputerName.DistinguishedName
  }

  Process
  {
    # Get-ADComputer... doesn't find the  correct AD Attribute. So I've had to use Get-ADObject which can filter through more thoroughly.
    $BLKey = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $FullComputerName -Properties 'msFVE-RecoveryPassword'

    # This adds ~5sec to the execution time of the script investigate better performance options
    # $OSIP = Get-ADComputer -Identity WA3425 -Property * | Select-Object -Property OperatingSystem,OperatingSystemVersion,IPv4Address

    if($Laps)
    {
      # Was able to get the Property using Get-ADComputer
      $LAPSKey = Get-ADObject -Filter * -SearchBase $FullComputerName -Properties 'ms-Mcs-AdmPwd'
    }
  }
  End
  {
    If($Laps)
    {`
      # Format for LAPSKey if the switch is active
      $OutputLAPSKey = $LAPSKey | Select-Object -Property @{Name='LAPS Password';Expression={$_.'ms-Mcs-AdmPwd'}} | Format-List | Out-String
      $OutputLAPSKey = $OutputLAPSKey.trim()
    }
    # Format for BitLocker Key and Output | if $OutputLAPSKey doesnt exist because switch is not active it doesnt show even thought its present in write-output cmdlet
    $OutputBLKey = $BLKey | Select-Object -Property @{Name='BitLocker Key';Expression={$_.'msFVE-RecoveryPassword'}} | Format-List | Out-String
    $OutputBLKey = $OutputBLKey.trim()

    Write-Host ""
    Write-Host $OutputBLKey $OutputLAPSKey -ForegroundColor Yellow
  }
}
