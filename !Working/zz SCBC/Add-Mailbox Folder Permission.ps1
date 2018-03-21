#User Sharing Calendar
Write-host "Enter Email Address of User Sharing Calendar"
$MasterMailbox = Read-Host

#User Recieving Calendar Permissions
Write-Host "Enter Email Address of User Recieving Calender Permissions"
$RecieverMailbox = Read-Host

#Not Working
add-mailboxfolderpermission -identity "$MasterMailbox :\calendar" -user  "$RecieverMailbox" -accessrights Editor