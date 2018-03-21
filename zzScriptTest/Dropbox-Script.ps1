<#
    ############
    Dropbox-Script
    ############

    Author   : Aaron Price
    Company  : 
    Purpose  : 
    Error Log: C:\Logs\

    ############
    Change Log
    ############
  
    Date: 3/10/2017 | Project Started

    ############
    TO DO
    ############

    1. [ ] Add Content
    2. [ ] Try force dropbox sync

    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    ############
    Credits
    ############

    

    ############
    Last Working Run
    ############



#>


$Path = 'C:\Test'

Set-Location $Path
$files = Get-ChildItem -Path $Path -Recurse

ForEach($file in $files){
  # $Filename = $file.FullName.TrimEnd('.ps1')
  $filename = $file.BaseName
  $Content = Get-Content -Path $file | Out-String
  
  New-Item -path $Path -Name $filename.txt -itemtype file -Value $Content
      
  }

