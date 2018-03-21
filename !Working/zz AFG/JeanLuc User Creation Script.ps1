#Get AFG Logo
try {$url = "http://imgur.com/uExCyDV.png"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, "C:\temp\Script resources\AFGLOGO.png")}
catch {}

Add-Type -AssemblyName presentationframework

Function infopage {
[xml]$inputXML0 = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="User Creation" Height="350" Width="525" Topmost="True" WindowStartupLocation="CenterScreen">
    <Grid Margin="0,0,0,0">
        <Label Name="label" Content="IT Services - Active Directory User Creation Tool&#xD;&#xA;&#xD;&#xA;&#xD;&#xA;" Margin="123,10,123,0" VerticalAlignment="Top" Height="29"/>
        <TextBlock Name="textBlock" HorizontalAlignment="Left" Height="254" Margin="0,55,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="517" Foreground="Black" FontSize="13"><Run FontWeight="Bold" Text="T" TextDecorations="Underline"/><Run FontWeight="Bold" Text="his tool automatically completes the below" TextDecorations="Underline"/><LineBreak/><Run Text="■&#x9;Create specified user from user templates"/><LineBreak/><Run Text=" "/><Run Text="&#x9;"/><Run Text="(OU=User"/><Run Text="T"/><Run Text="emplates,OU=Templates,DC=afgonline,DC=com,DC=au)&#xA;■&#x9;Generate password for new user&#xA;■&#x9;Establish email addresses on new user"/><LineBreak/><Run Text="&#x9;"/><Run Text="(afgonline, afghomeloans, afgsecurities and"/><Run Text=" "/><Run Text="establishproperty)&#xA;■&#x9;Move new user to specified OU if user is located in WA/HO&#xA;■&#x9;Move new user to state OU if user is located in a state office&#xA;■&#x9;Assign Office 365 E3 (if specified) otherwise assign E1"/><Run Text=" "/><Run Text="license&#xA;■&#x9;Sends summary email notification in"/><Run Text="c"/><Run Text=" password to"/><Run Text=" "/><Run Text="users manage"/><Run Text="r"/><Run Text=" (optional)"/><Run Text="&#xA;■&#x9;Sends summary email notification including password"/></TextBlock>

    </Grid>
</Window>

"@
[xml]$XAML0 = $inputXML0

#Read XAML
 
    $reader0=(New-Object System.Xml.XmlNodeReader $XAML0)
  try{$Form0=[Windows.Markup.XamlReader]::Load( $reader0 )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
# Load XAML Objects In PowerShell

$XAML0.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form0.FindName($_.Name)}

# Shows the form
$Form0.ShowDialog() | out-null
}

##############ENTER NAME PAGE##############

Function Page1{

[xml]$inputXML1 = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="User Creation" Height="450" Width="535" Topmost="True" WindowStartupLocation="CenterScreen">
    <Grid Margin="0,0,0,0">
        <Image Name="AFG_Logo" HorizontalAlignment="Left" Height="133" VerticalAlignment="Top" Width="125" Source="C:\Temp\Script resources\AFGLOGO.png" Margin="15,-35,100,0"/>
        <TextBlock Name="textBlock1" HorizontalAlignment="Left" Margin="187,43,0,0" TextWrapping="Wrap" VerticalAlignment="Top" FontWeight="Bold" TextDecorations="{x:Null}" TextAlignment="Center" Width="290"><Run Text="This program is for use by IT Services for "/><Run Text="            new user creation"/></TextBlock>
        <Button Name="button1" Content="OK" HorizontalAlignment="Left" Height="43" Margin="275,325,0,0" VerticalAlignment="Top" Width="72"/>
        <Button Name="button2" Content="Exit" HorizontalAlignment="Left" Height="43" Margin="350,325,0,0" VerticalAlignment="Top" Width="72"/>
        <Button Name="button3" Content="Info" HorizontalAlignment="Left" Height="20" Margin="450,325,0,0" VerticalAlignment="Top" Width="40"/>
        <TextBox Name="textBox1" HorizontalAlignment="Left" Height="26" Margin="125,177,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120"/>
        <TextBox Name="textBox" HorizontalAlignment="Left" Height="26" Margin="125,210,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120"/>
        <ComboBox Name="comboBox6" HorizontalAlignment="Left" Margin="125,243,0,0" VerticalAlignment="Top" Width="190" Height="26" IsEditable="True" ToolTip="Select from the drop down or type your own!">
            <ComboBoxItem Content="Accountant"/>
            <ComboBoxItem Content="Accounts Officer"/>
            <ComboBoxItem Content="Administration Officer"/>
            <ComboBoxItem Content="Arrears Officer"/>
            <ComboBoxItem Content="Broker Admin Officer"/>
            <ComboBoxItem Content="Broker Services Officer"/>
            <ComboBoxItem Content="Business Analyst"/>
            <ComboBoxItem Content="Business Development Manager"/>
            <ComboBoxItem Content="Business Relationship Manager"/>
            <ComboBoxItem Content="Client Services Officer"/>
            <ComboBoxItem Content="Compliance Officer"/>
            <ComboBoxItem Content="Credit Analyst"/>
            <ComboBoxItem Content="Executive Assistant"/>
            <ComboBoxItem Content="IT Support Officer"/>
            <ComboBoxItem Content="Legal Counsel"/>
            <ComboBoxItem Content="Lender Services Officer"/>
            <ComboBoxItem Content="Operations Officer"/>
            <ComboBoxItem Content="Payments Officer"/>
            <ComboBoxItem Content="Relationship Manager"/>
            <ComboBoxItem Content="Remuneration Officer"/>
            <ComboBoxItem Content="Systems Administrator"/>
        </ComboBox>
        <ComboBox Name="comboBox1" HorizontalAlignment="Left" Margin="125,276,0,0" VerticalAlignment="Top" Width="100" Height="26">
            <ComboBoxItem Content="NSW"/>
            <ComboBoxItem Content="QLD"/>
            <ComboBoxItem Content="SA"/>
            <ComboBoxItem Content="VIC"/>
            <ComboBoxItem Content="WA"/>
        </ComboBox>
        <ComboBox Name="comboBox2" HorizontalAlignment="Left" Margin="125,309,0,0" VerticalAlignment="Top" Width="100" Height="26">
            <ComboBoxItem Content="E1"/>
            <ComboBoxItem Content="E3"/>
        </ComboBox>
        <Label Name="label1" Content="First name:" HorizontalAlignment="Left" Margin="34,175,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <Label Name="label" Content="Last name:" HorizontalAlignment="Left" Margin="34,208,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <Label Name="label2" Content="Job Title:" HorizontalAlignment="Left" Margin="34,241,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <Label Name="label3" Content="State:" HorizontalAlignment="Left" Margin="34,274,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <Label Name="label4" Content="E1/E3 License?" HorizontalAlignment="Left" Margin="34,307,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <TextBlock Name="textBlock" HorizontalAlignment="Left" Margin="30,130,0,0" TextWrapping="Wrap" Text="Please enter new user details:" VerticalAlignment="Top"/>
        <ComboBox Name="comboBox4" HorizontalAlignment="Left" Height="26" Margin="275,175,0,0" VerticalAlignment="Top" Width="220" SelectedIndex="0">
            <ComboBoxItem Content="Select a user template"/>
            <ComboBoxItem Content="No Template"/>
        </ComboBox>
        <CheckBox Name="checkBox" Content="Send email to manager?" HorizontalAlignment="Left" Margin="275,275,0,0" VerticalAlignment="Top"/>
        <ComboBox Name="comboBox5" HorizontalAlignment="Left" Margin="275,210,0,0" VerticalAlignment="Top" Width="220" Height="26" SelectedIndex="0" ToolTip="All users receive @afgonline.com.au address">
            <ComboBoxItem Content="Email address to assign user"/>
            <ComboBoxItem Content="1 @afgonline.com.au only"/>
            <ComboBoxItem Content="2 @afghomeloans.com.au (Primary)"/>
            <ComboBoxItem Content="3 @afgsecurities.com.au (Primary)"/>
            <ComboBoxItem Content="4 @establishproperty.com.au (Primary)"/>
        </ComboBox>
    </Grid>
</Window>

"@

[xml]$XAML1 = $inputXML1

#Read XAML
 
    $reader1=(New-Object System.Xml.XmlNodeReader $XAML1)
  try{$form1=[Windows.Markup.XamlReader]::Load( $reader1 )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
# Load XAML Objects In PowerShell

$XAML1.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $form1.FindName($_.Name)}

# Actually make the objects work

$templateList = (Get-ADUser -Filter * -SearchBase "OU=User Templates,OU=Templates,DC=afgonline,DC=com,DC=au" -Properties name, samaccountname | Select-Object name, samaccountname | Sort-Object name, samaccountname -Descending)

foreach ($template in $templateList.samaccountname){

$displayname = Get-ADUser $template -Properties * | Select-Object -ExpandProperty name

#Set-Variable -Name i $i -Scope global
Set-Variable -Name dislayname $displayname -Scope global

"$displayname" | Out-File -FilePath "C:\Temp\template.txt" -Append
}

Get-Content "C:\Temp\template.txt" | ForEach-Object {$wpfcombobox4.addchild($_)}

Remove-Item "C:\Temp\template.txt"

function entername {

$firstname = $WPFtextBox1.text
$lastname = $WPFtextBox.text
$jobtitle = $WPFcombobox6.text
Set-Variable -Name jobtitle $jobtitle -Scope Global
$state = $wpfcombobox1.text
Set-Variable -Name state $state -Scope Global
$365license = $wpfcombobox2.text
Set-Variable -Name 365license $365license -Scope Global

if (($firstname -like $null) -or ($lastname -like $null) -or ($jobtitle -like $null) -or ($state -like $null) -or ($365license -like $null)) {$WPFtextBlock.text = "## You can't leave fields blank! ##"}    

elseif (($firstname -match "[0-9]") -or ($lastname -match "[0-9]") -or ($jobtitle -match "[0-9]")) {$WPFtextBlock.text = "## Numbers aren't allowed! ##"}

else {$firstname = $WPFtextBox1.text;$lastname = $WPFtextBox.text;$jobtitle = $WPFcombobox6.text;$state = $wpfcombobox1.text;$form1.close()}

#converts first letter of first/lastname to uppercase
try {$firstname = $firstname.substring(0,1).toupper()+$firstname.substring(1).tolower()
$lastname = $lastname.substring(0,1).toupper()+$lastname.substring(1).tolower()}
catch {}
Set-Variable -Name firstname $firstname -Scope Global
Set-Variable -Name lastname $lastname -Scope Global

#converts rest of first/lastname to lowercase
$firstnameusername = $firstname.substring(0).tolower()
$lastnameusername = $lastname.substring(0).tolower()

#create username based on firstname/lastname
$username =  $firstnameusername+"."+$lastnameusername
$username = $username -replace '[-]'

Set-Variable -Name username $username -Scope Global

#State dropdown
$state = $wpfcombobox1.text

#365 Licensing dropdown
$365license = $wpfcombobox2.text
Set-Variable -Name 365license $365license -Scope Global

#User template dropdown
$templatechoice = $wpfcombobox4.text
Set-Variable -Name templatechoice $templatechoice -Scope Global

if (($templatechoice -eq "Select a user template")) {$WPFtextBlock.text = "Please select a template!"}

#Convert template name to SamAccountname and store propereties to new user
$templatename = Get-Aduser -f{displayName -eq $templatechoice} -Properties * | Select-Object -ExpandProperty SamAccountname
try {$templateproperties = Get-Aduser "$templatename" -Properties Office, Company, Department, HomePage, ipPhone, mobile,MobilePhone, officePhone,PostalCode,State, StreetAddress,telephoneNumber,wWWHomePage, Fax, City, POBox, Manager, Country}
catch {}
Set-Variable -Name templateproperties $templateproperties -Scope Global
Set-Variable -Name templatename $templatename -Scope Global

#Generate non-standard email dropdown
$gennonstandardchoice = $wpfcombobox5.text
Set-Variable -Name gennonstandardchoice $gennonstandardchoice -Scope Global

#Send email to manager checkbox
if ($wpfcheckbox.ischecked) {$sendcreationemailtomanager = "Yes"}
    else {$sendcreationemailtomanager = "No"}
Set-Variable -Name sendcreationemailtomanager $sendcreationemailtomanager -Scope Global


#select emailaddress dropdown

if ($gennonstandardchoice -eq "Email address to assign user") {$wpftextblock.text = "Please select an email address!"}
elseif ($gennonstandardchoice -match "1") {$emailchoice = "$username@afgonline.com.au"}
elseif ($gennonstandardchoice -match "2") {$emailchoice = "$username@afghomeloans.com.au"}
elseif ($gennonstandardchoice -match "3") {$emailchoice = "$username@afgsecurities.com.au"}
elseif ($gennonstandardchoice -match "4") {$emailchoice = "$username@establishproperty.com.au"}
Set-Variable -Name emailchoice $emailchoice -Scope Global
} 
 
$WPFbutton1.Add_Click({entername})
$WPFbutton2.Add_Click({$form1.Close();exit})
$WPFbutton3.Add_Click({infopage})


# Shows the form
$Form1.ShowDialog() | out-null

}

Function Prescript {
#email notification settings
$smtp = "office365-mailhost.afgonline.com.au"
Set-Variable -Name smtp $smtp -Scope Global
$fromaddress = "itservices@afgonline.com.au"
Set-Variable -Name fromaddress -$fromaddress -Scope Global
$user1 = "naveen.farey@afgonline.com.au"
Set-Variable -Name user1 $user1 -Scope Global
$user1name = "Naveen Farey"
Set-Variable -Name user1name $user1name -Scope Global
$user2 = "jeanluc.brocx@afgonline.com.au"
Set-Variable -Name user2 $user2 -Scope Global
$user2name = "Jean-Luc Brocx"
Set-Variable -Name user2name $user2name -Scope Global


#Import active directory module
Import-Module Activedirectory

#Generate Password for new user
Add-Type -AssemblyName System.Web

$genpassword = "AFGnewuser"
Set-Variable -Name genpassword $genpassword -Scope Global

#credentials for emc
try {$usercredential = Get-Credential -Credential jeanluc.brocx@afgonline.com.au}
catch {exit}
Set-Variable -Name usercredential $usercredential -Scope Global

$mailserversession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://prd-mailapp4-1.afgonline.com.au/PowerShell/ -Authentication Kerberos -Credential $UserCredential 
Set-Variable -Name mailserversession $mailserversession -Scope Global

#$msonlinecredential = Get-Credential -Credential office365admin@afgtest.onmicrosoft.com
#Set-Variable -Name msonlinecredential $msonlinecredential -Scope Global

#Import emc session 
try {Import-PSSession $mailserversession -AllowClobber -ErrorAction SilentlyContinue | Out-Null}
catch {}

#connect to office 365

$2fa = Get-ChildItem $env:localappdata\apps\2.0\*\CreateExoPSSession.ps1 -Recurse | Select-Object -ExpandProperty DirectoryName

Import-Module $2fa\CreateExoPSSession.ps1 -NoClobber
Connect-EXOPSSession -UserPrincipalName office365admin@afgtest.onmicrosoft.com
Page1
    }

#ARE YOU SURE PAGE + OU SELECTION IF IN WA

function Page2{

[xml]$inputXML2 = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="User Creation" Height="400" Width="535" Topmost="True" WindowStartupLocation="CenterScreen">
    <Grid Margin="0,0,0,0">
        <Image Name="AFG_Logo" HorizontalAlignment="Left" Height="133" VerticalAlignment="Top" Width="125" Source="C:\Temp\Script resources\AFGLOGO.png" Margin="15,-30,100,0"/>
        <Button Name="button1" Content="Yes" HorizontalAlignment="Left" Height="43" Margin="325,300,0,0" VerticalAlignment="Top" Width="72"/>
        <Button Name="button2" Content="No" HorizontalAlignment="Left" Height="43" Margin="425,300,0,0" VerticalAlignment="Top" Width="72"/>
        <TextBlock Name="textBlock2" HorizontalAlignment="Left" Margin="155,70,0,0" TextWrapping="Wrap" VerticalAlignment="Top" FontSize="14" ><Run FontWeight="Bold" Text="Are you sure you wish to create:"/></TextBlock>
        <TextBlock Name="textBlock3" HorizontalAlignment="Left" Margin="131,97,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" ><Run FontWeight="Bold" Text="First name:"/><Run FontWeight="Bold"/></TextBlock>
        <TextBlock Name="textBlock4" HorizontalAlignment="Left" Margin="131,113,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" ><Run FontWeight="Bold" Text="Last name:"/><Run FontWeight="Bold"/></TextBlock>
        <TextBlock Name="textBlock5" HorizontalAlignment="Left" Margin="131,129,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92"><Run FontWeight="Bold" Text="Title"/><Run Text=":"/></TextBlock>
        <TextBlock Name="textBlock6" HorizontalAlignment="Left" Margin="131,145,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92"><Run FontWeight="Bold" Text="Username"/><Run Text=":"/></TextBlock>
        <TextBlock Name="textBlock7" HorizontalAlignment="Left" Margin="131,161,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" FontWeight="Bold" Text="Email Address:"/>
        <TextBlock Name="textBlock8" HorizontalAlignment="Left" Margin="131,177,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92"><Run FontWeight="Bold" Text="State"/><Run Text=":"/></TextBlock>
        <TextBlock Name="textBlock9" HorizontalAlignment="Left" Margin="131,193,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" FontWeight="Bold" Text="365 License:"/>
        <TextBlock Name="textBlock10" HorizontalAlignment="Left" Margin="131,209,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" FontWeight="Bold" Text="Template:"/>
        <TextBlock Name="textBlock11" HorizontalAlignment="Left" Margin="131,225,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="92" FontWeight="Bold" Text="Email Manager:"/>
        <TextBlock Name="textBlock12" HorizontalAlignment="Left" Margin="228,97,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock13" HorizontalAlignment="Left" Margin="228,113,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock14" HorizontalAlignment="Left" Margin="228,129,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock15" HorizontalAlignment="Left" Margin="228,145,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock16" HorizontalAlignment="Left" Margin="228,161,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="220"/>
        <TextBlock Name="textBlock17" HorizontalAlignment="Left" Margin="228,177,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock18" HorizontalAlignment="Left" Margin="228,193,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <TextBlock Name="textBlock19" HorizontalAlignment="Left" Margin="228,209,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="220"/>
        <TextBlock Name="textBlock20" HorizontalAlignment="Left" Margin="228,225,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="182"/>
        <ComboBox Name="comboBox3" HorizontalAlignment="Left" Margin="131,260,0,0" VerticalAlignment="Top" Width="200" Height="26" SelectedIndex="0">
            <ComboBoxItem Content="Select an AD OU to move user"/>
            <ComboBoxItem Content="1 Client Services"/>
            <ComboBoxItem Content="2 Credit Services"/>
            <ComboBoxItem Content="3 Member Services"/>
            <ComboBoxItem Content="4 Member Support"/>
            <ComboBoxItem Content="5 Compliance"/>
            <ComboBoxItem Content="6 Corporate"/>
            <ComboBoxItem Content="7 Executive"/>
            <ComboBoxItem Content="8 Finance"/>
            <ComboBoxItem Content="9 HR"/>
            <ComboBoxItem Content="10 IT - BI"/>
            <ComboBoxItem Content="11 IT - Developers"/>
            <ComboBoxItem Content="12 IT - Infrastructure"/>
            <ComboBoxItem Content="13 IT - Management"/>
            <ComboBoxItem Content="14 Legal"/>
            <ComboBoxItem Content="15 Marketing"/>
            <ComboBoxItem Content="16 Property"/>
            <ComboBoxItem Content="17 Securities"/>
            <ComboBoxItem Content="18 WA Sales"/>
            <ComboBoxItem Content="19 Broker Admin"/>

        </ComboBox>
        </Grid>
</Window>

"@

[xml]$XAML2 = $inputXML2

#Read XAML
 
    $reader2=(New-Object System.Xml.XmlNodeReader $XAML2)
  try{$form2=[Windows.Markup.XamlReader]::Load( $reader2 )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
# Load XAML Objects In PowerShell

$XAML2.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $form2.FindName($_.Name)}

# Actually make the objects work

#hides OU selection if state is not WA
if ($state -ne "WA") {$wpfcombobox3.height = 0}

$wpftextblock12.text = "$firstname"
$wpftextblock13.text = "$lastname"
$wpftextblock14.text = "$jobtitle"
$wpftextblock15.text = "$username"
$wpftextblock16.text = "$emailchoice"
$wpftextblock17.text = "$state"
$wpftextblock18.text = "$365license"
if ($templatechoice -eq "No Template") {$wpftextblock19.text = "NO TEMPLATE SELECTED"}
else {$wpftextblock19.text = "$templatechoice"}

#Send email to manager checkbox
$wpftextblock20.text = "$sendcreationemailtomanager"

$WPFbutton1.Add_Click({$holocation = $wpfcombobox3.text;Set-Variable -Name holocation $holocation -Scope Global;$form2.close()})
$WPFbutton2.Add_Click({$form2.Close();exit})


# Shows the form
$Form2.ShowDialog() | out-null

clear
}

Function Page3 {
#Create new user based off template
Write-Host "CREATING 'TEMPUSER' IN AD" -ForegroundColor Green
New-ADUser -Instance $templateproperties -Name "tempuser" -GivenName "tempuser" -Surname "tempuser" -DisplayName "tempuser" -SamAccountName "tempuser" -UserPrincipalName "temp@afgonline.com.au" -AccountPassword (ConvertTo-SecureString -AsPlainText $genpassword -Force) -Path "OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -PassThru | Out-Null
Enable-ADAccount -Identity "tempuser"
Start-Sleep -Seconds 5

Write-Host "RENAMING 'TEMPUSER' TO $firstname $lastname" -ForegroundColor Green
Rename-ADObject -Identity "CN=tempuser,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -NewName "$firstname $lastname"
Start-Sleep -Seconds 5
Write-Host "SETTING AD DETAILS ON $firstname $lastname" -ForegroundColor Green
Set-ADUser -identity "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -GivenName $firstname -Surname $lastname -DisplayName "$firstname $lastname" -Description "$jobtitle" -Title "$jobtitle" -Office $state -State $state -SamAccountName $username -UserPrincipalName "$username@afgonline.com.au"
#sleep
start-sleep -Seconds 5

#get new users manager required for email notification

$managerexist = get-aduser $username -Properties manager | Select-Object -ExpandProperty manager

if ($managerexist -ne $null){ 

$managersamaccountname = (get-aduser (get-aduser $username -Properties *).manager).samaccountname

$managername = (get-aduser (get-aduser $username -Properties *).manager).Name

Write-Host "GETTING MANAGER: $managername's EMAIL ADDRESS" -ForegroundColor Green

$manageremail = (Get-ADUser $managersamaccountname -Properties *).mail}
Set-Variable -Name manageremail $manageremail -Scope Global

#set address/phone/fax details
Write-Host "SETTING $state ADDRESS, PHONE AND FAX DETAILS" -ForegroundColor Green

switch ($state) 
    { 
        "WA" {Set-ADUser $username -StreetAddress "100 Havelock Street" -City "West Perth" -State "WA" -PostalCode "6005" -Office "WA" -OfficePhone "08 9420" -Fax "08 9420 7859"} 
       "NSW" {Set-ADUser $username -StreetAddress "Level 7, 32 Walker Street" -City "North Sydney" -State "NSW" -PostalCode "2060" -Office "NSW" -OfficePhone "02 8908" -Fax "02 9957 4257"} 
        "QLD" {Set-ADUser $username -StreetAddress "5/3950 Pacific Highway" -City "Loganholme" -State "QLD" -PostalCode "4129" -Office "QLD" -OfficePhone "07 3078" -Fax "07 3078 2917"} 
        "VIC" {Set-ADUser $username -StreetAddress "Level 19, 60 Albert Road" -City "Melbourne" -State "VIC" -PostalCode "3205" -Office "VIC" -OfficePhone "03 9038" -Fax "03 9866 5244"} 
        "SA" {Set-ADUser $username -StreetAddress "5/64 Glen Osmond Road"-City "Parkside" -POBox "PO Box 314" -State "SA" -PostalCode "5063" -Office "SA" -OfficePhone "08 7421"-Fax "08 8373 7751"} 
    }

    #add state groups to new user
if (($state -eq "NSW") -or ($state -eq "QLD") -or ($state -eq "VIC") -or ($state -eq "SA")){
Write-Host "ADDING $state STATE GROUPS" -ForegroundColor Green}


switch ($state){
       "NSW" {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "NSW Staff"
       Add-ADPrincipalGroupMembership -Identity $username -MemberOf "Remote Access General"}        
        "QLD" {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "QLD Staff"
        Add-ADPrincipalGroupMembership -Identity $username -MemberOf "Remote Access General"} 
        "VIC" {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC Staff"
        Add-ADPrincipalGroupMembership -Identity $username -MemberOf "Remote Access General"} 
        "SA" {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "SA Staff"
      Add-ADPrincipalGroupMembership -Identity $username -MemberOf "Remote Access General"} 
      }

#move state user to correct state OU

if (($state -eq "NSW") -or ($state -eq "QLD") -or ($state -eq "VIC") -or ($state -eq "SA"))
{Write-Host "MOVING TO $state OU" -ForegroundColor Green}
     
switch ($state)
    {
       "NSW" {Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=NSW,OU=AFG Users,DC=afgonline,DC=com,DC=au"} 
        "QLD" {Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=QLD,OU=AFG Users,DC=afgonline,DC=com,DC=au"} 
        "VIC" {Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=VIC,OU=AFG Users,DC=afgonline,DC=com,DC=au"} 
        "SA" {Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=SA,OU=AFG Users,DC=afgonline,DC=com,DC=au"} 
    }
#move user to correct ou in head office
if (($state -eq "WA")) {write-host "MOVING TO $holocation OU" -ForegroundColor Green}
$holocation = $holocation.split(" ")[0]
switch ($holocation){
1{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Client Services,OU=AFG Home Loans,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
2{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Credit Services,OU=AFG Home Loans,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
3{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Member Services,OU=CABS,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
4{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Member Support,OU=CABS,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
5{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Compliance,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
6{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Corporate,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
7{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Executive,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
8{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Finance,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
9{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=HR,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
10{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Business Intelligence,OU=IT,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
11{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Developers,OU=IT,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
12{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Infrastructure,OU=IT,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
13{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Management,OU=IT,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
14{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Legal,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
15{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Marketing,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
16{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Property,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
17{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Securities,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
18{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=WA Sales,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
19{Move-ADObject "CN=$firstname $lastname,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au" -TargetPath "OU=Member Support,OU=CABS,OU=HO,OU=AFG Users,DC=afgonline,DC=com,DC=au"}
}

#Copy group membership to new user from requested template
Write-Host "COPYING GROUP MEMBERSHIP FROM TEMPLATE" -ForegroundColor Green
Get-ADuser -Identity $templatename -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $username

#add new user to default groups
Write-Host "ADDING TO "ALL AFG STAFF" AND "ALL USERS"" -ForegroundColor Green
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "All AFG Staff" 
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "All Users"

#add required state based groups
if (($state -eq "VIC" -or "WA" -or "SA" -or "QLD" -or "NSW") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "State Office BDMs"; Write-Host "ADDING BDM STATE GROUP" -ForegroundColor Green
}

# SA - AFG Sales Signature & AFG Home Loans Staff
if (($state -eq "SA") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG - Sales Signature - 2016"
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG Home Loans Staff";Write-Host "ADDING SA BDM SALES STAFF GROUPS" -ForegroundColor Green
}

if (($state -eq "SA") -and  ($jobtitle -eq "Business Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG - Sales Signature - 2016"
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG Home Loans Staff"; Write-Host "ADDING SA BRM GROUPS" -ForegroundColor Green
}

#WA Groups

if (($state -eq "WA") -and ($holocation -eq "18")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "SA Access Group"
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "SOE - Network Mapping - WA"
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "SOE - Network Mapping - SA" 
Add-ADPrincipalGroupMembership -Identity $username -MemberOf "WA Staff"
Write-Host "ADDING WA SALES GROUPS" -ForegroundColor Green
}

# WA BDM
if (($state -eq "WA") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "WA BDM"; Write-Host "ADDING WA BDM GROUPS" -ForegroundColor Green
}
# WA RM
if (($state -eq "WA") -and ($jobtitle -eq "Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "WA RM"; Write-Host "ADDING WA RM GROUPS" -ForegroundColor Green
}

#VIC Groups

# VIC BDM
if (($state -eq "VIC") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC BDM";Write-Host "ADDING VIC BDM GROUPS" -ForegroundColor Green
}
# VIC RM
if (($state -eq "VIC") -and ($jobtitle -eq "Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC RM";Write-Host "ADDING VIC RM GROUPS" -ForegroundColor Green}
# VIC Sales Staff
if (($state -eq "VIC") -and ($jobtitle -eq "Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC Sales Staff";Write-Host "ADDING VIC RM SALES STAFF GROUPS" -ForegroundColor Green}
if (($state -eq "VIC") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC Sales Staff";Write-Host "ADDING VIC BDM SALES STAFF GROUPS" -ForegroundColor Green}
if (($state -eq "VIC") -and ($jobtitle -eq "Business Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC Sales Staff";Write-Host "ADDING VIC BRM SALES STAFF GROUPS" -ForegroundColor Green}
#VIC Management
if (($state -eq "VIC") -and ($jobtitle -match "State Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "VIC Management"; Write-Host "ADDING VIC MANAGEMENT GROUPS" -ForegroundColor Green}


# QLD BDM
if (($state -eq "QLD") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "QLD BDM"; Write-Host "ADDING QLD BDM GROUPS" -ForegroundColor Green}

#NSW Sales Staff
if (($state -eq "NSW") -and ($jobtitle -eq "Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "NSW Sales Staff";Write-Host "ADDING NSW RM SALES STAFF GROUPS" -ForegroundColor Green}
if (($state -eq "NSW") -and ($jobtitle -like "Business Development Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "NSW Sales Staff";Write-Host "ADDING NSW BDM SALES STAFF GROUPS" -ForegroundColor Green}
if (($state -eq "NSW") -and ($jobtitle -eq "Business Relationship Manager")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "NSW Sales Staff";Write-Host "ADDING NSW BRM SALES STAFF GROUPS" -ForegroundColor Green}

# AFG Home Loans Sales
if ($jobtitle -eq "Business Relationship Manager") {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG Home Loans Sales";Write-Host "ADDING AFG HOME LOANS SALE GROUP" -ForegroundColor Green}


#add new user to ho staff if state equals WA

If ($state -eq "WA") {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "Head Office Staff";Write-Host "ADDING TO HEAD OFFICE STAFF" -ForegroundColor Green}

#Sleep
[Int32]$Seconds = 10
        [string]$Message = "Please wait..."
    
    ForEach ($Count in (1..10))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
""

#Perform Active Directory Sync

#Write-Host "Performing Active Directory Sync - Stage 1 of 2" -ForegroundColor Yellow
#repadmin /replicate $dc1 $dc2 DC=afgonline,DC=com,DC=au | Out-Null
#repadmin /replicate $dc2 $dc3 DC=afgonline,DC=com,DC=au | Out-Null

""
#Sleep
#[Int32]$Seconds = 5
#        [string]$Message = "Please wait..."
#   
#    ForEach ($Count in (1..5))
#    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
#        Start-Sleep -Seconds 1
#    }
#    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
#
#repadmin /replicate $dc1 $dc2 DC=afgonline,DC=com,DC=au | Out-Null
#repadmin /replicate $dc2 $dc3 DC=afgonline,DC=com,DC=au | Out-Null

#Sleep
#[Int32]$Seconds = 5
#        [string]$Message = "Please wait..."
#    
#    ForEach ($Count in (1..5))
#    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
#        Start-Sleep -Seconds 1
#    }
#    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed

# Generate email address

Write-Host "GENERATING AFGONLINE EMAIL ADDRESS" -ForegroundColor Green
Enable-MailUser -Identity $username -ExternalEmailAddress "$username@afgonline.com.au" -Alias $username | Out-Null

#Add AFG.Finance Alias
Set-MailUser $username -EmailAddresses @{add="$username@afg.finance"};Write-Host "ADDING AFG.FINANCE ALIAS TO USER" -ForegroundColor Green


# Remove Email Address Policy
Write-Host "REMOVING EMAIL ADDRESS POLICY" -ForegroundColor Green
Set-MailUser $username -EmailAddressPolicyEnabled $false

#create non-standard email address
if ($gennonstandardchoice -match "2") {Set-MailUser -Identity $username -EmailAddresses @{Add="$username@afghomeloans.com.au"}; Start-Sleep -Seconds 5; Set-MailUser $username -EmailAddresses SMTP:$username@afghomeloans.com.au,smtp:$username@afgonline.com.au; Write-Host "GENERATING AFG HOME LOANS EMAIL ADDRESS" -ForegroundColor Green}
  elseif ($gennonstandardchoice -match "3") {Set-MailUser -Identity $username -EmailAddresses @{Add="$username@afgsecurities.com.au"} ;Start-Sleep -Seconds 5;Set-MailUser $username -EmailAddresses SMTP:$username@afgsecurities.com.au,smtp:$username@afgonline.com.au; Write-Host "GENERATING AFG SECURITIES EMAIL ADDRESS" -ForegroundColor Green}
  elseif ($gennonstandardchoice -match "4") {Set-MailUser -Identity $username -EmailAddresses @{Add="$username@establishproperty.com.au"};Start-Sleep -Seconds 5;Set-MailUser $username -EmailAddresses SMTP:$username@establishproperty.com.au,smtp:$username@afgonline.com.au; Write-Host "GENERATING ESTABLISH PROPERTY EMAIL ADDRESS" -ForegroundColor Green}

  # Import MsOnline Module

Import-Module MsOnline -DisableNameChecking -WarningAction SilentlyContinue | Out-Null

# Add user to AFG Home Loans Staff Group

$getmail = get-aduser $username -Properties mail | Select-Object -ExpandProperty mail

if (($state -eq "VIC" -or "WA" -or "SA" -or "QLD" -or "NSW") -and ($getmail -eq "$username@afghomeloans.com.au")) {Add-ADPrincipalGroupMembership -Identity $username -MemberOf "AFG Home Loans Staff";; Write-Host "ADDING TO AFG HOME LOANS STAFF" -ForegroundColor Green}

#Sleep

[Int32]$Seconds = 10
        [string]$Message = "Please wait..."
    
    ForEach ($Count in (1..10))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed

#Perform Directory Sync on prd-wsusapp4-1

Write-Host ""
Write-Host "Performing Office 365 Directory Sync..." -ForegroundColor Yellow
$s = New-PSSession -computerName prd-wsusapp4-1.afgonline.com.au
Invoke-Command -Session $s -Scriptblock {C:\Users\Public\Desktop\ADSync.ps1}
""
Invoke-Command -Session $s -Scriptblock {Write-Host "Sync Complete!" -ForegroundColor Green}
Remove-PSSession $s
""
#Sleep for directory sync to take effect
      [Int32]$Seconds = 120
        [string]$Message = "Please wait..."
    
    ForEach ($Count in (1..120))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
Write-Host "Username for MsolServer - office365admin@afgtest.onmicrosoft.com" -foregroundcolor yellow
Connect-MsolService
""

#Set License Usage Location for new user
Write-Host "SETTING 365 LOCATION" -ForegroundColor Green
Set-MsolUser -UserPrincipalName "$username@afgonline.com.au" -UsageLocatio AU -WarningAction SilentlyContinue

#Assign 365 License to new user
If ($365license -eq "E3") {Set-MsolUserLicense -UserPrincipalName "$username@afgonline.com.au" -AddLicenses "afgtest:ENTERPRISEPACK" -WarningAction SilentlyContinue; Write-Host "ADDING OFFICE 365 ENTERPRISE E3 LICENSE" -ForegroundColor Green}
If ($365license -eq "E1") {Set-MsolUserLicense -UserPrincipalName "$username@afgonline.com.au" -AddLicenses "afgtest:STANDARDPACK" -WarningAction SilentlyContinue; Write-Host "ADDING OFFICE 365 ENTERPRISE E1 LICENSE" -ForegroundColor Green}

""
Write-Host "Waiting for mailbox to create..." -ForegroundColor Yellow
""

#Sleep for mailbox to create
      [Int32]$Seconds = 150
        [string]$Message = "Please wait for mailbox to be created..."
    
    ForEach ($Count in (1..150))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed

#disable Focused Inbox
Write-Host "DISABLING FOCUSED INBOX" -ForegroundColor Green
Set-FocusedInbox -Identity "$username@afgonline.com.au" -FocusedInboxOn $false | Out-Null

# Disconnect EMC Session
#Remove-PSSession $mailserverSession

#Import-PSSession $365Session -DisableNameChecking | Out-Null

#Configuration for Mailbox Auditing
Write-Host "ENABLING MAILBOX AUDITING" -ForegroundColor Green
Set-Mailbox -Identity "$username@afgonline.com.au" -AuditEnabled $true
Set-Mailbox -identity "$username@afgonline.com.au" -AuditOwner MailboxLogin

#Remove unrequired products from E1 license
Write-Host "REMOVE UNNEEDED PRODUCTS FROM OFFICE365 $365license LICENSE" -ForegroundColor Green
$x = New-MsolLicenseOptions -AccountSkuId "afgtest:STANDARDPACK" -DisabledPlans "YAMMER_ENTERPRISE", "SWAY", "PROJECTWORKMANAGEMENT", "POWERAPPS_O365_P1", "FLOW_O365_P1", "Deskless", "STREAM_O365_E1"
$y = New-MsolLicenseOptions -AccountSkuId "afgtest:ENTERPRISEPACK" -DisabledPlans "YAMMER_ENTERPRISE", "SWAY", "PROJECTWORKMANAGEMENT", "POWERAPPS_O365_P2", "FLOW_O365_P2", "Deskless", "RMS_S_ENTERPRISE", "STREAM_O365_E3"
  
If ($365license -eq "E1") {Get-MsolUser -UserPrincipalName "$username@afgonline.com.au" | Set-MsolUserLicense -LicenseOptions $x}
If ($365license -eq "E3") {Get-MsolUser -UserPrincipalName "$username@afgonline.com.au" | Set-MsolUserLicense -LicenseOptions $y}

$foremailnotification = Get-ADUser $username -Properties * | Select-Object Name, Samaccountname, Userprincipalname, Office, Title, Mail, CanonicalName, Department, Manager, ProxyAddresses,memberof | Sort-Object -Descending |  fl | Out-String

#out-file password to a text file which will be submitted as a email attachment

$genpassword |  Out-File -FilePath "C:\Temp\Password.txt"

# send email notification to IT

Send-MailMessage -SmtpServer $smtp -Priority High -From $fromaddress -To $user1 -Cc $user2 -Subject "AD account created for $firstname $lastname" -Body $foremailnotification -Attachments "C:\Temp\Password.txt"

#send email notification to new users manager


""

if ($sendcreationemailtomanager -eq "Yes") {Send-MailMessage -SmtpServer $smtp -Priority High -From $fromaddress -To $manageremail -Subject "AD Account created for $firstname $lastname" -Body $foremailnotification -Attachments "C:\Temp\Password.txt" | Write-Host "Account summary email notification for $firstname $lastname has now been sent to $managername"}


Write-Host "Account summary email notification for $firstname $lastname has now been sent to $user1name & $user2name" -ForegroundColor Yellow

""

del "C:\Temp\Password.txt"
}

Function DefaultSignature {
Write-Host "Generating Default Office 365 Signature" -ForegroundColor Green

#try {EndPSS}
#catch {Write-Host ""}

copy "C:\Temp\default-template.html" "C:\Temp\template1.html"

Write-Host "Collecting User Information" -ForegroundColor Green


$firstname = get-aduser $username -properties * | select-object -expandproperty givenname
$lastname = get-aduser $username -properties * | select-object -expandproperty surname
$jobtitle = get-aduser $username -properties * | select-object select-object -expandproperty Title
$telephonenumber = get-aduser $username -properties * | select-object TelephoneNumber| select-object select-object -expandproperty TelephoneNumber
$faxnumber = get-aduser $username -properties * | select-object Fax| select-object select-object -expandproperty fax
$streetaddress = get-aduser $username -properties * | select-object StreetAddress| select-object select-object -expandproperty streetaddress
$state = get-aduser $username -properties * | select-object state| select-object select-object -expandproperty state
$postalcode = get-aduser $username -properties * | select-object postalcode| select-object select-object -expandproperty postalcode
$city = get-aduser $username -properties * | select-object city| select-object select-object -expandproperty city


(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "first", $firstname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "last", $lastname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "jobtitle", $jobtitle} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "telephone", $telephonenumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "faxnumber", $faxnumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "streetaddress", $streetaddress} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "city", $city} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "state", $state} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "postalcode", $postalcode} | Set-Content -Path "C:\Temp\template1.html"

Write-Host "Setting Office 365 Signature - Default" -ForegroundColor Green


 Set-MailboxMessageConfiguration $username -SignatureHtml (Get-content -path "C:\Temp\template1.html")
 Set-MailboxMessageConfiguration $username -AlwaysShowBcc $true
 Set-MailboxMessageConfiguration $username -AlwaysShowFrom $true
 Set-MailboxMessageConfiguration $username -AutoAddSignature $true
 Set-MailboxMessageConfiguration $username -AutoAddSignatureOnReply $true

 start-sleep -seconds 5

 del "C:\Temp\template1.html"

 Write-Host "Completed Default Office 365 Signature" -ForegroundColor Green

 # Disconnect Sessions
Get-PSSession | Remove-PSSession
}

Function SalesSignature {
Write-Host "GENERATING SALES OFFICE 365 SIGNATURE" -ForegroundColor Green

#try {EndPSS;Write-Host "CLEARING PS SESSIONS" -ForegroundColor Green}
#catch {Write-Host ""}


copy "C:\Temp\sales-template.html" "C:\Temp\template1.html"

Write-Host "Collecting User Information" -ForegroundColor Green


$firstname = get-aduser $username -properties * | select-object -expandproperty givenname
$lastname = get-aduser $username -properties * | select-object -expandproperty surname
$jobtitle = get-aduser $username -properties * | select-object select-object -expandproperty Title
$telephonenumber = get-aduser $username -properties * | select-object TelephoneNumber| select-object select-object -expandproperty TelephoneNumber
$faxnumber = get-aduser $username -properties * | select-object Fax| select-object select-object -expandproperty fax
$streetaddress = get-aduser $username -properties * | select-object StreetAddress| select-object select-object -expandproperty streetaddress
$state = get-aduser $username -properties * | select-object state| select-object select-object -expandproperty state
$postalcode = get-aduser $username -properties * | select-object postalcode| select-object select-object -expandproperty postalcode
$city = get-aduser $username -properties * | select-object city| select-object select-object -expandproperty city


(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "first", $firstname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "last", $lastname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "jobtitle", $jobtitle} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "telephone", $telephonenumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "faxnumber", $faxnumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "streetaddress", $streetaddress} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "city", $city} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "state", $state} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "postalcode", $postalcode} | Set-Content -Path "C:\Temp\template1.html"

Write-Host "Setting Office 365 Signature - Sales" -ForegroundColor Green


 Set-MailboxMessageConfiguration $username -SignatureHtml (Get-content -path "C:\Temp\template1.html")
 Set-MailboxMessageConfiguration $username -AlwaysShowBcc $true
 Set-MailboxMessageConfiguration $username -AlwaysShowFrom $true
 Set-MailboxMessageConfiguration $username -AutoAddSignature $true
 Set-MailboxMessageConfiguration $username -AutoAddSignatureOnReply $true

 start-sleep -seconds 5

 del "C:\Temp\template1.html"

 Write-Host "Completed Sales Office 365 Signature" -ForegroundColor Green

 # Disconnect Sessions
Get-PSSession | Remove-PSSession
}

Function SalesHLSignature {
Write-Host "Generating Home Loans Sales Office 365 Signature" -ForegroundColor Green

#try {EndPSS}
#catch {Write-Host ""}

copy "C:\Temp\HLSales-template.html" "C:\Temp\template1.html"

Write-Host "Collecting User Information" -ForegroundColor Green


$firstname = get-aduser $username -properties * | select-object -expandproperty givenname
$lastname = get-aduser $username -properties * | select-object -expandproperty surname
$jobtitle = get-aduser $username -properties * | select-object select-object -expandproperty Title
$telephonenumber = get-aduser $username -properties * | select-object TelephoneNumber| select-object select-object -expandproperty TelephoneNumber
$faxnumber = get-aduser $username -properties * | select-object Fax| select-object select-object -expandproperty fax
$streetaddress = get-aduser $username -properties * | select-object StreetAddress| select-object select-object -expandproperty streetaddress
$state = get-aduser $username -properties * | select-object state| select-object select-object -expandproperty state
$postalcode = get-aduser $username -properties * | select-object postalcode| select-object select-object -expandproperty postalcode
$city = get-aduser $username -properties * | select-object city| select-object select-object -expandproperty city


(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "first", $firstname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "last", $lastname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "jobtitle", $jobtitle} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "telephone", $telephonenumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "faxnumber", $faxnumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "streetaddress", $streetaddress} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "city", $city} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "state", $state} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "postalcode", $postalcode} | Set-Content -Path "C:\Temp\template1.html"

Write-Host "Setting Office 365 Signature - Home Loans Sales" -ForegroundColor Green


 Set-MailboxMessageConfiguration $username -SignatureHtml (Get-content -path "C:\Temp\template1.html")
 Set-MailboxMessageConfiguration $username -AlwaysShowBcc $true
 Set-MailboxMessageConfiguration $username -AlwaysShowFrom $true
 Set-MailboxMessageConfiguration $username -AutoAddSignature $true
 Set-MailboxMessageConfiguration $username -AutoAddSignatureOnReply $true

 start-sleep -seconds 5

 del "C:\Temp\template1.html"

 Write-Host "Completed Home Loans Sales Office 365 Signature" -ForegroundColor Green

 # Disconnect Sessions
Get-PSSession | Remove-PSSession
}

Function CreditSignature {
Write-Host "Generating Credit Office 365 Signature" -ForegroundColor Green

#try {EndPSS}
#catch {Write-Host ""}


copy "C:\Temp\Credit-template.html" "C:\Temp\template1.html"

Write-Host "Collecting User Information" -ForegroundColor Green


$firstname = get-aduser $username -properties * | select-object -expandproperty givenname
$lastname = get-aduser $username -properties * | select-object -expandproperty surname
$jobtitle = get-aduser $username -properties * | select-object select-object -expandproperty Title
$telephonenumber = get-aduser $username -properties * | select-object TelephoneNumber| select-object select-object -expandproperty TelephoneNumber
$faxnumber = get-aduser $username -properties * | select-object Fax| select-object select-object -expandproperty fax
$streetaddress = get-aduser $username -properties * | select-object StreetAddress| select-object select-object -expandproperty streetaddress
$state = get-aduser $username -properties * | select-object state| select-object select-object -expandproperty state
$postalcode = get-aduser $username -properties * | select-object postalcode| select-object select-object -expandproperty postalcode
$city = get-aduser $username -properties * | select-object city| select-object select-object -expandproperty city


(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "first", $firstname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "last", $lastname} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "jobtitle", $jobtitle} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "telephone", $telephonenumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "faxnumber", $faxnumber} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "streetaddress", $streetaddress} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "city", $city} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "state", $state} | Set-Content -Path "C:\Temp\template1.html"
(Get-Content -Path "C:\Temp\template1.html") | ForEach-Object {$_ -Replace "postalcode", $postalcode} | Set-Content -Path "C:\Temp\template1.html"

Write-Host "Setting Office 365 Signature - Credit" -ForegroundColor Green


 Set-MailboxMessageConfiguration $username -SignatureHtml (Get-content -path "C:\Temp\template1.html")
 Set-MailboxMessageConfiguration $username -AlwaysShowBcc $true
 Set-MailboxMessageConfiguration $username -AlwaysShowFrom $true
 Set-MailboxMessageConfiguration $username -AutoAddSignature $true
 Set-MailboxMessageConfiguration $username -AutoAddSignatureOnReply $true

 start-sleep -seconds 5

 del "C:\Temp\template1.html"

 Write-Host "Completed Credit Office 365 Signature" -ForegroundColor Green

 # Disconnect Sessions
Remove-PSSession *
}

#Function EndPSS {
#Get-PSSession | Remove-PSSession }

Function Signature{
Import-Module ActiveDirectory
$groupmember = (Get-ADUser $username –Properties MemberOf | Select-Object MemberOf).memberof

if ($groupmember -contains "CN=AFG Sales Signature,OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au")
{SalesSignature}

elseif ($groupmember -contains "CN=AFG Sales Signature (AFGHL),OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au")
{SalesHLSignature}

elseif ($groupmember -contains "CN=AFGHL Credit Services Signature,OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au")
{CreditSignature}

elseif ($groupmember -notcontains "CN=AFG Sales Signature,OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au" -or "CN=AFG Sales Signature (AFGHL),OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au" -or "CN=AFGHL Credit Services Signature,OU=Signature,OU=IT,OU=Groups,DC=afgonline,DC=com,DC=au")
{DefaultSignature}
}

function RUN {Prescript;Page2;clear;Page3;Signature}

RUN

""

Write-Host "Please don't forget to update $firstname $lastname's 'IP Phone', 'Mobile' and 'Telephone number' records in AD" -ForegroundColor Yellow

""

Write-Host "AD account successfully created For $firstname $lastname" -ForegroundColor Green

pause