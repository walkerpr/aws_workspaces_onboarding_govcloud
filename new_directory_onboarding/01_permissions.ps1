## Must be ran as Admin user, be sure to right click and select Run as User.

Get-ADForest | Set-ADForest -UPNSuffixes @{add="mil"}
Add-ADGroupMember -Identity 'AWS Delegated Administrators' -Members 'onboardAdmin'

Restart-Computer