while ($true) {
    Write-Host "Scanning for potential communication over local port 1900 UDP to remote address on port 49152."
    $endpoints = Get-NetUDPEndpoint -LocalPort 1900 | Where-Object { $_.RemotePort -eq 49152 }
    if ($endpoints) {
        Write-Host "`n`n>>> Potential communication detected over local port 1900 UDP to remote address on port 49152. <<<"
        $endpoints | Select-Object OwningProcess, LocalAddress, LocalPort, RemoteAddress, RemotePort | Format-Table -AutoSize
        Write-Host "`n`n"
    }
    Start-Sleep -Seconds 1
}
