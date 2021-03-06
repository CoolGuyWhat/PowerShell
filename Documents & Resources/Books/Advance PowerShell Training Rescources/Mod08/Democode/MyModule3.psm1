function reachable($computer) {
    $result = test-connection $computer
    if ($result[3].statuscode -eq 0) {
        write $true
    } else {
        write $false
    }
}

function Get-ComputerDetails {
<#
.SYNOPSIS
Retrieves operating system and BIOS version information from one or more computers.
.DESCRIPTION
Get-ComputerDetails retrieves a computer's operating system build number, BIOS serial
number, and service pack version from one or more computers specified by computer name
or by IP address.
.PARAMETER computername
Specifies one computer name, or an array of computer names. This parameter accepts
string values as pipeline input.
.EXAMPLE
Get-ComputerDetails -computername Server1
.EXAMPLE
Assuming a text file with one computer name per line:
Get-Content c:\computernames.txt | Get-ComputerDetails
.INPUTS
System.String
.OUTPUTS
Custom object
#>
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

export-modulemember -function Get-ComputerDetails

new-alias gcd Get-ComputerDetails
export-modulemember -alias gcd



