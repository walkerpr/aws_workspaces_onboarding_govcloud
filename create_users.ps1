$PATH = Get-Location | Select -ExpandProperty Path

$ADUsers = Import-csv $PATH\users\users.csv
$DIRECTORYID = aws ssm get-parameter --name  /workspaces/directory/id --query Parameter.Value --with-decryption --output=text
$PASSWORD = aws ssm get-parameter --name   /workspaces/directory/temporary/password --query Parameter.Value --with-decryption --output=text
$KMSarn = aws kms describe-key --key-id "alias/aws/workspaces" --query KeyMetadata.Arn --output=text
$BUNDLEId = "<REPLACE WITH WORKSPACE BUNDLE ID>"


foreach ($User in $ADUsers)
{

       $Username    = $User.EDIPI
       $Password    = $PASSWORD
       $Firstname   = $User.firstname
       $Lastname    = $User.lastname
       $DisplayName = $User.firstname
       $Email       = $User.email
       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
        #If user does exist, output a warning message
        Write-Warning "A user account for $Username already exists in Active Directory. Skipping to next user."

        Write-Output "Confirming existing user has AWS Workspace. Errors can be ignored."
        aws workspaces create-workspaces --workspaces BundleId=$BUNDLEId,DirectoryId=$DIRECTORYID,UserName=$Username,UserVolumeEncryptionEnabled="true",RootVolumeEncryptionEnabled="true",VolumeEncryptionKey=$KMSarn,WorkspaceProperties='{RunningMode=AUTO_STOP,RunningModeAutoStopTimeoutInMinutes=60}'

       }

       else
       {
              #If a user does not exist then create a new user account

        #Account will be created in the OU listed in the $OU variable in the CSV file;
        Write-Output "A user account for $Username does not exist in Active Directory. Creating user."
        New-ADUser -Name "$Firstname $Lastname" `
           -SamAccountName $Username `
           -UserPrincipalName $Username'@mil' `
           -GivenName $Firstname `
           -Surname $Lastname `
           -DisplayName $DisplayName `
           -Email $Email `
           -Enabled $true `
           -PasswordNeverExpires $true `
           -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
        Write-Output "Creating an AWS Workspace for $Username."
        aws workspaces create-workspaces --workspaces BundleId=$BUNDLEId,DirectoryId=$DIRECTORYID,UserName=$Username,UserVolumeEncryptionEnabled="true",RootVolumeEncryptionEnabled="true",VolumeEncryptionKey=$KMSarn,WorkspaceProperties='{RunningMode=AUTO_STOP,RunningModeAutoStopTimeoutInMinutes=60}'
       }


}