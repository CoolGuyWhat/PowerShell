#requires -Version 2 -Modules ActiveDirectory
#Add https://southcoastbc.sharepoint.com to Remote Computers 

Import-Module ActiveDirectory

#Gets Computer names 
$Remotecomputer = Get-ADComputer -Filter * -SearchBase 'OU=Surface Pro,OU=Computers - Workstations,DC=maranatha,DC=wa,DC=edu,DC=au' | Select-Object -Property Name

#Script Location and Parameters required by Script
#Script Download ( https://gallery.technet.microsoft.com/scriptcenter/How-to-batch-add-URLs-to-c8207c23 (I do not own this script)) 
$Command = {
  \\srv-dc1\netlogon\Fix\PowerShell\AddingTrustedSites.ps1 -PrimaryDomain sharepoint.com -SubDomain southcoastbc 
}

#Executes $Command on $RemoteComputer if able to with Admin Credentials
ForEach ($PC in $Remotecomputer){
  Invoke-Command -ComputerName "$RemoteComputer" -ScriptBlock $Command
}