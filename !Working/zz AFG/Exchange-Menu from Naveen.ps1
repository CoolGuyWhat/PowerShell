$quit = "0"

Write-Host ""
Write-Host "Connecting to Office 365" -ForegroundColor Yellow
Write-Host ""

#$msonlinecredential = Get-Credential -Credential naveen.farey@afgonline.com.au



Import-Module $env:localappdata\Apps\2.0\OB1BQRTC.C1N\G0P0PPY0.6CG\micr..tion_51a5b647dacf4059_0010.0000_5d32306b9385c20a\CreateExoPSSession.ps1

Connect-EXOPSSession -UserPrincipalName aaron.price@afgonline.com.au

#Import-Module MsOnline

#Connect-MsolService -Credential $msonlinecredential

#$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $msonlinecredential -Authentication "Basic" -AllowRedirection

#$complianceSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://ps.compliance.protection.outlook.com/powershell-liveid" -Credential $msonlinecredential -Authentication "Basic" -AllowRedirection

#Import-PSSession $complianceSession -AllowClobber -DisableNameChecking

#Import-PSSession $exchangeSession -DisableNameChecking

#Write-Host "Setting 365 Powershell Aliases" -ForegroundColor Yellow

#Set-Alias trackemail get-messagetrace

Do {
Write-Host ""
Write-Host "=============================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "IT Services Office 365 Admin Tool" -ForegroundColor Yellow
Write-Host ""
Write-Host "=============================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "1) Query Mailbox"
Write-Host ""
Write-Host "2) Grant Full Access Permissions"
Write-Host ""
Write-Host "3) Grant Send As Permissions"
Write-Host ""
Write-Host "4) Convert Mailbox to Regular"
Write-Host ""
Write-Host "5) Convert Mailbox to Shared"
Write-Host ""
Write-Host "6) Display Full Access Permissions"
Write-Host ""
Write-Host "7) Display Send As Permissions"
Write-Host ""
Write-Host "8) Remove Full Access Permissions"
Write-Host ""
Write-Host "9) Remove Send As Permissions"
Write-Host ""
Write-Host "10) Perform Directory Sync"
Write-Host ""
Write-Host "11) Search for Office 365 Group"
Write-Host ""
Write-Host "12) Create Office 365 Group"
Write-Host ""
Write-Host "13) Delete Office 365 Group"
Write-Host ""
Write-Host "14) Retrieve Members/Owners from Office 365 Group"
Write-Host ""
Write-Host "15) Add Members to Office 365 Group"
Write-Host ""
Write-Host "16) Add Owners to Office 365 Group"
Write-Host ""
Write-Host "17) Remove Members from Office 365 Group"
Write-Host ""
Write-Host "18) Remove Owners from Office 365 Group"
Write-Host ""
Write-Host "19) Hide Office 365 Group from GAL"
Write-Host ""
Write-Host "20) Disable Office 365 Group Creation - All Users"
Write-Host ""
Write-Host "21) View Employees Office 365 License"
Write-Host ""
Write-Host "22) Add Employees Office 365 License"
Write-Host ""
Write-Host "23) Remove Employees Office 365 License"
Write-Host ""
Write-Host "24) Add 365 License"
Write-Host ""
Write-Host "25) BLANK"
Write-Host ""
Write-Host "26) Clear Host"
Write-Host ""
Write-Host "27) Quit" -ForegroundColor Red
Write-Host ""

$365admin = Read-Host "Select"

switch ($365admin)
{
1{$querymailbox = Read-Host -Prompt "What is the mailbox you're trying to query?"
get-mailbox -identity $querymailbox
pause}
#
#
2{$fullaccess = Read-Host -Prompt "Mailbox Owner"
$trustee = Read-Host -Prompt "Mailbox Trustee"
Add-MailboxPermission "$fullaccess" -User "$trustee" -AccessRights FullAccess -Automapping $false -Confirm:$false
Write-Host ""
Write-Host "Successfully Granted Mailbox Permissions on $mailboxname mailbox for $trustee" -ForegroundColor Green
Write-Host
pause}
#
#
3{$sendasaccess = Read-Host -Prompt "What is the mailbox name you're trying to set Send As Access Permissions on?"
$trustee = Read-Host -Prompt "Mailbox Trustee"
Add-RecipientPermission -Identity "$sendasaccess" -AccessRights SendAs -Trustee "$trustee" -Confirm:$false
Write-Host""
Write-Host "Successfully Grant Send As Permissions on $sendasaccess mailbox for $trustee" -ForegroundColor Green
Write-Host ""
pause}
#
#
4{$mailboxname = Read-Host -Prompt "What is the mailbox name you're converting to a Regular mailbox?"
Set-Mailbox -Identity "$mailboxname" -Type:Regular -Confirm:$False
Write-Host""
Write-Host "Successfully converted $mailboxname to a Regular mailbox" -ForegroundColor Green
Write-Host ""
pause}
#
#
5{$mailboxname = Read-Host -Prompt "What is the mailbox name you're converting to a Shared mailbox?"
Set-Mailbox -Identity "$mailboxname" -Type:Shared -Confirm:$False
Write-Host""
Write-Host "Successfully converted $mailboxname to a Shared mailbox" -ForegroundColor Green
Write-Host ""
pause}
6{$mailboxname = Read-Host -Prompt "What is the mailbox name you're trying to view Full Access Permissions?"
Get-Mailbox | Get-MailboxPermission -User $mailboxname
pause}
#
#
7{$mailboxname = Read-Host "What is the mailbox name you're trying to view Send As Access Permissions?"
Get-Mailbox | Get-RecipientPermission -Trustee $mailboxname
pause}
#
#
8{$mailboxname = Read-Host "What is the mailbox name you're trying to remove Full Access on?"
$trustee = Read-Host "Trustee's Name To Remove Access?"
Remove-MailboxPermission "$mailboxname" -User "$trustee" -AccessRights FullAccess -Confirm:$False
Write-Host ""
Write-Host "Successfully Removed Full Access Permissions on $mailboxname mailbox for $trustee" -ForegroundColor Green
Write-Host ""
pause}
#
#
9{$mailboxname = Read-Host "What is the mailbox name you're trying to remove Send As Access on?"
$trustee = Read-Host "Trustee's Name To Remove Access?"
Remove-RecipientPermission "$mailboxname" -Trustee "$trustee" -AccessRights SendAs -Confirm:$False
Write-Host ""
Write-Host "Successfully Removed Send As Access Permissions on $mailboxname mailbox for $trustee" -ForegroundColor Green
Write-Host ""
pause}
#
#
10{
Write-Host ""
Write-Host "Starting Office 365 Directory Sync" -ForegroundColor Yellow
Write-Host ""
$s = New-PSSession -computerName prd-wsusapp4-1.afgonline.com.au
Invoke-Command -Session $s -Scriptblock {C:\Users\Public\Desktop\ADSync.ps1}
Invoke-Command -Session $s -Scriptblock {Write-Host "Sync complete" -ForegroundColor Green}
Exit-PSSession
pause}
#
#
11{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -identity "$groupname" | Format-List
pause}
#
#
12{$groupname = Read-Host -Prompt "What would you like the group name to be called?"
$groupalias = Read-Host -Prompt "What would you like the alias to be called? e.g. usually the same as the group name"
New-UnifiedGroup -DisplayName "$groupname" -alias "$groupalias" -AccessType Private -RequireSenderAuthenticationEnabled $true -Confirm:$true
Write-Host ""
Write-Host "Successfully created Office 365 Group - $groupname" -ForegroundColor Green
Write-Host
pause}
#
#
13{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -Identity "$groupname" | format-List
Remove-UnifiedGroup -Identity "$groupname" -confirm:$true
pause}
#
#
14{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Write-Host "Owners"
Get-UnifiedGroupLinks -identity $groupname -LinkType Owners
pause
Write-Host "Members"
pause
Get-UnifiedGroupLinks -identity $groupname -LinkType Members
pause}
#
#
15{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -Identity "$groupname" | Format-List
$links = Read-Host -Prompt "Member to add?"
Add-UnifiedGroupLinks -Identity "$groupname" -LinkType Members -Links $links -confirm:$true
Write-Host ""
Write-Host "Successfully added Members $links to Office 365 Group - $groupname" -ForegroundColor Green
Write-Host
pause}
#
#
16{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -Identity "$groupname" | Format-List
$links = Read-Host -Prompt "Owner to add?"
Add-UnifiedGroupLinks -Identity "$groupname" -LinkType Owners -Links $links -confirm:$true
Write-Host ""
Write-Host "Successfully added Owner $links to Office 365 Group - $groupname" -ForegroundColor Green
Write-Host ""
pause}
#
#
17{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -Identity "$groupname" | Format-List
$links = Read-Host -Prompt "Member to Remove?"
Remove-UnifiedGroupLinks -Identity "$groupname" -LinkType Members -Links $links -confirm:$true
Write-Host ""
Write-Host "Successfully Removed Members $links to Office 365 Group - $groupname" -ForegroundColor Green
Write-Host ""
pause}
#
#
18{$groupname = Read-Host -Prompt "What is the Office 365 Group Name?"
Get-UnifiedGroup -Identity "$groupname" | Format-List
$links = Read-Host -Prompt "Owner to Remove?"
Remove-UnifiedGroupLinks -Identity "$groupname" -LinkType Owners -Links $links -confirm:$true
Write-Host ""
Write-Host "Successfully Removed Owners $links to Office 365 Group - $groupname" -ForegroundColor Green
Write-Host ""
pause}
#
#
19{$groupname = Read-Host -Prompt "What is the Office 365 Group Name you'd like to hide from the GAL?"
Get-UnifiedGroup -Identity "$groupname" | Format-List
Set-UnifiedGroup -Identity "$groupname" -Hiddenfromaddresslistsenabled $true
Write-Host ""
Write-Host "Successfully Hidden $groupname Office 365 Group from GAL" -ForegroundColor Green
Write-Host ""
pause}
#
#
20{Set-OwaMailboxPolicy -identity OwaMailboxPolicy-Default -GroupCreationEnabled $false
Write-Host ""
Write-Host "Successfully Removed Group Creation for All User's" -ForegroundColor Green
Write-Host ""
pause}

21{$viewlicense = Read-Host -Prompt "What is the employee's username?"
Get-MsolUser -UserPrincipalName "$viewlicense@afgonline.com.au" | Format-List DisplayName,Licenses
pause}

22{$addlicense = Read-Host -Prompt "What is the employee's username?"
$licensetype = Read-Host -Prompt "Type of License to add? - afgtest:STANDARDPACK or afgtest:ENTERPRISEPACK"
Set-MsolUserLicense -UserPrincipalName "$addlicense@afgonline.com.au" -AddLicenses $licensetype
Write-Host ""
Write-Host "Successfully Added $licensetype to $addlicense"
Write-Host ""
pause}


23{$removelicense = Read-Host -Prompt "What is the employee's username?"
Get-MsolUser -UserPrincipalName "$removelicense@afgonline.com.au" | Format-List DisplayName,Licenses
$licensetype = Read-Host -Prompt "Type of License to remove? - afgtest:STANDARDPACK or afgtest:ENTERPRISEPACK"
Set-MsolUserLicense -UserPrincipalName "$removelicense@afgonline.com.au" -AddLicenses $licensetype
Write-Host ""
Write-Host "Successfully Removed $licensetype from $addlicense"
pause}

24{

#Set License Usage Location for new user

$licenseupn = Read-Host -prompt "UPN for user?"

get-msoluser -userprincipalname "$licenseupn@afgonline.com.au"

pause


Set-MsolUser -UserPrincipalName "$username@afgonline.com.au" -UsageLocation AU -WarningAction SilentlyContinue

#prompt for 365 license

Write-Host ""

$365license = ""

$365license = Read-Host -Prompt "Assign E3 Office 365 license? Selecting No will assign E1 (Y/N)"

while (("$365license" -ne "Y") -and ("$365license" -ne "N")) {

Write-Host "Invalid Entry. Please select from Y/N. Try again!" -ForegroundColor Red

$365license = Read-Host -Prompt "Assign E3 Office 365 license to $firstname $lastname"

}


#Assign 365 License to new user


If ($365license -eq "Y") {Set-MsolUserLicense -UserPrincipalName "$username@afgonline.com.au" -AddLicenses "afgtest:ENTERPRISEPACK" -WarningAction SilentlyContinue}
If ($365license -eq "N") {Set-MsolUserLicense -UserPrincipalName "$username@afgonline.com.au" -AddLicenses "afgtest:STANDARDPACK" -WarningAction SilentlyContinue}

}



25{Write-Host "BLANK"}

26 {Clear-Host}


27 {exit} 
} 
} while ($quit -ne 1)
