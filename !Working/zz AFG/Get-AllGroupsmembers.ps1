Import-Module ActiveDirectory

$Groups = Get-ADGroup -Filter * | Select-Object -Property samaccountname

ForEach($G in $Groups){
    $GName = $G.samaccountname
    Write-Host --- $Gname
    Get-ADGroupMember -Identity $GName | Select SamAccountName | Format-Wide -AutoSize
}