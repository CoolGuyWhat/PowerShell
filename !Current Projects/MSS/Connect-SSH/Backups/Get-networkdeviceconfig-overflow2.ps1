<#
    ############
    Auto-SSH
    ############

    Author   : Aaron Price
    Company  : MSS IT
    Purpose  : SSH into and pull configs of remote networked devices to our TFTP server.
    Requires : Renci SSH dlls to be unzipped to C:\SSH

    ############
    Change Log
    ############
 
    Date: 19/03/2018 | Get-Var $Port added to default if not specified
    Date: 16/03/2018 | First working run.
    Date: 16/03/2018 | Defined $vars and removed form
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
    5. [X] If -port not specified leave as default '22'

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

    The Real MVP
    https://stackoverflow.com/questions/19864617/powershell-read-write-to-ssh-net-streams/19892705#19892705

    ############
    Last Working Run
    ############

    16/03/2018


#>
function Auto-SSH
{
  <#
      .PARAMETER IP
      Determines which IP address to connect to 
      .PARAMETER Port
      Determines which Port to connect to the IP Address using if not specified will use Port 22
      .PARAMETER Username
      Please specify the Credentials you're going to be using to connect to the network device.
      .PARAMATER Password
      Please specify the Credentials you're going to be using to connect to the network device.
      .EXAMPLE 1
      assh -IP 192.168.0.244 -Port 22 -Username Manager -Password Password1
      .EXAMPLE 2
      assh 192.168.0.244 manager Password1
  #>

  [CmdletBinding()]
  [Alias('assh')]
  Param
  (
    [Parameter(Mandatory=$True)]
    [string]$IP,

    [Parameter(Mandatory=$False)]
    [int]$Port,
    
    [Parameter(Mandatory=$True)]
    [string]$username,

    [Parameter(Mandatory=$True)]
    [string]$password


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
  if(!(Test-Path -path $dlltestpath)){
    # If it cant find the DLL Files require it will Prompt the user to specify the path and then Exit
    Write-Verbose -Message 'Please Extract Renci.sshnet.dll to the Path specified' -Verbose
    Write-Verbose -Message 'Please Read the Script source for Instructions' -Verbose
    Pause
    exit
  }
  
  # If $Port is not set, Sets 22 as the Default
  if (Get-Variable Port -Scope Script -ErrorAction SilentlyContinue) {
    $true
  } else {    
    [int]$Port = 22
  }
 
  # Loads DLLs as required
  Write-Verbose -Message 'Loading SSH Library dll ...' -Verbose
  $DllPath = 'C:\SSH\lib\net40\Renci.SshNet.dll'
  [void][reflection.assembly]::LoadFrom( (Resolve-Path $DllPath) )
  
  #########################
  # Establish Connection 
  #########################
    
  $ssh = new-object Renci.SshNet.SshClient([string]$IP, [int]$Port, [string]$username, [string]$Password)
  $ssh.Connect()
      
  #########################
  # Creates Stream read/write
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
  
  # initial command to prompt past a 'Press any key to continue'
  WriteStream '1' $writer $stream
  ReadStream $reader
  
  
  <# Run Down
                 # Our Goal is to save the configs to our TFTP server and this is the command we run Below.
      WriteStream 'copy config config1 tftp 192.168.1.250 \cwasw01\cwasw01-config1.txt' $writer $stream
      do{
      start-sleep -Milliseconds 500
      } until ($reader.ReadLine() -Match '#')
  #>

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


  #Disconncts the Session and closes the Stream
  $stream.Dispose()
  $ssh.Disconnect()
  $ssh.Dispose()

}