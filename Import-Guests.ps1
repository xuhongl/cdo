$List = "23Fstudent.csv"
$GroupName = "Students23Fall"
$TenantID = "e39de75c-b796-4bdd-888d-f3d21250910c"
$ClientId = "26d186fa-3037-4f87-a2a7-e18a300a92ad"
$SPNsecret = "CCY8Q~qm7dVbrMwSIgzbb1dWIVklxEl-MuflLdnt"

$ClientSecretPass = ConvertTo-SecureString -String $SPNsecret -AsPlainText -Force

$ClientSecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $ClientSecretPass

Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $ClientSecretCredential

$GroupID = (Get-MgGroup -All | Where-Object {$_.DisplayName -like $GroupName }).Id

$UserList = Import-Csv -Path $List

foreach ($user in $UserList){
    $Displayname = $User.FirstName+" "+$User.LastName

    $user.Email

    New-MgInvitation -InvitedUserDisplayName $Displayname -InvitedUserEmailAddress $user.Email -SendInvitationMessage:$false -InviteRedirectUrl "https://algonquincdo.ca/Azure" 

 #   $UserID=  (Get-MgUser -All | Where-Object {$_.Mail -like $user.Email }).Id
   # $UserID
  #  New-MgGroupMember -GroupId $GroupID -DirectoryObjectId $UserID 
}
