<#
  This script locates this computers serial number, opens Dell Driver support and automatically submits forms on the site to locate any missing drivers.
   It will also give you the option to suspend bitlocker for one reboot due to a potential BIOS upgrade.
#>

$serial = (Get-WmiObject -Class win32_bios).SerialNumber

Write-Host "THIS MACHINES SERIAL NO. IS $serial" -ForegroundColor Yellow

$ie = New-Object -ComObject "InternetExplorer.Application"
$url = "http://www.dell.com/support/home/au/en/audhs1?app=drivers"
$ie.Navigate($url)
Start-Sleep -Seconds 5
$ie.visible = $true
$doc=$ie.Document
$input1 = $doc.getElementByID("inputServiceTag")
$submit1 = $doc.getElementByID("btnSubmit")
$input1.value="$serial"
$submit1.click()
Start-Sleep -Seconds 10
$ie.Document
$url = $ie.Document.URLUnencoded
$ie.Navigate($url)
$submit2 = $doc.getElementByID("btnDetectDriver")
$submit2.click()
Start-Sleep -Seconds 10
$submit2 = $doc.getElementByID("btnDetectDriver")
$submit2.click()
Start-Sleep -Seconds 60
$doc = $ie.Document
$submit3 = $doc.getElementByID("dsdEulaAgree")
$submit3.checked=$true
$doc = $ie.Document
$submit4 = $doc.getElementByID("eulaagree")
$submit4.className="btn btn-primary right-offset-10 dellmetrics-eulaagree"
$doc = $ie.Document
$submit5 = $doc.getElementByID("eulaagree")
$submit5.click()

""

Get-BitLockerVolume -MountPoint C:\ 

""

$question = Read-Host -Prompt "Suspend BitLocker? Y/N"

if ($question -eq "y")

{
 Suspend-BitLocker -MountPoint C:\ -RebootCount 1 -ErrorAction Inquire
 
 ""
 
 Write-Host "SUCCESS! BITLOCKER SUSPENED FOR 1 REBOOT.." -ForegroundColor Green   
}

""

$status = Get-CimInstance SoftwareLicensingProduct -Filter "ApplicationID = '55c92734-d682-4d71-983e-d6ec3f16059f'" | Where-Object {$_.LicenseStatus -EQ "1"} | Select-Object -ExpandProperty LicenseStatus

if ($status -eq "1")
{
    Write-Host "SUCCESS! Windows is activated on this machine" -ForegroundColor Green
}

if ($status -eq "0")
{
    Write-Host "ERROR! Windows is not activated on this machine" -ForegroundColor Red

    $key = Get-WmiObject -Query 'select * from SoftwareLicensingService'

    if($activate = $key.OA3xOriginalProductKey) {

    Write-Host 'Activating using product key:'$key.OA3xOriginalProductKey -ForegroundColor Yellow

    $key.InstallProductKey($key)

    }else{

    Write-Host 'Key not found or error encountered, now using Windows 7 Key' -ForegroundColor Yellow
    $key.InstallProductKey('XXXXX-Windows-Key-XXXXX')

    }

}

""

pause