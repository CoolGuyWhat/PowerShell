# This form was created using POSHGUI.com  a free online gui designer for PowerShell

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '297,177'
$Form.text                       = 'Form'
$Form.TopMost                    = $false

$IP_Address                      = New-Object system.Windows.Forms.Label
$IP_Address.text                 = 'IP_Address:'
$IP_Address.AutoSize             = $true
$IP_Address.width                = 25
$IP_Address.height               = 10
$IP_Address.location             = New-Object System.Drawing.Point(10,20)
$IP_Address.Font                 = 'Microsoft Sans Serif,10'

$IP_AddresBox                    = New-Object system.Windows.Forms.TextBox
$IP_AddresBox.multiline          = $false
$IP_AddresBox.width              = 185
$IP_AddresBox.height             = 20
$IP_AddresBox.location           = New-Object System.Drawing.Point(100,17)
$IP_AddresBox.Font               = 'Microsoft Sans Serif,10'

$Port                            = New-Object system.Windows.Forms.Label
$Port.text                       = 'Port:'
$Port.AutoSize                   = $true
$Port.width                      = 25
$Port.height                     = 10
$Port.location                   = New-Object System.Drawing.Point(10,50)
$Port.Font                       = 'Microsoft Sans Serif,10'

$PortBox                         = New-Object system.Windows.Forms.TextBox
$PortBox.multiline               = $false
$PortBox.text                    = '22'
$PortBox.width                   = 50
$PortBox.height                  = 20
$PortBox.location                = New-Object System.Drawing.Point(100,47)
$PortBox.Font                    = 'Microsoft Sans Serif,10'

$UsernamBox                      = New-Object system.Windows.Forms.TextBox
$UsernamBox.multiline            = $false
$UsernamBox.width                = 185
$UsernamBox.height               = 20
$UsernamBox.location             = New-Object System.Drawing.Point(100,77)
$UsernamBox.Font                 = 'Microsoft Sans Serif,10'

$Username                        = New-Object system.Windows.Forms.Label
$Username.text                   = 'Username:'
$Username.AutoSize               = $true
$Username.width                  = 25
$Username.height                 = 10
$Username.location               = New-Object System.Drawing.Point(10,80)
$Username.Font                   = 'Microsoft Sans Serif,10'

$PasswordBox                     = New-Object system.Windows.Forms.MaskedTextBox
$PasswordBox.multiline           = $false
$PasswordBox.width               = 185
$PasswordBox.height              = 20
$PasswordBox.location            = New-Object System.Drawing.Point(100,107)
$PasswordBox.Font                = 'Microsoft Sans Serif,10'

$Password                        = New-Object system.Windows.Forms.Label
$Password.text                   = 'Password:'
$Password.AutoSize               = $true
$Password.width                  = 25
$Password.height                 = 10
$Password.location               = New-Object System.Drawing.Point(10,110)
$Password.Font                   = 'Microsoft Sans Serif,10'

$Cancel                          = New-Object system.Windows.Forms.Button
$Cancel.text                     = 'Cancel'
$Cancel.width                    = 60
$Cancel.height                   = 30
$Cancel.location                 = New-Object System.Drawing.Point(225,138)
$Cancel.Font                     = 'Microsoft Sans Serif,10'
$Cancel.Add_Click({                $Form.Close()})

$OK                              = New-Object system.Windows.Forms.Button
$OK.text                         = 'OK'
$OK.width                        = 60
$OK.height                       = 30
$OK.location                     = New-Object System.Drawing.Point(152,138)
$OK.Font                         = 'Microsoft Sans Serif,10'
$OK.Add_Click({                    $Form.Close()})

$Form.controls.AddRange(@($IP_Address,$IP_AddresBox,$Port,$PortBox,$UsernamBox,$Username,$PasswordBox,$Password,$Cancel,$OK))
# If cancel was clicked Remove the Variables
if($Cancel.count -ge 1){
  #Remove-Variable IP_Address,IP_AddresBox,Port,PortBox,UsernamBox,Username,PasswordBox,Password
}

#endregion GUI }


#Write your logic code here

[void]$Form.ShowDialog()

Write-host $IP_AddresBox.Text