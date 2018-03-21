<#
    ############
    Dropbox-Script
    ############

    Author   : Aaron Price
    Company  : MSS
    Purpose  : Dropbox web can't view .ps1 files so this script gets the content out of each and makes a new .txt file for online viewing
    Error Log: C:\Logs\

    ############
    Change Log
    ############
  
    Date: 3/10/2017 | Project Started
    Date:        '' | Script working expect for Recurse
    Date: 4/10/2017 | Cut script down removed Out-string and Set-Location
    Date:        '' | Added Dropbox source for To Do 2
    Date: 

    ############
    TO DO
    ############

    1. [X] Add Content
    2. [ ] Try force Dropbox Sync
    3. [ ] Get Recursive New-Item working

    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    Upload Files for Dropbox from PowerShell
    http://laurentkempe.com/2016/04/07/Upload-files-to-DropBox-from-PowerShell/

    ############
    Credits
    ############


    ############
    Last Working Run
    ############

    Non-Recurse
    4/10/2017

#>

$Path = 'C:\Users\aaron.price\Downloads\'

$files = Get-ChildItem -Path $Path -File -Recurse

ForEach($file in $files){
  $filename = $file.BaseName
  $Content = Get-Content -Path $file
  New-Item -path $Path$Filename.txt -itemtype file -Value $Content
  
}