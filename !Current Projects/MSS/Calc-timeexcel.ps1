<#
    ############
    Calc-timeexcel
    ############

    Author   : Aaron Price
    Company  : MSS
    Purpose  : Get the number values froma  range of cells and calculate the total
    Error Log: C:\Logs\

    ############
    Change Log
    ############
 
    Date: 10/11/2017 | Project Started

    ############
    TO DO
    ############

    1. [ ] Add Base script


    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    LazyWinAdmin
    http://www.lazywinadmin.com/2014/03/powershell-read-excel-file-using-com.html

    ramblingcookiemonster
    http://ramblingcookiemonster.github.io/PSExcel-Intro/

    ############
    Credits
    ############

    LazyWinAdmin


    ############
    Last Working Run
    ############





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
  [Alias("gh"]
  param(
    [Parameter(Mandatory = $true,
               ValueFromPipeline = $true,
               ValueFromPipelineByPropertyName = $true)] 
    [string]$computername,
        
    [Parameter(Mandatory = $false)]
    [switch]$logname
  )
    # Code here
  
}

# Code here

Get data out of Excel and calculate. Use the Time sheet at MSS to Test

