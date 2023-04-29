# PowerShell v7.3.3

# This script will install the AzureAD module if it is not already installed.
if (!(Get-Module -Name AzureAD -ListAvailable)) {
    Write-Output "AzureAD module is not installed. Installing..."
    Install-Module -Name AzureAD -Scope CurrentUser
    Import-Module -Name AzureAD
} else {
    Import-Module -Name AzureAD
}
# This script will install the MSOnline module if it is not already installed.
if (!(Get-Module -Name MSOnline -ListAvailable)) {
    Write-Output "MSOnline module is not installed. Installing..."
    Install-Module -Name MSOnline -Scope CurrentUser
    Import-Module -Name MSOnline
} else {
    Import-Module -Name MSOnline
}

# Store the Azure AD credentials in a variable.
$username = "billing@hickenair.com"
$password = ConvertTo-SecureString "2kYXm7Q6#X3uoQt5" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)


# Initiates a connection to Azure Active Directory.
Connect-MsolService -AzureEnvironment AzureCloud -Credential $credentials

# Get a list of users
#$users = Get-MsolUser
#
## Loop through the users and set ImmutableID to be the same as the UPN
#foreach ($user in $users) {
#    Set-MsolUser -UserPrincipalName $($user.UserPrincipalName) -ImmutableId $($user.UserPrincipalName)
#    Write-Output "ImmutableID `"$($user.UserPrincipalName)`" set for user `"$($user.UserPrincipalName)`"."
#}

# Get a list of users
# Get-MsolUser -All | Select-Object UserPrincipalName, ImmutableId

# Set a IdP Data from Google
$DomainName = "hickenair.com"
$FederationBrandName = "Hicken Google Cloud Identity"
$Authentication = "Federated"
$PassiveLogOnUrl = "https://accounts.google.com/o/saml2/idp?idpid=C012f42vy"
$ActiveLogOnUri = "https://accounts.google.com/o/saml2/idp?idpid=C012f42vy"
$SigningCertificate = "MIIDdDCCAlygAwIBAgIGAYUJbtJwMA0GCSqGSIb3DQEBCwUAMHsxFDASBgNVBAoTC0dvb2dsZSBJbmMuMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MQ8wDQYDVQQDEwZHb29nbGUxGDAWBgNVBAsTD0dvb2dsZSBGb3IgV29yazELMAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWEwHhcNMjIxMjEzMDMwMjE1WhcNMjcxMjEyMDMwMjE1WjB7MRQwEgYDVQQKEwtHb29nbGUgSW5jLjEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEPMA0GA1UEAxMGR29vZ2xlMRgwFgYDVQQLEw9Hb29nbGUgRm9yIFdvcmsxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmde8M/QpBsKLDxT0NHsLzUHzXewpSKxdR+L/8r01z/vglWbBBRHar9sHPXzFUgdzSoKcaNGk9+TKDusEa+tGn1sbC4M7EV2kY14sM50P/ifkR0OWYF0ld/Od61aIUpELvm6rirbcbEziEisEMcv1zBoQczJsGZSHiy20hlzfcCTKJc4Y0HQgCBlxJvulQr6rgjKCL0SOl73mtJsFbGZMv/oWOZCt03S5/wTJfKnzroY95918uEv0UJhTSi+Lpw++DK7QFI0VFJgdLYeMu07suQ5w2ts5LZszmnBC5yBnHBtrM0Doixi/eZpOvANclZbwG4DSePIqL8phigi5Pp5HvQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBd6TMCyW0jywuxyenIVunXnx3Vv1JkXNvtFUGknFm430KyWi+FvhhBpQkzY6Tr2APZKjhkkZCITtzMa3odYDjFYFzcFaL5bYlAvvF5fcGziSRLDkvABelvCClsJpKRgVgvb6PtNa97whEAQef0HFM66k1Y4Qoq5GPAIUdcQzGsIpFcUCm9aQHsCTzvPy30ZSbQRwlrWp3rk15lAEdVuKwzLtWv3DvIAVIsNCxociNZjKEFvOY08Gnx5GOmPbBLabfPgPod8lgwFAEawT9w1X32Q9srBp7HVAnf6wyv74tgq0z5Y26Mzqn9xm7erXg2+RUof4QpMrN7L8hWXs9ZuGyJ"
$IssuerURI = "https://accounts.google.com/o/saml2?idpid=C012f42vy"
$LogOffUri = "https://accounts.google.com/logout"
$PreferredAuthenticationProtocol = "SAMLP"

#Set-MsolDomainAuthentication -DomainName $DomainName -FederationBrandName $FederationBrandName -Authentication $Authentication -PassiveLogOnUri $PassiveLogOnUrl -ActiveLogOnUri $ActiveLogOnUri -SigningCertificate $SigningCertificate -IssuerUri $IssuerURI -LogOffUri $LogOffUri -PreferredAuthenticationProtocol $PreferredAuthenticationProtocol

Get-MSolDomainFederationSettings -DomainName 'hickenair.com' | Select-Object -Property DomainName, FederationBrandName, Authentication, PassiveLogOnUri, ActiveLogOnUri, SigningCertificate, IssuerUri, LogOffUri, PreferredAuthenticationProtocol