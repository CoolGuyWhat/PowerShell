<#
    ############
    Connect-Exchange
    ############

    Author   : Aaron Price
    Company  : AFG
    Purpose  : Simple Function to either Connect to On Prem or 365
    Error Log: ---

    ############
    Change Log
    ############

    Date: 11/10/2017 | Project started
    Date:         '' | Seperated each step
    Date:         '' | Switch Parameter is now working correctly
    Date:         '' | Added ErrorAction and ErrorVariable added to import-module

    ############
    TO DO
    ############

    1. [X] Add Script
    2. [X] Test Script
    3. [ ] Domain Parameter ??
    4. [ ] add get FQDN of exchange server

    ############
    Sources
    ############

    https://ramblingcookiemonster.github.io/Building-PowerShell-Functions-Best-Practices/

    <#
    .Synopsis
    Connect to either On Premise Exchange or Exchange Online.
    .DESCRIPTION
    Connect to either On Premise Exchange or Exchange Online.
    .PARAMETER 1
    Switch between on prem and 365 settings
    .PARAMETER 2
    Domain not used at the moment
    .EXAMPLE 1
    Connect-Exchange -onprem
    .EXAMPLE 2
    Connect-Exchange -365
#>

function Connect-Exchange
{
  [CmdletBinding()]
  [Alias('Con-Exch')]
  Param
  (
    [Parameter(Mandatory = $false)]
    [Switch]$onprem,$365,

    [Parameter(Mandatory = $false,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true)] 
    [string]$Server
  )
Begin{
    #On Prem Setup
    if($onprem){
        write-host 'AFGDomain Credentials' -ForegroundColor Yellow
        $UserCredential = $host.ui.promptforcredential("Credentials","Enter Active Directory Login Details","AFGDomain\$ENV:Username","")
        
        # Gets FQDN of Exchange server for On Prem connection
        $ExchSRV = $Server
        Get-WMIObject -class Win32_ComputerSystem -Credential $UserCredential -Computername $Server | Select Name,Domain

    }

    # 365 Setup
    if($365){
        Import-module MsOnline -ErrorAction Stop -ErrorVariable $ImportError
            if($ImportError){Write-Warning -Message 'Check you have installed the MsOnline Powershell Module!'}
        Write-Host '365 Credentials' -ForegroundColor Yellow
        $credential = $host.ui.promptforcredential("365 Credentials","Enter Exchange Online Login Details","$ENV:Username@afgonline.com.au","")
    }
}
Process{
    if($onprem){
        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://prd-mailapp4-1.afgonline.com.au/PowerShell/ -Authentication Kerberos -Credential $UserCredential -ErrorAction Stop -ErrorVariable $onpremError
            if($onpremError){Write-Warning -Message 'Failed to Connect to On Prem Exchange!'}
    }

    if($365){
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection -ErrorAction Stop -ErrorVariable $365Error
            if($365Error){Write-Warning -Message 'Failed to Connect to Exchange Online!'} 
    }
}
End{
    if($onprem){
        Import-PSSession $Session -AllowClobber -ErrorAction Stop -ErrorVariable $onpremError
            if($onpremError){Write-Warning -Message 'Failed to Connect to On Prem Exchange!'}Else{
            Write-Host ""
            Write-Host 'Connected to On Prem Exchange' -ForegroundColor Yellow}
    }

    if($365){
        Import-PSSession $exchangeSession -AllowClobber -DisableNameChecking -ErrorAction Stop -ErrorVariable $365Error
            if($365Error){Write-Warning -Message 'Failed to Connect to Exchange Online!'}Else{
            Write-Host ""
            Write-Host 'Connected to Exchange Online' -ForegroundColor Yellow}

    }
}
}