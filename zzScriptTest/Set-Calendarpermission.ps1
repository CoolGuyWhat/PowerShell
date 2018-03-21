<#
############
 Set-Calendarpermissions
############

 Author   : Aaron Price
 Company  : MSS IT
 Purpose  : 
 Error Log: C:\Logs\

############
 Change Log
############
 
 Date: 15/08/2017 | Project Started


############
 TO DO
############

 1. [ ] Add beginning of script


############
 Sources
############

 Build better Functions
 https://technet.microsoft.com/en-us/library/hh360993.aspx

 Get-Help
 https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

#>
Function Get-help{
  <#
  .SYNOPSIS
  Describe the function here
  .DESCRIPTION
  Describe the function in more detail
  .EXAMPLE
  Give an example of how to use it
  .EXAMPLE
  Give another example of how to use it
  .PARAMETER computername
  The computer name to query. Just one.
  .PARAMETER logname
  The name of a file to write failed computer names to. Defaults to errors.txt.
  #>
  [CmdletBinding()]
  param(

  )
    Get-help
  
}
# Creates Log Directory if it doesn't exist
$path = "C:\Logs"
if(!(Test-Path $path))
 {
   New-Item -ItemType Directory -Force -Path $path
 }



# Writes Log File
"$Time 
$ErrorMessage" | Out-File C:\Logs\*Logfilename*.log -Append

