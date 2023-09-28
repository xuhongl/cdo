$GroupName = "Students23Fall"
$TenantID = "632dab3f-61fd-4748-b017-76fb265a3bc3"
$ClientId = "1b14c59e-ceaa-4d81-864d-f3dcbb8b0393"
$SPNsecret = "CCY8Q~qm7dVbrMwSIgzbb1dWIVklxEl-MuflLdnt"
$SemseterStudentList = "csv1.csv"
$List = "csv1.csv"

$ClientSecretPass = ConvertTo-SecureString -String $SPNsecret -AsPlainText -Force

$ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $ClientSecretPass

Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $ClientSecretCredential

$GroupID = (Get-MgGroup -All | Where-Object {$_.DisplayName -like $GroupName }).Id

$UserList = Import-Csv -Path $List

foreach ($user in $UserList){
    $Displayname = $User.FirstName+" "+$User.LastName

    $user.Email = $user.email

    New-MgInvitation -InvitedUserDisplayName $Displayname -InvitedUserEmailAddress $user.Email -SendInvitationMessage:$false -InviteRedirectUrl "https://algonquincdo.ca/Azure" 

 #   $UserID=  (Get-MgUser -All | Where-Object {$_.Mail -like $user.Email }).Id
   # $UserID
  #  New-MgGroupMember -GroupId $GroupID -DirectoryObjectId $UserID 
}
