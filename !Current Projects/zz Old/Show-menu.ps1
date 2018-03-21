function Show-Menu
{
    Param(
        [string]$Title = 'My Menu'
        )
    Clear-Host
    Write-Host "============== $Title =============="

    Write-Host "1: Press '1' for this option"
    Write-Host "2: Press '2' for this option"
    Write-Host "3: Press '3' for this option"
    Write-Host "Q: Press 'Q' to Quit"

}
Show-Menu -title 'My Menu'
$selection = Read-host 'Please make a selection'
switch($selection)
{
    '1'{
        
    }
    '2'{
         
    }
    '3'{

    }
    '4'{

    }
    'q'{
    Return
    }
}




