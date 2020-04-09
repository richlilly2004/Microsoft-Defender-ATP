##Package Information
$vendor = Read-Host -Prompt 'Input Vendor name'
$PackageName = Read-Host -Prompt 'Input Package name'
$PackageVersion = Read-Host -Prompt 'Input Version'

##Test fields
#$vendor = "cisco"
#$PackageName = "anyconnect_secure_mobility_client"
#$PackageVersion = "4.8.0204"

##Get Bearer token
$tenantId = 'XXXXX' # Paste your own tenant ID here
$appId = 'XXXXX' # Paste your own app ID here
$appSecret = 'XXXXX' # Paste your own app secret here

$resourceAppIdUri = 'https://api.securitycenter.windows.com'
$oAuthUri = "https://login.windows.net/$TenantId/oauth2/token"
$body = [Ordered] @{
    resource = "$resourceAppIdUri"
    client_id = "$appId"
    client_secret = "$appSecret"
    grant_type = 'client_credentials'
}
$response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
$aadToken = $response.access_token

##Get MDATP machine info
$query = "DeviceTvmSoftwareInventoryVulnerabilities | where SoftwareVendor == '$($vendor)' | where SoftwareName == '$($PackageName)' | where SoftwareVersion != '$($PackageVersion)' | distinct DeviceName"

$url = "https://api.securitycenter.windows.com/api/advancedqueries/run"
$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $aadToken" 
}
$body = ConvertTo-Json -InputObject @{ 'Query' = $query }
$webResponse = Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body $body -ErrorAction Stop
$response =  $webResponse | ConvertFrom-Json
$results = $response.Results
$schema = $response.Schema
$Machines = $results

##Create AAD group
$targetgroup = New-AzureADGroup -DisplayName "Intune Remediation - $vendor $PackageName $PackageVersion" -Description "AAD group created automatically for package remediation" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet"

##Add machines in scope to group
foreach($Machine in $Machines)
{
$name = $Machine.DeviceName.Split(".")[0]
$Machine2 = Get-AzureADDevice -SearchString $name | where {$_.IsManaged -eq $true}
Add-AzureADGroupMember -ObjectId $targetgroup.ObjectId -RefObjectId $Machine2.ObjectId
Write-Output "$name added to group"
}