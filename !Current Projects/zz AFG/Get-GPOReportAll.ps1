Import-Module ActiveDirectory

## Set-Location 'C:\Users\aaron.price\onedrive - afg\powershell\Current'

Try{
    # $GPOs = Get-GPO -all -domain afgonline.com.au | Select-Object -Property DispalyName
    $GPOs = Get-GPO -name 'User - Network Mapping - IT!' -ErrorAction SilentlyContinue
}Catch{
    if($? -eq $false){
        Write-Host 'No Report Generated. Confirm Name or Authentication' -ForegroundColor Red
    }
}
$OutputDir = 'C:\temp'
Test-Path $OutputDir
If(!(Test-Path $OutputDir)){
    New-Item $OutputDir -ItemType Directory
}

ForEach($GPO in $GPOs){
    $GPOName = $GPO.Displayname
    Write-Host " --- Found $GPOName " -ForegroundColor Yellow
    Get-GPOReport -Name $GPOName -ReportType HTML | Out-file C:\Temp\$GPOName.html -ErrorAction SilentlyContinue

    if($? -eq $true){
        Write-Host 'File created successfully' $OutputDir\$GPOName.html -ForegroundColor Green

    }

}