


$Web = New-Object -ComObject 'InternetExplorer.Application'
$URL = 'https://www.gw2bltc.com/en/tp/search?profit-pct-min=10&profit-pct-max=100&sold-day-min=20&bought-day-min=20&sort=profit'
$Web.Navigate($url)
$Web.visible = $true

while ($Web.busy -eq $true){
  Start-Sleep -Seconds 1
}

$Doc = $Web.Document
$Doc.getElementByTagName('table')



# 


$input1 = $doc.getElementByID('inputServiceTag')
$submit1 = $doc.getElementByID('btnSubmit')
$input1.value="$serial"
$submit1.click()
Start-Sleep -Seconds 10
$ie.Document
$url = $ie.Document.URLUnencoded
$ie.Navigate($url)
$submit2 = $doc.getElementByID('btnDetectDriver')
$submit2.click()
Start-Sleep -Seconds 10
$submit2 = $doc.getElementByID('btnDetectDriver')
$submit2.click()
Start-Sleep -Seconds 60
$doc = $ie.Document
$submit3 = $doc.getElementByID('dsdEulaAgree')
$submit3.checked=$true
$doc = $ie.Document
$submit4 = $doc.getElementByID('eulaagree')
$submit4.className='btn btn-primary right-offset-10 dellmetrics-eulaagree'
$doc = $ie.Document
$submit5 = $doc.getElementByID('eulaagree')
$submit5.click()
