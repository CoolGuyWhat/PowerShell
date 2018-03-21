$MSCred = Get-Credential 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $MSCred -Authentication Basic –AllowRedirection
Import-PSSession $Session

