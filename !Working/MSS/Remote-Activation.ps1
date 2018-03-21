<#
############
 Remote-Activation
############

 Author   : Aaron Price
 Company  : MSS IT
 Purpose  : Check if Windows is Activated if not Activate with Key
 Error Log: C:\Logs\

############
 Change Log
############
 
 Date: 01/09/2017 | Project Started and Initial Script added
 Date: 01/09/2017 | Got Filtering Just right 

############
 TO DO
############

    [X] Fix Script and Tidy up
    [ ] Filter Function more to only get Unlicensed machines

############
 Sources/Credits
############

 Build better Functions
 https://technet.microsoft.com/en-us/library/hh360993.aspx

 Get-ActivationStatus Function
 https://social.technet.microsoft.com/wiki/contents/articles/5675.determine-windows-activation-status-with-powershell.aspx


############
 Last Working Run
############

 01/09/2017

#>

Import-Module ActiveDirectory

function Get-ActivationStatus {
[CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DNSHostName = $Env:COMPUTERNAME
    )
    process {
        try {
            $wpa = Get-WmiObject SoftwareLicensingProduct -ComputerName $DNSHostName `
            -Filter "ApplicationID = '55c92734-d682-4d71-983e-d6ec3f16059f'" `
            -Property LicenseStatus -ErrorAction Stop
        } catch {
            $status = New-Object ComponentModel.Win32Exception ($_.Exception.ErrorCode)
            $wpa = $null    
        }
        $out = New-Object psobject -Property @{
            ComputerName = $DNSHostName;
            Status = [string]::Empty;
        }
        if ($wpa) {
            :outer foreach($item in $wpa) {
                switch ($item.LicenseStatus) {
                    0 {$out.Status = 'Unlicensed'}
                    1 {$out.Status = 'Licensed'; break outer}
                    2 {$out.Status = 'Out-Of-Box Grace Period'; break outer}
                    3 {$out.Status = 'Out-Of-Tolerance Grace Period'; break outer}
                    4 {$out.Status = 'Non-Genuine Grace Period'; break outer}
                    5 {$out.Status = 'Notification'; break outer}
                    6 {$out.Status = 'Extended Grace'; break outer}
                    default {$out.Status = 'Unknown value'}
                }
            }
        } else {$out.Status = $status.Message}
        $out
    }
}

# Outputs Computer from Active Directory with Windows 10 OS and Checks to see if they're licensed or not. If not Output to txt file 
Get-ADComputer -Filter {OperatingSystem -like 'Windows 10*'} | Get-ActivationStatus | Select-Object -ExpandProperty ComputerName | Format-List | Out-File C:\temp\pcs.txt

# Enter your Custom Key here
$key = ''

# Grabs content of txt file to use for foreach
$Collection = Get-Content -Path C:\temp\pcs.txt

# Connection Authentication
$Cred = Get-Credential -Credential CarersWA\MSS 

foreach ($computer in $Collection)
{
    $service = get-wmiObject -Credential $Cred -query 'select * from SoftwareLicensingService' -computername $computer
    $service.InstallProductKey($key)
    $service.RefreshLicenseStatus()
}

# Fin