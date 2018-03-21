$title = 'Authentication'
$message = 'Do you want to Authenticate before retrieving the Computer Details ?'
$yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes',
  'Yes ?'
$no = New-Object System.Management.Automation.Host.ChoiceDescription '&No',
  'No ?'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
switch ($result)
    {
        0 {'You selected Yes.'}
        1 {'You selected No.'}
    }