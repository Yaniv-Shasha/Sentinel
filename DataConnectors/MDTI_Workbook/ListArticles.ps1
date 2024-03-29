using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$clientId = $env:clientId
$tenantId = $env:tenantId
$clientSecret = $env:clientSecret

# Construct URI
$uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

# Construct Body
$body = @{
    client_id     = $clientId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Get OAuth 2.0 Token
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing

# Access Token
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token

#$headers = $Request.Headers
#$hostname = $Request.query["hostname"]



# graphAPI Get users properties
$apiUrl = "https://graph.microsoft.com/beta/security/threatIntelligence/articles?$count=true"
$apiUrl
$Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $Token"} -Uri $apiUrl -Method Get -ContentType aplication/json -UseBasicParsing
$obj = $Data.value | convertTo-Json
$obj




# Return Write-OMSLogfile response to output binding
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    Body = $obj

})
