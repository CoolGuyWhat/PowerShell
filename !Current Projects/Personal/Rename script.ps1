# Remove disallowed symbols from file names

Write-Host '' 
Write-Host "Script to remove `"#`" and `"%`" from file and directory names"
Write-Host 'First run is read only. Check Log file for detected files then edit script to make changes'
Write-Host ''

Write-Host '' 
$Directory=read-Host 'Enter Directory'
Write-Host ''

Set-Location $Directory

set-content -Path .\Log.txt ''
Get-ChildItem -filter *#* -recurse | ForEach-Object { $_.FullName | Add-Content .\Log.txt}
Get-ChildItem -filter *%* -recurse | ForEach-Object { $_.FullName | Add-Content .\Log.txt}

Write-Host""
Write-Host "Log file written to $directory\Log.txt"
write-host""

$title = 'Rename Files'
$message = 'Are you sure you want to rename all listed files?'
$yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes',
  'Yes ?'
$no = New-Object System.Management.Automation.Host.ChoiceDescription '&No',
  'No ?'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
switch ($result)
    {
        0 {
           Get-ChildItem -recurse -name | ForEach-Object { Move-Item $_ $_.replace("#", "") }
           Get-ChildItem -recurse -name | ForEach-Object { Move-Item $_ $_.replace("%", "") }
           'Invalid Characters removed from files'
          }
        1 {'You have selected No. No Files have renamed.'}
    }