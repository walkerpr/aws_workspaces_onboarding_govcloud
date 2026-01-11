## Must be ran as Admin user, be sure to right click and select Run as User.

Add-ADGroupMember -Identity 'AWS Delegated Administrators' -Members 'onboardAdmin'

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Restart-Computer