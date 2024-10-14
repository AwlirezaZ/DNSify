
$dnsServers = @("8.8.8.8", "78.157.42.100", "10.202.10.11", "178.22.122.100", "1.1.1.1", "78.157.42.101", "78.157.42.100", "185.51.200.2", "10.202.10.102", "10.202.10.202", "185.228.169.175")  # Replace with your list of DNS servers

$activeAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1

if ($null -eq $activeAdapter) {
    Write-Host "No active network adapter found!" -ForegroundColor Red
    exit
}

$adapterName = $activeAdapter.Name
Write-Host "Detected active adapter: $adapterName"
function Test-DNS {
    param([string]$dns)
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $dns
    try {
        $response = & curl.exe -s -o NUL -w "%{http_code}" "https://www.spotify.com"
        if ($response -ge 400) {
            Write-Host "HTTP request failed. Spotify might be unreachable. Status Code: $response"
            return $false
        } else {
            Write-Host "SPOTIFY IS CONNECTED with Status Code: $response"
            return $true
        }
    } catch {
        Write-Host "Error during HTTP request: $_"
        return $false
    }
}
$currentDNS = Get-DnsClientServerAddress -InterfaceAlias $adapterName | Select-Object -ExpandProperty ServerAddresses
try {
    $dnsFound = $false
    foreach ($dns in $dnsServers) {
        Write-Host "Checking DNS: $dns"
        if (Test-DNS $dns) {
            Write-Host "$dns works! Setting as your DNS."
            Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $dns
            $dnsFound = $true
            break
        } else {
            Write-Host "$dns failed."
        }
    }
    if (-not $dnsFound) {
        Write-Host "No working DNS found. Exiting the script."
        exit
    }
    Write-Host "Press Ctrl+C or close the window to stop the script and reset DNS to default."
    while ($true) {
        Start-Sleep -Seconds 10
    }
} finally {
    Write-Host "Resetting DNS to default..."
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $currentDNS
    Write-Host "DNS reset to default."
}
