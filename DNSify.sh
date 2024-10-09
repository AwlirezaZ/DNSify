#!/bin/bash

dns_servers=("8.8.8.8" "78.157.42.100" "10.202.10.11" "178.22.122.100" "1.1.1.1" "78.157.42.101" "185.51.200.2" "10.202.10.102" "10.202.10.202" "185.228.169.175")  # Replace with your list of DNS servers


original_dns=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')


test_dns() {
    local dns=$1
    echo "nameserver $dns" | sudo tee /etc/resolv.conf > /dev/null
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://www.spotify.com")
    if [[ $response -ge 400 ]]; then
        echo "HTTP request failed. Spotify might be unreachable. Status Code: $response"
        return 1
    else
        echo "SPOTIFY IS CONNECTED with Status Code: $response"
        return 0
    fi
}
cleanup() {
    echo "Resetting DNS to default..."
    echo "nameserver $original_dns" | sudo tee /etc/resolv.conf > /dev/null
    echo "DNS reset to default."
}
trap cleanup EXIT
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
echo "Press Ctrl+C or close the terminal to stop the script and reset DNS to default."
while true; do
    sleep 10 
done
