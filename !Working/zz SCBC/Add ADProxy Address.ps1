<# For this Command to work you need to run the command below in comment section. But to do this you need to be connected to Office365 Outlook PowerShell by running these commands
$credential = get-credential
Import-Module MSOnline
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $ExchangeSession
#>

<#
Make sure there are no Spaces behind your users in the Text file exported. Use Excel Find/Replace to remove the ' ' for each with nothing.
After you've read this remove Comment block and run command directly below.
This error is to do with the Outfile, we couldnt Export-csv because it Quotes each user with '"User"' so that errors in the ForEach ($user in $users)

Get-Mailbox -ResultSize Unlimited | Where-object {$_.PrimarySMTPAddress -like "*@southcoastbc.onmicrosoft.com" -eq $true}| Format-table -Property Alias | Out-File C:\WindowsPowershell\Names2.csv
#>

Import-Module ActiveDirectory

$newproxy = '@scbc.wa.edu.au'
$users = Get-Content C:\WindowsPowershell\Names2.csv

foreach ($user in $users) {

Set-ADUser -identity $user -Add @{Proxyaddresses='SMTP:' + $user + $newproxy}

}