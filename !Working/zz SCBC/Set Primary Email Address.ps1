$MSCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $MSCred -Authentication Basic –AllowRedirection
Import-PSSession $Session
Set-Mailbox -identity @scbc.wa.edu.au -WindowsEmailAddress @scbc.wa.edu.au
Remove-PSSession $Session