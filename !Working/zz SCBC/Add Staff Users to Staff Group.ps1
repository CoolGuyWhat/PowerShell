$OUs = 'OU=Administration,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au','OU=Teachers,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au','OU=Childcare,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$grp = Get-ADGroup "Staff"

<#
Make sure there are no Spaces behind your users in the Text file exported. Use Excel Find/Replace to remove the ' ' for each with nothing.
After you've read this remove Comment block and run command directly below.
This error is to do with the Outfile, we couldnt Export-csv because it Quotes each user with '"User"' so that errors in the ForEach ($user in $users)

$ous | ForEach { Get-ADUser -Filter * -SearchBase $_ } | Select SamAccountName | Out-File "C:\WindowsPowerShell\UsersOU.txt"
#>

$users = Get-Content C:\WindowsPowerShell\UsersOU.txt

#Luke and I tried to get the Write-host to work, but it doesn't write-host if 'Else' is hit
foreach ($user in $users) { 
    if ($grp -notcontains $user) {
        Add-ADGroupMember -identity $grp $user 
        Write-host " $user added to $grp"
        }
        Else {
        $grp -contains $user
        Write-host " $user already in group"
        }
}
