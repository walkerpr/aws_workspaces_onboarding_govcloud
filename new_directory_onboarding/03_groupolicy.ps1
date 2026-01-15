if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$FQDN = Get-ADDomainController | Select-Object -ExpandProperty Domain
$DOMAIN_DIR = "\\$FQDN\SYSVOL\$FQDN\Policies"
Write-Object $FQDN

New-Item -ItemType Directory -Path  $DOMAIN_DIR\Packages
New-Item -ItemType Directory -Path  $DOMAIN_DIR\PolicyDefinitions
New-Item -ItemType Directory -Path  $DOMAIN_DIR\PolicyDefinitions\en-US

Copy-Item -Force -Path "C:\Program Files\Amazon\WSP\wsp.adml" -Destination "$DOMAIN_DIR\PolicyDefinitions\en-US\wsp.adml"
Copy-Item -Force -Path "C:\Program Files\Amazon\WSP\wsp.admx" -Destination "$DOMAIN_DIR\PolicyDefinitions\wsp.admx"


Copy-Item -Force -Path "packages\AWSCLIV2.msi" -Destination "$DOMAIN_DIR\Packages\AWSCLIV2.msi"
Copy-Item -Force -Path "packages\GoogleChromeStandaloneEnterprise64.msi" -Destination "$DOMAIN_DIR\packages\GoogleChromeStandaloneEnterprise64.msi"