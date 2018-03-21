Stop and Start the print spooler
	$obj = Set-service 'Spooler'
	$obj.stop()
	$obj.start()

Set a value in the registry.
	Set-Location HKCU:\
	Set-itemproperty -path 'hkcu:\Control Panel\Mouse' -name MouseSensitivity -value '9'

Change the screensaver timeout to 20 min.
	Set-Location HKLM:\
	Set-itemproperty -path 'hklm:\...' 

Generate a list of all the exe files on your system
	$Dir = Get-ChildItem C:\ -Recures
	$Dir | Where {$_.Extension -eq ".exe"}

Use enter-pssession to connect to remote machine
	Enter-PSSession -Computer 'MSSFS01' -Credential MSS\mss

Read the last 20 errors from the event log
	Get-EventLog -Logname System -EntryType Error -Newest 20

Generate a list of all available WMI classes
	Get-WMIObject -List *Win32* | Select-Object -Property * | Format-List -Property name

List the start command or full path of every executable (hint: use wmi)

Identify what account the spooler is running as (hint: use wmi)

Uninstall Java (hint: use wmi)

Get IP and Current Logged in user of remote machine (function)

Get error logs of remote machine into into Excel (function) 
	User32
	
Get HDD space of remote machine into Excel (function)

Remote Active Directory Users tool (function)

Add/set-mailboxfolderpermissions (function)

Stop users from shutting down a terminal server

Get Content of file and save as .txt for Dropbox sync so code is readable on web

Create Network profile switcher
