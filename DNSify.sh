#!/bin/bash

echo "DALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM!!!!!!!!!!!!!"
# List of DNS servers
dns_servers=("8.8.8.8" "78.157.42.100" "10.202.10.11" "178.22.122.100" "1.1.1.1" "78.157.42.101" "185.51.200.2" "10.202.10.102" "10.202.10.202" "185.228.169.175")  # Replace with your list of DNS servers

# Get the current DNS settings
original_dns=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')

# Function to check DNS availability
test_dns() {
    local dns=$1
    # Set temporary DNS for the system
    echo "nameserver $dns" | sudo tee /etc/resolv.conf > /dev/null

    # Test connection to Spotify
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://www.spotify.com")
    
    if [[ $response -ge 400 ]]; then
        echo "HTTP request failed. Spotify might be unreachable. Status Code: $response"
        return 1
    else
        echo "SPOTIFY IS CONNECTED with Status Code: $response"
        return 0
    fi
}

# Cleanup function to reset DNS to default
cleanup() {
    echo "Resetting DNS to default..."
    echo "nameserver $original_dns" | sudo tee /etc/resolv.conf > /dev/null
    echo "DNS reset to default."
}

# Trap signals to ensure cleanup on exit
trap cleanup EXIT

# Loop through DNS servers and check availability
dns_found=false
for dns in "${dns_servers[@]}"; do
    echo "Checking DNS: $dns"
    if test_dns "$dns"; then
        echo "$dns works! Setting as your DNS."
        dns_found=true
        break
    else
        echo "$dns failed."
    fi
done

if ! $dns_found; then
    echo "No working DNS found. Exiting the script."
    exit 1
fi

# Main program keeps running until the user closes it
echo "Press Ctrl+C or close the terminal to stop the script and reset DNS to default."
while true; do
    sleep 10  # Keeps the script running. Adjust as needed.
done
