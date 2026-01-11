$PATH = Get-Location | Select -ExpandProperty Path

New-GPO -Name 'AWS Workspaces'
New-GPO -Name 'Certificates'
New-GPO -Name 'PackagesInstallation'

Import-GPO -BackupGpoName 'AWS Workspaces' -TargetName 'AWS Workspaces' -path "$PATH\gpo\workspaces"

Import-GPO -BackupGpoName 'Certificates' -TargetName 'Certificates' -path "$PATH\gpo\certificates"

Import-GPO -BackupGpoName 'PackagesInstallation' -TargetName 'PackagesInstallation' -path "$PATH\gpo\packages"

New-GPLink -Name 'AWS Workspaces' -Target "OU=directory,DC=directory,DC=dev"

New-GPLink -Name 'Certificates' -Target "OU=directory,DC=directory,DC=dev"

New-GPLink -Name 'PackagesInstallation' -Target "OU=directory,DC=directory,DC=dev"

gpupdate /force