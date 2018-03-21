$adminUPN="pricea@scbc.wa.edu.au"
$orgName="southcoastbc"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential