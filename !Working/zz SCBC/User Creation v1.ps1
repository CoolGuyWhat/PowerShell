<#
    ########################################
    Idea            
    ########################################

    User Creation Script
    Hoping for an almost 1 click solution

    ########################################
    To Do            
    ########################################

    1. Assign Microsoft Licenses based on $UserOU (New Script)
    
    ########################################
    Table of Contents            
    ########################################

    1. Importing Module
    2. Getting Variables
    3. OU Selection
    4. Domain Selection
    5. User Creation
    6. Add Groups
#>

<#######################################
    1. Importing Module            
########################################>

Clear-Host

Import-Module ActiveDirectory

Clear-Host

<#######################################
    2. Getting Variables            
########################################>

Write-host '  +================================================================================================+
  |   _   _                 _____                _   _               _____           _       _     |
  |  | | | |               /  __ \              | | (_)             /  ___|         (_)     | |    |
  |  | | | |___  ___ _ __  | /  \/_ __ ___  __ _| |_ _  ___  _ __   \ `--.  ___ _ __ _ _ __ | |_   |
  |  | | | / __|/ _ \ `__| | |   | `__/ _ \/ _` | __| |/ _ \| `_ \   `--. \/ __| `__| | `_ \| __|  |
  |  | |_| \__ \  __/ |    | \__/| |  | __/ (_| | |_| | (_) | | | | /\__/ / (__| |  | | |_) | |_   |
  |   \___/|___/\___|_|    \____/|_|  \___|\__,_|\__|_|\___/|_| |_| \____/ \___|_|  |_| .__/ \__|  |
  |                                                                                   | |          |
  |                                                                                   |_|          |
  +================================================================================================+'-foregroundColor Green

Write-Host

# Users First name
$GivenName = read-host 'Enter First name'

# Users Last Name
$Surname = read-host 'Enter Last name'

# Users Username
$UserName = read-host 'Enter Username'

# Users Password
$Password = read-host 'Enter Password'

# Prompt for $Area for Section 6
Write-host 'Enter Users Area'
$Area = Read-Host 'Admin - Primary - Secondary - Childcare - SeniorStudent - PrimaryStudent - Default'

# Users Description for Active Directory
$Description = read-host 'Enter Users Description for Active Directory'

# Users Job Title (Under AD > Organization)
$Jobtitle = read-host 'Enter Users Job Title'

# HomeDrive Mount Letter
$HomeDrive = 'H:'

# Add anymore New-ADUser Properties that will be custom

#Clears Window
Clear-Host

<#######################################
    3. OU Selection
########################################>

# I've put in multiple Write-Hosts so they drop down a line. It makes it a bit neater
Write-Host
'|================ Please enter which OU the user will be created in Exactly ================|'
Write-Host 
'For Staff'
'Administration - Canteen - Childcare - NonTeaching - RBCChurch - Teachers - Library'
Write-Host
'For Students'
'Year 1 - Year 2 - Year 3 - Year 4 - Year 5 - Year 6'
'Year 7 - Year 8 - Year 9 - Year 10 - Year 11 - Year 12'
$UserOUSel = Read-Host 'OU'

# Here Static Variables are applied via which group you enter Above

Do
{
  # Staff Variables depending on $UserOUSel
  if ($UserOUSel -eq 'Administration')
  {
    $UserOU = 'OU=Administration,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'Admin.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Canteen')
  {
    $UserOU = 'OU=Canteen,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Childcare')
  {
    $UserOU = 'OU=Childcare,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'DAYCARE.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Library')
  {
    $UserOU = 'OU=Library,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'LIBRARYSTAFF.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'NonTeaching')
  {
    $UserOU = 'OU=NonTeaching,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'TEACHER.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'RBCChurch')
  {
    $UserOU = 'OU=RBCChurch,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'church'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'church.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Teachers')
  {
    $UserOU = 'OU=Teachers,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'college'
    $Depmartment = 'staff'
    $HomeDirectory = "\\mccshares1\staff$\" + $UserName
    $LogonScript = 'TEACHER.cmd'
    $Finish = 'True'
  }
	
  # Primary Student Variables depending on $UserOUSel
  Elseif ($UserOUSel -eq 'Year 1')
  {
    $UserOU = 'OU=Year 1,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents-year2.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 2')
  {
    $UserOU = 'OU=Year 2,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents-year2.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 3')
  {
    $UserOU = 'OU=Year 3,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 4')
  {
    $UserOU = 'OU=Year 4,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 5')
  {
    $UserOU = 'OU=Year 5,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 6')
  {
    $UserOU = 'OU=Year 1,OU=Primary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'Primary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'primarystudents.cmd'
    $Finish = 'True'
  }
	
  # Secondary Student Variables depending on $UserOUSel
  Elseif ($UserOUSel -eq 'Year 7')
  {
    $UserOU = 'OU=Year 07,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 8')
  {
    $UserOU = 'OU=Year 08,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 9')
  {
    $UserOU = 'OU=Year 09,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 10')
  {
    $UserOU = 'OU=Year 10,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 11')
  {
    $UserOU = 'OU=Year 11,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
	
  Elseif ($UserOUSel -eq 'Year 12')
  {
    $UserOU = 'OU=Year 12,OU=Secondary,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
    $Company = 'students'
    $Depmartment = 'secondary'
    $HomeDirectory = '\\mccshares1\students\' + $UserName
    $LogonScript = 'students.cmd'
    $Finish = 'True'
  }
}
Until ($Finish -eq 'True')

<#######################################
    4. UPN Selection
########################################>

Write-Host
Write-Host '|================ Please Enter User Principal Name ================|'
Write-Host 'scbc.wa.edu.au , maranatha.wa.edu.au , rockingham.org.au , southcoastbc.onmicrosoft.com'
$Domain = Read-Host 'Domain'

<#######################################
    5.  User Creation           
########################################>

# Clears Window
Clear-Host

Write-Host Creating User...

# Creates New User with Variables set above
Try
{
  New-ADUser -Name ($GivenName + ' ' + $Surname) -SAMAccountName $UserName -GivenName $GivenName -Surname $Surname -Path $UserOU -ErrorAction Stop -title $Jobtitle -Company $Company -Description $Description -DisplayName ($GivenName + ' ' + $Surname) -HomeDirectory $HomeDirectory -HomeDrive $HomeDrive -ScriptPath $LogonScript -UserPrincipalName $Username -AccountPassword (Convertto-SecureString $Password -AsPlainText -Force) -Enabled $true
}
Catch
{
  Throw 'Failed to Create New User'
}

#Email Variable
$Email = $UserName + '@' + $Domain

# SMTP Proxy Address for Office 365
Set-ADUser -identity $UserName -Add @{ Proxyaddresses = 'SMTP:' + $Email }

# Change UPN Name
Set-ADUser -UserPrincipalName $Email -Identity $UserName

Write-host User Created with Username: $UserName
Write-host User Created with Password: $Password
Write-host User Created with Email Address: $Email
Write-host User Created in OU: $UserOUSel

<#######################################
    6.  Add Groups           
########################################>

# Load Group Variables Table
# |===========| FSG Permission List |===========|
$ROChildcare = Get-ADGroup 'CN=FSG_RO_Childcare,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
# $RWChildcare = Get-ADGroup 'CN=FSG_RW_Childcare,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
# $FPChilcare = Get-ADGroup 'CN=FSG_FP_Childcare,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$ROAdmin = Get-ADGroup 'CN=FSG_RO_Administration,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$RWAdmin = Get-ADGroup 'CN=FSG_RW_Administration,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
# $FPAdmin = Get-ADGroup 'CN=FSG_FP_Administration,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$ROSecondary = Get-ADGroup 'CN=FSG_RO_Secondary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$RWSecondary = Get-ADGroup 'CN=FSG_RW_Secondary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
# $FPSecondary = Get-ADGroup 'CN=FSG_FP_Secondary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$ROPrimary = Get-ADGroup 'CN=FSG_RO_Primary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$RWPrimary = Get-ADGroup 'CN=FSG_RW_Primary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
# $FPPrimary = Get-ADGroup 'CN=FSG_FP_Primary,OU=Groups,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'

# Groups
$Staff = Get-ADGroup 'CN=staff,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$Admin = Get-ADGroup 'CN=Admin,OU=staff,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$PrimStudent = Get-ADGroup 'CN=Primary Students,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'
$SecStudent = Get-ADGroup 'CN=Secondary Students,OU=students,OU=User,DC=maranatha,DC=wa,DC=edu,DC=au'

# Applies Groups to User
Switch ($Area)
{
 Admin {
   Add-ADGroupMember $RWAdmin $Username
   Add-ADGroupMember $RWSecondary $Username
   Add-ADGroupMember $RWPrimary $Username
   Add-ADGroupMember $Admin $Username
   Add-ADGroupMember $Staff $Username
 }
 Primary{
   Add-ADGroupMember $ROAdmin $Username
   Add-ADGroupMember $ROSecondary $Username
   Add-ADGroupMember $RWPrimary $Username
   Add-ADGroupMember $Staff $Username
 }
 Secondary{
   Add-ADGroupMember $ROAdmin $UserName
   Add-ADGroupMember $RWSecondary $UserName
   Add-ADGroupMember $ROPrimary $UserName
   Add-ADGroupMember $Staff $Username
 }
 Childcare{
   Add-ADGroupMember $ROChildcare $UserName
 }
 SeniorStudent{
   Add-ADGroupMember $SecStudent $UserName
 }
 PrimaryStudent{
   Add-ADGroupMember $PrimStudent $UserName 
 }
 Default{
   Add-ADGroupMember $ROAdmin $UserName
   Add-ADGroupMember $ROSecondary $UserName
   Add-ADGroupMember $ROPrimary $Username
 }
}

# Fin
