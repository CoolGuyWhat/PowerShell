$AccountSkuId = "southcoastbc:OFFICESUBSCRIPTION_STUDENT"
$UsageLocation = "AU"

      Import-Csv -Path C:\Temp\PowerShell\Y7.csv  | ForEach-Object{
      $m_upn = $_.UserPrincipalName
      Get-MsolUser -UserPrincipalName $m_upn
      Set-MsolUser -UserPrincipalName $m_upn -UsageLocation AU
      $Options = New-MsolLicenseOptions -AccountSkuId southcoastbc:OFFICESUBSCRIPTION_STUDENT
      Get-Msoluser -UserPrincipalName $m_upn | Set-MsolUserLicense -AddLicenses southcoastbc: OFFICESUBSCRIPTION_STUDENT -LicenseOptions $options
      }

$Users = Import-Csv C:\Temp\PowerShell\Y7.csv
$Users | ForEach-Object {
Set-MsolUser -UserPrincipalName $_.UserPrincipalName -UsageLocation $UsageLocation
Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalName -AddLicenses $AccountSkuId
}