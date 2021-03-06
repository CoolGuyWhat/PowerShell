function reachable($computer) {
    $result = test-connection $computer
    if ($result[3].statuscode -eq 0) {
        write $true
    } else {
        write $false
    }
}

function Get-ComputerDetails {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string[]]$computername
    )
    BEGIN {}
    PROCESS {
        if (reachable($computername)) {
            $os = get-wmiobject win32_operatingsystem -computername $computername
            $obj = new-object psobject
            $obj | add-member noteproperty ComputerName $computername
            $obj | add-member noteproperty BuildNumber ($os.buildnumber)
            $obj | add-member noteproperty SPVersion ($os.servicepackmajorversion)
            $bios = get-wmiobject win32_bios -computername $computername
            $obj | add-member noteproperty BIOSSerial ($bios.serialnumber)
            write $obj
        }
    }
    END {}
}




