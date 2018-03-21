<#
    ############
    Connect-Exchange
    ############

    Author   : Aaron Price
    Company  : AFG
    Purpose  : Function to either Connect to On Prem or 365 Exchange 
    Error Log: ---

    ############
    Change Log
    ############

    Date: 11/10/2017 | Project started
    Date:         '' | Seperated each step
    Date:         '' | Switch Parameter is now working correctly
    Date:         '' | Added ErrorAction and ErrorVariable Added to Import-Module for -365
    Date: 12/10/2017 | Added WMI scriptblock for Get-FQDN of Exchange server (not working yet)
    Date:         '' | Added $Connected2 Var with Comment
    Date:         '' | Added $Exit to disconnect PS Session
    Date: 13/10/2017 | Completed Get-FQDN of Exchange server
    Date:         '' | Added and Completed make the 365 username for the 365 Credential Prompt

    ############
    TO DO
    ############

    1. [X] Add Script
    2. [X] Test Script
    3. [-] Domain Parameter ??
    4. [X] Add Get-FQDN of Exchange Server
    5. [ ] Properly Test ErrorVariable
    6. [ ] Fix variable naming
    7. [ ] Set -Server as required if onprem switch is met

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
    Server Parameter used to specify the server to connect to 
    .EXAMPLE 1
    Connect-Exchange -onprem -server prd-mailapp4-1
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
    # On Prem Setup
    if($onprem){
        write-host $ENV:USERDOMAIN 'Credentials' -ForegroundColor Yellow
        $UserCredential = $host.ui.promptforcredential('Credentials','Enter Active Directory Login Details',"$ENV:USERDOMAIN\$ENV:Username",'')
        
        # Gets the Domain and Name of the Target Server and puts them together to make the FQDN
        $FQDN = Get-WMIObject -class Win32_ComputerSystem -Credential $UserCredential -Computername $Server
        $FQDNSrv = $FQDN.Name + '.' + $FQDN.Domain

        # Make ConnectionUri String for On Prem PSSession
        $connecturi = ('http://' + $FQDNSrv + '/PowerShell/')
    }

    # 365 Setup
    if($365){
        Import-module MsOnline -ErrorAction Stop -ErrorVariable $ImportError
            if($ImportError){Write-Warning -Message 'Check you have installed the MsOnline Powershell Module!'}

        # Get Details for Office 365 Connection
        $FQDN = Get-WMIObject -class Win32_ComputerSystem 
        $FQDNSrv = $FQDN.Name + '.' + $FQDN.Domain
        
        # Make 365 Usersname for Credential prompt below
        $365Username = ($ENV:Username + '@' + $FQDN.Domain)

        Write-Host '365 Credentials' -ForegroundColor Yellow
        $credential = $host.ui.promptforcredential('365 Credentials','Enter Exchange Online Login Details',"$365Username",'')
    }
}
Process{
    if($onprem){
        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $connecturi -Authentication Kerberos -Credential $UserCredential -ErrorAction Stop -ErrorVariable $onpremError
            if($onpremError){Write-Warning -Message 'Failed to Connect to On Prem Exchange! Or Server Parameter wasnt specified'}
    }

    if($365){
        $exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri 'https://outlook.office365.com/powershell-liveid/' -Credential $credential -Authentication 'Basic' -AllowRedirection -ErrorAction Stop -ErrorVariable $365Error
            if($365Error){Write-Warning -Message 'Failed to Connect to Exchange Online!'} 
    }
}
End{
    # Added the $Connected2 Variable for you to quickly see what you're connected to
    if($onprem){
        Import-PSSession $Session -AllowClobber -ErrorAction Stop -ErrorVariable $onpremError
            if($onpremError){Write-Warning -Message 'Failed to Connect to On Prem Exchange!'}Else{
            Write-Host ''
            $Connected2 = Write-Host 'Connected to On Prem Exchange' -ForegroundColor Yellow}
            $Connected2
            $Exit = Remove-PSSession -Session $Session
    }

    if($365){
        Import-PSSession $exchangeSession -AllowClobber -DisableNameChecking -ErrorAction Stop -ErrorVariable $365Error
            if($365Error){Write-Warning -Message 'Failed to Connect to Exchange Online!'}Else{
            Write-Host ''
            $Connected2 = Write-Host 'Connected to Exchange Online' -ForegroundColor Yellow}
            $Connected2
            $Exit = Remove-PSSession -Session $exchangeSession

    }
    }
}