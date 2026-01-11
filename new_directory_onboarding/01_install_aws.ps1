$configText = @"
[default]
region = us-gov-west-1
"@

$credentialsText = @"
[default]
"@

$credentialsPath = ".aws\credentials"
$configPath = ".aws\config"


Set-Location $HOME

msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi

New-Item -Name ".aws" -ItemType Directory

$configText | Out-File -FilePath ".aws\config" -Encoding "UTF8"

$credentialsText | Out-File -FilePath ".aws\credentials" -Encoding "UTF8"

New-Item -Name "Documents\sample-aws-workspaces" -ItemType Directory

$MyRawStringCred = Get-Content -Raw $credentialsPath
$MyRawStringConfig = Get-Content -Raw $configPath

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

[System.IO.File]::WriteAllLines($credentialsPath , $MyRawStringCred, $Utf8NoBomEncoding)
[System.IO.File]::WriteAllLines($configPath , $MyRawStringConfig, $Utf8NoBomEncoding)

Notepad.exe  ".aws\credentials"
