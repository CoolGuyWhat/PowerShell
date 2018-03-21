<#

Working Script for Changing the Require Senders Authenticated option to off for All mailboxes

#>

Import-Module MSOnline
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$Mailboxes = get-mailbox | ? {$_.RequireSenderAuthenticationEnabled -eq $true}

foreach ( $mailbox in $mailboxes) {

#you may need to remove '-resultsize unlimited' and re run script
Set-Mailbox -identity "$mailbox" -RequireSenderAuthenticationEnabled $False

}