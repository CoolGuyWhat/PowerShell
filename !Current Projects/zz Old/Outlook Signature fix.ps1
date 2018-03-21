Set-ExecutionPolicy Unrestricted -Force
New-Item -Path '\\Localhost\c$\Users\Public\' -Name TempPS -ItemType directory
Copy-item -Path \\srv-dc1\NETLOGON\Outlook_Email_Signature.vbs -Destination \\Localhost\c$\Users\Public\TempPS\
cscript.exe \\Localhost\c$\Users\Public\Outlook_Email_Signature.vbs

