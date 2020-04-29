$app = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -match "Symantec Endpoint Protection" 
    
}
$app.Uninstall()
