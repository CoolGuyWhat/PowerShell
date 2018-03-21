# This is the file that contains the list of computers you want 
# to copy the folder and files to. Change this path IAW your folder structure.
$computers = Get-Content "C:\scripts\computers.txt"
# This is the directory you want to copy to the computer (IE. c:\folder_to_be_copied)
$source = "c:\install"
# On the desination computer, where do you want the folder to be copied?
$dest = "c$"
$testPath = "c:\install\AcroRdrDC1501020060_en_US.exe"
foreach ($computer in $computers) {
    if (test-Connection -Cn $computer -quiet) {
        Copy-Item $source -Destination \\$computer\$dest -Recurse -Force
 
        if (Test-Path -Path $testPath) {
            Invoke-Command -ComputerName $computer -ScriptBlock {powershell.exe c:\Install\AcroRdrDC1501020060_en_US.exe /sAll /msi /norestart ALLUSERS=1 EULA_ACCEPT=YES}
            Write-Host -ForegroundColor Green "Installation successful on $computer"
        }
 
    } else {
        Write-Host -ForegroundColor Red "$computer is not online, Install failed"
    }
 
}