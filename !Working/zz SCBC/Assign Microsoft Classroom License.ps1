Connect-MsolService
 $licenseObj = Get-MsolAccountSku | Where-Object {$_.SkuPartNumber -eq "CLASSDASH_PREVIEW"} 
 $license = $licenseObj.AccountSkuId
Import-Csv -Path c:\temp\Exportedusers.csv | ForEach-Object `
 { Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalName -AddLicenses $license}