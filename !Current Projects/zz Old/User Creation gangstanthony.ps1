# https://www.reddit.com/r/PowerShell/comments/4peg5u/if_selection_trouble/

<#

########################################
                Idea
########################################

    User Creation Script
    Hoping for an almost 1 click solution

########################################
                To Do
########################################

    1. Give User FP, RW, RO Permissions for necessary OU ( Write-host | Read-host )
    2. Assign Microsoft Licenses based on $UserOU (New Script)
    3. $UserName check exists (DONE)
    4. Error Handling

########################################
          Table of Contents
########################################

    0. Create Out-Menu function
    1. Importing Module
        a. Verify
    2. Getting Variables
    3. OU Selection
    4. Domain Selection
    5. User Creation

#>

<#######################################
         0. Create Out-Menu function
########################################>

# https://github.com/gangstanthony/PowerShell/blob/master/Out-Menu.ps1

function Out-Menu {
    param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$True,
            ValueFromPipelinebyPropertyName=$True)]
        [object[]]$Object,
        [string]$Header,
        [string]$Footer,
        [switch]$AllowCancel,
        [switch]$AllowMultiple
    )

    if ($input) {
        $Object = @($input)
    }

    if (!$Object) {
        throw 'Must provide an object.'
    }

    Write-Host ''

    do {
        $prompt = New-Object System.Text.StringBuilder
        switch ($true) {
            {[bool]$Header -and $Header -notmatch '^(?:\s+)?$'} { $null = $prompt.Append($Header); break }
            $true { $null = $prompt.Append('Choose an option') }
            $AllowCancel { $null = $prompt.Append(', or enter "c" to cancel.') }
            $AllowMultiple {$null = $prompt.Append("`nTo select multiple, enter numbers separated by a comma EX: 1, 2") }
        }
        Write-Host $prompt.ToString()

        for ($i = 0; $i -lt $Object.Count; $i++) {
            Write-Host "$('{0:D2}' -f ($i+1)). $($Object[$i])"
        }

        if ($Footer) {
            Write-Host $Footer
        }

        Write-Host ''

        if ($AllowMultiple) {
            $answers = @(Read-Host).Split(',').Trim()

            if ($AllowCancel -and $answers -match 'c') {
                return
            }

            $ok = $true
            foreach ($ans in $answers) {
                if ($ans -in 1..$Object.Count) {
                    $Object[$ans-1]
                } else {
                    Write-Host 'Not an option!' -ForegroundColor Red
                    Write-Host ''
                    $ok = $false
                }
            }
        } else {
            $answer = Read-Host

            if ($AllowCancel -and $answer -eq 'c') {
                return
            }

            $ok = $true
            if ($answer -in 1..$Object.Count) {
                $Object[$answer-1]
            } else {
                Write-Host 'Not an option!' -ForegroundColor Red
                Write-Host ''
                $ok = $false
            }
        }
    } while (!$ok)
}

<#######################################
         1. Importing Module
########################################>

Import-Module ActiveDirectory

##### 1. a. Verify
if (!(Get-Command New-ADUser -ea 0)) {
    throw 'Problem loading ActiveDirectory module'
}

<#######################################
         2. Getting Variables
########################################>

<#
New-ADUser property name(Powershell)    AD property on the GUI (ADAC)   LDAP attribute
DisplayName                             Display name                    displayName
GivenName                               First name                      givenName
Initials                                Middle initials                 initials
Name                                    Full name                       name
OtherName                               –                             middleName
SamAccountName                          User SamAccountName logon       sAMAccountName
Surname                                 Last name                       sn
#>

$userinfo = @{
    GivenName = Read-Host 'Please enter First name'
    Surname = Read-Host 'Please enter Last name'
    SAMAccountName = Read-Host 'Please enter Username'
    Description = Read-Host 'Please enter Users Description for Active Directory'
    Title = Read-Host 'Please enter Users Job Title'
    AccountPassword = Convertto-SecureString (Read-Host 'Please enter Password') -AsPlainText -Force
    HomeDrive = 'H:'
    Path = ''
    Company = ''
    EmailAddress = ''
    HomeDirectory = ''
    ScriptPath = ''
    Enabled = $true
}

$alreadyexists = Get-ADObject -Filter "samaccountname -eq $($userinfo.SAMAccountName)"
if ($alreadyexists) {
    Write-Warning "$($userinfo.SAMAccountName) already exists!"
    Write-Output $alreadyexists
    return
}

$userinfo.Name = $userinfo.GivenName + ' ' + $userinfo.Surname
$userinfo.DisplayName = $userinfo.Name

<#######################################
          3. OU Selection
########################################>

$UserOUSel = @{
    part1 = ''
    part2 = ''
}

$UserOUSel.part1 = Out-Menu -Object 'Staff', 'Students' -Header 'OU selection (part 1 of 2)'

switch ($UserOUSel.part1) {
    'Staff' {
        $UserOUSel.part2 = Out-Menu -Object 'Administration', 'Childcare', 'NonTeaching', 'RBCChurch', 'Teachers', 'Library' -Header 'OU selection Staff (part 2 of 2)'
        $userinfo.HomeDirectory = Join-Path '\\mccshares1\staff$\' $userinfo.SAMAccountName
    }

    'Students' {
        $UserOUSel.part2 = Out-Menu -Object (1..12 | % {"Year $_"}) -Header 'OU selection Students (part 2 of 2)'
        $userinfo.HomeDirectory = Join-Path '\\mccshares1\students\' $userinfo.SAMAccountName
    }
}

switch -Regex ($UserOUSel.part2) {
    # Staff Variables depending on $UserOUSel
    '^Administration$' {
        $userinfo.Path = 'OU=Administration,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'college'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'Admin.cmd'
    }
 
    '^Childcare$' {
        $userinfo.Path = 'OU=Childcare,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'college'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'DAYCARE.cmd'
    }
 
    '^Library$' {
        $userinfo.Path = 'OU=Library,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'college'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'LIBRARYSTAFF.cmd'
    }
 
    '^NonTeaching$' {
        $userinfo.Path = 'OU=NonTeaching,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'college'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'TEACHER.cmd'
    }
 
    '^RBCChurch$' {
        $userinfo.Path = 'OU=RBCChurch,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'church'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'church.cmd'
    }
 
    '^Teachers$' {
        $userinfo.Path = 'OU=Teachers,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.Company = 'college'
        $userinfo.Department = 'staff'
        $userinfo.ScriptPath = 'TEACHER.cmd'
    }
 
    # Primary Student Variables depending on $UserOUSel
    '^Year \d+$' {
        $userinfo.Company = 'students'
    }

    '^Year [1-6]$' {
        $userinfo.Path = "OU=$_,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au"
        $userinfo.Department = 'Primary'
    }

    '^Year 1$' {
        $userinfo.ScriptPath = 'primarystudents-year2.cmd'
    }
 
    '^Year 2$' {
        $userinfo.ScriptPath = 'primarystudents-year2.cmd'
    }
 
    '^Year 3$' {
        $userinfo.ScriptPath = 'primarystudents.cmd'
    }
 
    '^Year 4$' {
        $userinfo.ScriptPath = 'primarystudents.cmd'
    }
 
    '^Year 5$' {
        $userinfo.ScriptPath = 'primarystudents.cmd'
    }
 
    '^Year 6$' {
        $userinfo.Path = 'OU=Year 1,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
        $userinfo.ScriptPath = 'primarystudents.cmd'
    }
 
    # Secondary Student Variables depending on $UserOUSel
    '^Year (?:[7-9]|1[0-2])$' {
        $userinfo.Path = "OU=$_,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au"
        $userinfo.Department = 'secondary'
        $userinfo.ScriptPath = 'students.cmd'
    }
}

<#######################################
          4. Domain Selection
########################################>

$Domain = Out-Menu -Object 'scbc.wa.edu.au','maranatha.wa.edu.au','rockingham.org.au' -Header 'Domain selection'

# Create Email Variable
$userinfo.EmailAddress = $userinfo.SAMAccountName + '@' + $Domain

<#######################################
         5. User Creation
########################################>

New-ADUser @userinfo

# SMTP Proxy Address
Set-ADUser -Identity $userinfo.SAMAccountName -Add @{Proxyaddresses = 'SMTP:' + $userinfo.SAMAccountName + '@' + $Domain}