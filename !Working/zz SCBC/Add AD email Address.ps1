Import-Module ActiveDirectory
Import-CSV C:\WindowsPowershell\Names2.csv |
ForEach-Object {Get-ADUser -Filter "Name -eq `"$($_.Name)`"" | Set-ADUser -EmailAddress $_.Email}

#Get-ADUser -filter * -SearchBase "OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au" | Format-Table -Property Name, UserPrincipalName | Out-File C:\WindowsPowershell\names3.csv