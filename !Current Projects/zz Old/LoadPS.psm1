############
#
# Author   : Aaron Price
# Company  : South Coast Baptist College
# Purpose  : To Setup a new Connection to Office 365 PowerShell, and import the modules you'll need.
#
############
# Change Log
############
# 
# Date: 25/05/2016 | Added Admin Verbose warning
# Date: 25/05/2016 | Removed PSRemoting from Comment Block
# Date: 25/05/2016 | Removed Set Location
# Date: 25/05/2016 | Removed RunAs Admin
# Date: 24/05/2016 | New Comments added as TroubleShooting Continues
# Date: 23/05/2016 | Added Function 
# Date: 23/05/2016 | Added PowerShell RunAs Admin
# Date: 23/05/2016 | Added Updated Help '-SourcePath \\srv-dc1\PSHelp'
# Date: 23/05/2016 | Added Execution Policy
# Date: 19/05/2016 | Comments and Comment Section Added
# Date: 19/05/2016 | Project Started
#
############
# TO DO
############
#
# 1. [ ] Fix Errors with Commands in Comment Block
# 2. [ ] Add Error Handling
# 3. [X] Update-help -SorucePath
# 4. [X] Add Function 
# 5. [X] Open new window as Admin and Execute function (Command has been added to the Bottom (Function Not Working)) (Removed)
# 6. [ ] Search for Updated help files on Server
# 7. [ ] Search for LoadPS on Local PC
# 8. [X] Write Verbose 'Open as Admin and Run again'
# 9. [ ] Stop processing if not admin window
#
############
# Configuration
############

    
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] ))
{
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break

    Out-null
}

function LoadPS {

# Updates local help files
update-help -SourcePath "\\srv-dc2\PSHelp"

# Gets User Credentials. This is your Office 365 Login. Example@scbc.wa.edu.au and Password.
$credential = get-credential 

# Imports the Office 365 PowerShell Online Module to a New Shell Client you'll be working from.
Import-Module MSOnline
# Imports the Active Directory Module # Not 100% 
Import-Module ActiveDirectory

# Aaron needs to Fix the errors in this comment block
<#
Connect-MsolService -Credential $credential

Import-Module LyncOnlineConnector

$lyncSession = New-CsOnlineSession -Credential $credential

Import-PSSession $lyncSession
#>

# Creates Variable to connect to Exchange Online with Credential Variable listed above
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection

# Imports the PSSession created above
Import-PSSession $ExchangeSession
}

# This needs to be executed in the Admin Window
# Changes the Execution policy of the shell session 
Set-ExecutionPolicy Unrestrictied