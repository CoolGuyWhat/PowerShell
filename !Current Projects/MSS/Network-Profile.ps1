<#
    ############
    Network-Profile
    ############

    Author   : Aaron Price
    Company  : MSS IT
    Purpose  : Quickly enter in IP addresses to change NIC settings. Have saved Preset Profiles and Saveable Profiles.
    Error Log: C:\Logs\

    ############
    Change Log
    ############
 
    Date: 19/05/2016 | 
    Date: 07/02/2018 | Project Started

    ############
    TO DO
    ############

    1. [X] Add Fundamentals
    2. [X] Add DHCP Option
    3. [ ] Save settings
    4. [ ] Get it working


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
Function Set-NetworkProfile {
  <#
      .SYNOPSIS
      Windows Network profile switcher
      .DESCRIPTION
      I got tired of manually changing IP settings on Windows. So im going to spend 1 day figuring this out to save me 2 minutes, every so often.
      .EXAMPLE
      Set-NetworkProfile -preset 1
      .PARAMETER preset
      Used to Switch between settings
  #>

  [CmdletBinding()]
  [Alias('snp')]
  param(        
    [Parameter(Mandatory = $true)]
    [string]$preset
  )

    # Displays current Network Config
    Write-Verbose -Message 'Current Network Settings' -Verbose
    Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ErrorAction Stop | Select-Object -Property @{Name='PC Name';Expression={$_.'PSComputerName'}},@{Name='Domain';Expression={$_.'DNSDomain'}},@{Name='Description';Expression={$_.'Description'}},@{Name='IP Address';Expression={$_.'IPAddress'}},@{Name='Subnet Mask';Expression={$_.'IPSubnet'}},@{Name='Gateway';Expression={$_.'DefaultIPGateway'}},@{Name='DNS Primary';Expression={$_.DNSServerSearchOrder[0]}},@{Name='DNS Secondary';Expression={$_.DNSServerSearchOrder[1]}},MACAddress
    $NIC = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE

    switch ($preset){
        'one' {  
            $IP = '192.168.1.201'
            $Subnet = '255.255.255.0'
            $Gateway = '192.168.1.2'
            $DNS1 = '192.168.1.252'
            $DNS2 = '192.168.1.253'
            $NIC.EnableStatic($IP,$Subnet)
            $NIC.DefaultIPGateway($Gateway,1)
            $NIC.DNSServerSearchOrder($DNS1,$DNS2);break        
            }
        'two' {
            $IP = '192.168.1.202'
            $Subnet = '255.255.255.0'
            $Gateway = '192.168.1.155'
            $DNS1 = '192.168.1.252'
            $DNS2 = '192.168.1.253'
            $NIC.EnableStatic($IP,$Subnet)
            $NIC.DefaultIPGateway($Gateway,1)
            $NIC.DNSServerSearchOrder($DNS1,$DNS2);break
            }
        'DHCP' {
            $NIC.EnableDHCP()
            $NIC.DNSServerSearchOrder();break
        }
        Default {
            $IP = Read-Host 'IP Address'
            $Subnet = Read-Host 'Subnet'
            $Gateway = Read-Host 'Gateway'
            $DNS1 = Read-Host 'Primary DNS'
            $DNS2 = Read-Host 'Secondary DNS'
            $NIC.EnableStatic($IP,$Subnet)
            $NIC.DefaultIPGateway($Gateway,1)
            $NIC.DNSServerSearchOrder($DNS1,$DNS2);break
        }
    }
}