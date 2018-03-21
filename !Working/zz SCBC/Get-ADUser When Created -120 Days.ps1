$When = ((Get-Date).AddDays(-120)).Date
Get-ADUser -Filter {whenCreated -lt $When} -Properties whenCreated | Export-csv C:\WindowsPowershell\4em.csv
