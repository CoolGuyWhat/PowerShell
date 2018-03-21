
# Disconnect Network Drive
$RM = $(New-Object -ComObject WScript.Network)
$RM.RemoveNetworkDrive('Z:',0)

# PowerShell Map Network Drive
$Net = $(New-Object -ComObject WScript.Network)
$Net.MapNetworkDrive('Z:', 'https://southcoastbc.sharepoint.com/sites/ICT_Knowledge/Documents')
