$Outlook = New-Object -ComObject Outlook.Application
$Mail = $Outlook.CreateItem(0)
$Mail.To = "pricea@scbc.wa.edu.au"
$Mail.Subject = "PowerShell"
$Mail.Body ="Tim Smells"
$Mail.Send()