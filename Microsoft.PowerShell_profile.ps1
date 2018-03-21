# Filter Left, Format Right
# https://technet.microsoft.com/en-au/library/2009.09.windowspowershell.aspx

$TimeStamp = Get-Date -UFormat "%d%b%Y %I%M%p"
Start-Transcript -Path "C:\Users\aaron\Documents\WindowsPowerShell\Script Transcript\$TimeStamp.txt" -NoClobber

New-Alias -Name gh -Value Get-Help
Set-Location C:\Users\aaron\Documents\WindowsPowerShell

Clear-Host


"Windows PowerShell
Copyright (C) 2016 Microsoft Corporation. All rights reserved.

PowerShell Profile Loaded.
Filter Left, Format Right"

