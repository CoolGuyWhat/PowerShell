#Get-msoluser -all | Where-Object {$_.Department -like "Primary"} | Format-Table -Property UserPrincipalName | Out-File C:\Test\Test.csv
$Users = Get-Content C:\Test\Test.csv
ForEach ($User in $Users) {
Set-CASMailbox -Identity $User -OWAMailboxPolicy:Primary
}