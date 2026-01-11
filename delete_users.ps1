$PATH = Get-Location | Select -ExpandProperty Path
$ADUsers = Import-csv $PATH\users\deleteusers.csv
$DIRECTORYID = aws ssm get-parameter --name  /workspaces/directory/id --query Parameter.Value --with-decryption --output=text

foreach ($User in $ADUsers)
{

       $Username    = $User.EDIPI
       $WorkSpaceId = aws workspaces describe-workspaces --directory-id $DIRECTORYID --user-name $Username --query Workspaces[0].WorkspaceId
       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
        Write-Output "Deleting user account for $Username."

        Remove-ADUser -Identity $Username

        Write-Output "Deleting AWS WorkSpace for $Username."

        aws workspaces terminate-workspaces --terminate-workspace-requests $WorkSpaceId
       }
       else
       {
        Write-Warning "User account for $Username does not exist."
       }

}