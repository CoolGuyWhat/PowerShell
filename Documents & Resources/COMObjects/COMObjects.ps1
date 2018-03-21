
# Opens Internet Explorer at Google.com
New-Object -COMObject InternetExplorer.Application -Property @{Navigate2='www.google.com'; Visible = $True}

# Outputs a list of all variable COMObjects
Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {$_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
} | Select-Object -ExpandProperty PSChildName | Out-file C:\WindowsPowerShell\Repository\COMObjects\COMObject.txt

# Example gets all Manipulable things from Outlook.Application (ComObject)
New-Object -ComObject WScript.Network | Get-Member | Out-File C:\WindowsPowerShell\Repository\COMObjects\WScriptNetwork.txt
