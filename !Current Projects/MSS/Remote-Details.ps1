<#
############
 Remote-Details
############

 Author   : Aaron Price
 Company  : MSS IT
 Purpose  : To get specific details from a Remote Machine
 Error Log: C:\Logs\RemoteDetials.Log

############
 Change Log
############
 
 Date: 25/07/2017 | Project Started | Initial script added to Enter-PSSession of remote computer
 Date: 25/07/2017 | Added Initial Error Handling for Network Connection
 Date: 26/07/2017 | Script Tested | Remote Desktop OS not working, Remote Server OS Working
 Date: 27/07/2017 | Connection Error Handling Finalized
 Date: 27/07/2017 | WMI Object added and configured naming
 Date: 28/07/2017 | Invoke-command tried and fixed with just Get-WMI -PCName $PC -Cred $Cred
 Date: 28/07/2017 | WMI added and tested (Working!)
 
############
 TO DO
############

 1. [X] Create script block
 2. [ ] Add Function
 3. [ ] Add Domain Parameter to Function for remote uability
 4. [X] Error Action Connecting Logic
 5. [-] Check WinRM Service of Remote Computer
 6. [X] Fix PS Remoting (WS-Management)(WinRM) | Fixed Servers have service running, not Desktops | See 26/07/2017 Change Log
 7. [-] Check Execution Policy of Remote Computer
 8. [-] Exit-PSSession instructions
 9. [-] Fix PSSession connection logic
 10.[ ] Get mode WMI data and import into 1 output table
 11.[X] Fix error handling on WMI cmdlet

############
 Sources
############

 Enter-PSSession 
 https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/enter-pssession

 Create Directoy if it doesnt Exist
 https://stackoverflow.com/questions/16906170/create-directory-if-it-does-not-exist

 Error Handling
 https://www.vexasoft.com/blogs/powershell/7255220-powershell-tutorial-try-catch-finally-and-error-handling-in-powershell

 Using WMI Document
 https://u32319790.dl.dropboxusercontent.com/u/32319790/WMI.docx

 Editing Parameter Outputs
 https://technet.microsoft.com/en-us/library/ff394367.aspx
 
#>

Function Remote-Details{
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

$MyPC = hostname

Clear-Host

# Password is Set to Secure string by default when returning $Credential
$Computer = Read-Host 'Enter Computer Name'
$Credential = Get-Credential -Message 'Administrator Credentials are required for this Action '-UserName 'MSS\mss'

Try{
  Write-Verbose "Connecting to $Computer with Credentials provided" -Verbose
  # Gets Network Adapter Config with Valid IP Address
  # This is Selecting the Properties from the above command and formatting the Output to make it more Readable (WMI isnt always very Clear)
  Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Credential $Credential -Computername $Computer -ErrorAction Stop | Where-Object { $_.IPAddress -ne $null } | Select-Object -Property @{Name='PC Name';Expression={$_.'PSComputerName'}},@{Name='Domain';Expression={$_.'DNSDomain'}},@{Name='Description';Expression={$_.'Description'}},@{Name='IP Address';Expression={$_.'IPAddress'}},DHCPServer,MACAddress
  
  # Get C:\ HDD Space
  # $HDD = Get-WmiObject Win32_logicalDisk
  # User logged into remote machine
  Get-WmiObject -ComputerName $Computer -Class Win32_ComputerSystem | Select-Object UserName
}
Catch{
  $ErrorMessage = $_.Exception.Message
  $Time = Get-Date
  # Error Message
  Write-Verbose "Failed to Connect to $Computer  
         Connection attempted and failed at $Time
         Error log Written to C:\Logs\RemoteDetails.Log" -Verbose
  # Break | Needed for more then 1 Catches
}
Finally{
  # Creates C:\Log Directory if it doesnt exist
  $path = 'C:\Logs'
  if(!(Test-Path $path))
  {New-Item -ItemType Directory -Force -Path $path
  }
  # Writes Log File
  "$Time 
  $ErrorMessage" | Out-File C:\Logs\RemoteDetails.log -Append
}

# Fin