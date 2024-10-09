Write-Host "DALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM!!!!!!!!!!!!!"
# List of DNS servers
$dnsServers = @("8.8.8.8", "78.157.42.100", "10.202.10.11", "178.22.122.100", "1.1.1.1", "78.157.42.101", "78.157.42.100", "185.51.200.2", "10.202.10.102", "10.202.10.202", "185.228.169.175")  # Replace with your list of DNS servers

# Get the active network adapter (the one connected to the internet)
$activeAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1

if ($null -eq $activeAdapter) {
    Write-Host "No active network adapter found!" -ForegroundColor Red
    exit
}

$adapterName = $activeAdapter.Name
Write-Host "Detected active adapter: $adapterName"

# Function to check DNS availability
function Test-DNS {
    param([string]$dns)

    # Set temporary DNS for the active adapter
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $dns
    # Test connection to Spotify using curl.exe
    try {
        $response = & curl.exe -s -o NUL -w "%{http_code}" "https://www.spotify.com"

        # Check if the response is a success (less than 400)
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

# Store the current DNS settings to restore them later
$currentDNS = Get-DnsClientServerAddress -InterfaceAlias $adapterName | Select-Object -ExpandProperty ServerAddresses

# Main program
try {
    # Loop through DNS servers and check availability
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

    # Main program keeps running until the user closes it
    Write-Host "Press Ctrl+C or close the window to stop the script and reset DNS to default."
    while ($true) {
        Start-Sleep -Seconds 10  # Keeps the script running. Adjust as needed.
    }
} finally {
    # This block executes when the script exits, resetting DNS to the original state
    Write-Host "Resetting DNS to default..."
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses $currentDNS
    Write-Host "DNS reset to default."
}
