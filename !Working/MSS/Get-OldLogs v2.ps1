<#
############
 Example Name
############

 Author   : Aaron Price
 Company  : MSS IT
 Purpose  : Gets Event Logs from an a selected many Hour(s) ago to Current and outputs to specified location
 Error Log: ---

############
 Change Log
############
 
 Date: 25/07/2017 | Project started
 Date: 25/07/2017 | Function added
 Date: 03/08/2017 | Added new Script Template
 Date: 03/08/2017 | v2 added

############
 TO DO
############

 1. [X] Fix Errors with function
 2. [X] Fix Errors with $hours parameter
 3. [ ] MKDIR log folder and check-path if exists

############
 Sources
############

 For the $Time Variable to -1 Hour
 https://social.technet.microsoft.com/Forums/ie/en-US/b5dbe9fc-e716-44ca-8f18-36864bcae791/powershell-getdate-minus-one-day?forum=ITCG

 Get-Date
 https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/get-date

 Get-EventLog
 https://msdn.microsoft.com/en-us/powershell/reference/5.0/microsoft.powershell.management/get-eventlog

#>

function Get-OldLog{
  <#
      .SYNOPSIS
      Gets Event Logs from an Hour(s) ago to Current
      .DESCRIPTION
      This Function grabs the logs off the Local Computers from the Log Folder specified and time to start from. 

      .EXAMPLE 1
      Get Application Logs from 3 hours ago to Current
      Get-OldLogs -logfolder Application -hours 3
      .EXAMPLE 2
      Get System Logs from 6 Hours ago to Current
      Get-OldLogs -logfolder System -hours 6

      .PARAMETER $logfolder
      Set Windows Logs Folder, Enter required event log Folder Either: Application, Security, Setup, or System will be the most popular, but all default event Logs are avaiable.
      .PARAMETER $hours
      Sets the Number of hours back to start from

  #>
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [string]$logfolder,
    [Parameter(Mandatory=$true)]
    [string]$hours

  )
  
  # Sets the $Time to however many hours ago and formats correctly for next command
  $Time = Get-Date $(Get-Date).AddHours(-$hours) -format g

  # Gets the Event Logs
  # You could filter this even more with a Before Parameter. Also potential to Sort-Object and Export-csv...
  Get-EventLog -Logname $logfolder -After $Time
  
  Write-Output "
  $logfolder Logs above "  
}
