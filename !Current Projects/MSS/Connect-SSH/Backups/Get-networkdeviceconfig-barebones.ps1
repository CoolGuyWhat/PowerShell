
$DllPath = 'C:\SSH\lib\net40\Renci.SshNet.dll'
[void][reflection.assembly]::LoadFrom( (Resolve-Path $DllPath) )

$IP = '192.168.0.244'
$Port = 22
$username = 'manager'
$Password = 'SaWnWn2!'

if (Get-Variable Port -Scope Global -ErrorAction SilentlyContinue) {
    $true
} else {
    $false
    write-host if you see this its bad
    [int]$Port = 22
}

# $CS = @{ IP = $IP; Port = $Port; Username = $username; Password = $Password; }

$SshClient = New-Object Renci.SshNet.SshClient([string]$IP, [int]$Port, [string]$username, [string]$Password)
$SshClient.Connect()

$SshCommand = $SshClient.RunCommand('show arp')
$SshCommand.Result 

$SshCommand.Dispose()
$SshClient.Disconnect()
$SshClient.Dispose()