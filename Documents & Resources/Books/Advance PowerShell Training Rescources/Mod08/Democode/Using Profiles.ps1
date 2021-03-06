# Run this demo on LON-DC1 logged on with user name Contoso\Administrator and password Pa$$w0rd
# Virtual machines that should be running: LON-DC1, LON-SVR1, LON-SVR2

# 1
# set execution policy to RemoteSigned in GPO, and run GPUpdate,
# if this statement causes an error
Set-ExecutionPolicy remotesigned

# 2
# review the paths where the profile may be found
#       Current User, Current Host $Home\[My ]Documents\WindowsPowerShell\Profile.ps1
#       Current User, All Hosts    $Home\[My ]Documents\Profile.ps1
#       All Users, Current Host    $PsHome\Microsoft.PowerShell_profile.ps1
#       All Users, All Hosts       $PsHome\Profile.ps1
$profile | select allusersallhosts,alluserscurrenthost,currentuserallhosts,currentusercurrenthost | fl

# 3
# copy profile.ps1 from the demo folder to
# your /Documents/WindowsPowerShell/profile.ps1
# On LON-DC1 loggedon as Contoso\Administrator the $PsHome location is the equivalent to C:\Windows\System32\WindowsPowerShell\V1.0 
# please do this manually

# 4
# then close any open shells and open a new shell session
# to demonstrate that the profile executed
# do this with both the ISE and the console window 

# 5
# then run this, or change execution policy in GPO and run GPUpdate
Set-ExecutionPolicy allsigned

# 6
# close shell and re-open it to show that the un-signed profile
# will NOT run and generates an error
# again, do this with both the ISE and the console window

# 7
# change execution policy back to RemoteSigned in GPO and run GPUpdate,
# or run this:
Set-ExecutionPolicy remotesigned

# NOTE
# remember, GPO overrides the locla setting, so if you've set this in
# GPO, you have to change it there