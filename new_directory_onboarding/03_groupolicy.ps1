$FQDN = Get-ADDomainController | Select-Object -ExpandProperty Domain
$DOMAIN_DIR = "\\$FQDN\SYSVOL\$FQDN\Policies"
echo $FQDN

New-Item -ItemType Directory -Path  $DOMAIN_DIR\Packages
New-Item -ItemType Directory -Path  $DOMAIN_DIR\PolicyDefinitions
New-Item -ItemType Directory -Path  $DOMAIN_DIR\PolicyDefinitions\en-US

Copy-Item -Force -Path "C:\Program Files\Amazon\WSP\wsp.adml" -Destination "$DOMAIN_DIR\PolicyDefinitions\en-US\wsp.adml"
Copy-Item -Force -Path "C:\Program Files\Amazon\WSP\wsp.admx" -Destination "$DOMAIN_DIR\PolicyDefinitions\wsp.admx"


Copy-Item -Force -Path "packages\AWSCLIV2.msi" -Destination "$DOMAIN_DIR\Packages\AWSCLIV2.msi"
Copy-Item -Force -Path "packages\GoogleChromeStandaloneEnterprise64.msi" -Destination "$DOMAIN_DIR\packages\GoogleChromeStandaloneEnterprise64.msi"