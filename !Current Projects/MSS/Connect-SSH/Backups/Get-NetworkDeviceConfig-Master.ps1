<#
    ############
    Get-NetworkDeviceConfig
    ############

    Author   : Aaron Price
    Company  : MSS IT
    Purpose  : SSH into and pull configs of remote networked devices to our TFTP server.
    Error Log: C:\Logs\

    ############
    Change Log
    ############
 
    Date: 16/03/2018 | First working run.
    Date: 16/03/2018 | Added Form. Corrected Logic and Format.
    Date: 15/03/2018 | Downloaded and configured Renci DLL Files | https://vwiki.co.uk/SSH_Client_(PowerShell)
    Date: 09/03/2018 | Install OpenSSH for PowerShell 
    Date: 09/03/2018 | Project Started

    ############
    TO DO
    ############

    1. [ ] Fix Errors with Commands in Comment Block
    2. [X] Comment script
    3. [X] Build into a function
    4. [ ] Define HP/Dell/Cisco switching
    5. [ ] If -port not specified leave as default '22'

    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    PowerShell SSH
    https://vwiki.co.uk/SSH_Client_(PowerShell)
    Download Page: https://github.com/sshnet/SSH.NET/releases


    ############
    Credits
    ############

    The Real MVPs
    https://stackoverflow.com/questions/24436507/execute-multiple-commands-via-ssh-and-powershell
    https://stackoverflow.com/questions/19864617/powershell-read-write-to-ssh-net-streams/19892705#19892705


    ############
    Last Working Run
    ############

    16/03/2018


    .PARAMETER IP
    Determines which IP address to connect to 
    .PARAMETER Port
    Determines which Port to connect to the IP Address using
    .PARAMETER Username
    Please specify the Credentials you're going to be using to connect to the network device.
    .PARAMATER Password
    Please specify the Credentials you're going to be using to connect to the network device.
    .EXAMPLE 1
    Get-ndc -IP 192.168.0.244 -Port 22 -Username Manager -Password Password1
    .EXAMPLE 2
    


#>
function Get-NetworkDeviceConfig
{
  [CmdletBinding()]
  [Alias('Get-ndc')]
  Param
  (
    [Parameter(Mandatory=$true)]
    [string]$IP,

    [Parameter(Mandatory=$True)]
    [string]$username,

    [Parameter(Mandatory=$True)]
    [string]$password,

    [Parameter(Mandatory=$False)]
    [int]$Port
  )

  #########################
  # Setup Variables
  #########################

  function ReadStream($reader)
  {
    $line = $reader.ReadLine()
    while ($line -ne $null)
    {
      $line
      $line = $reader.ReadLine()
    }
  }

  function WriteStream($cmd, $writer, $stream)
  {
    $writer.WriteLine($cmd)
    while ($stream.Length -eq 0)
    {
      start-sleep -milliseconds 500
    }
  }
  
  # Checks if Renci dll is on the machine and stops if the library is not found in the location specified
  $dlltestpath = 'C:\SSH\lib\net40\Renci.SshNet.dll'
  if(!(Test-Path -path $dlltestpath)) 
  {
    Write-Verbose -Message 'Please Extract Renci.sshnet.dll to the Path specified' -Verbose
    Write-Verbose -Message 'Please Read the Script source for Instructions' -Verbose
    Exit
  } 
  
  # Loads DLLs as required
  Write-Verbose -Message 'Loading SSH Library dll ...' -Verbose
  $DllPath = 'C:\SSH\lib\net40\Renci.SshNet.dll'
  [void][reflection.assembly]::LoadFrom( (Resolve-Path $DllPath) )
  
  #########################
  # Establish Connection 
  #########################
    
  $ssh = new-object Renci.SshNet.SshClient($IP, $Port, $username, $Password)
  $ssh.Connect()
      
  #########################
  # 
  #########################

  $stream = $ssh.CreateShellStream('dumb', 80, 400, 800, 600, 1024)

  $reader = new-object System.IO.StreamReader($stream)
  $writer = new-object System.IO.StreamWriter($stream)
  $writer.AutoFlush = $true

  while ($stream.Length -eq 0)
  {
    start-sleep -milliseconds 500
  }
  ReadStream $reader

  #########################
  # Commands
  #########################

  WriteStream '1' $writer $stream
  ReadStream $reader

  WriteStream 'copy config config1 tftp 192.168.1.250 \cwasw01\cwasw01-config1.txt' $writer $stream
  do{
    start-sleep -Milliseconds 500
  } until ($reader.ReadLine() -Match '#')

  WriteStream 'copy event-log tftp 192.168.1.250 \cwasw01\cwasw01-eventlog.txt' $writer $stream
  do{
    start-sleep -Milliseconds 500
  } until ($reader.ReadLine() -Match '#')

  WriteStream 'copy startup-config tftp 192.168.1.250 \cwasw01\cwasw01-startup.txt' $writer $stream
  do{
    start-sleep -Milliseconds 500
  } until ($reader.ReadLine() -Match '#')

  WriteStream 'copy flash tftp 192.168.1.250 \cwasw01\cwasw01-primary.flash primary' $writer $stream
  do{
    start-sleep -Milliseconds 500
  } until ($reader.ReadLine() -Match '#')

  WriteStream 'copy flash tftp 192.168.1.250 \cwasw01\cwasw01-secondary.flash secondary' $writer $stream
  do{
    start-sleep -Milliseconds 500
  } until ($reader.ReadLine() -Match '#')

  $stream.Dispose()
  $ssh.Disconnect()
  $ssh.Dispose()

}