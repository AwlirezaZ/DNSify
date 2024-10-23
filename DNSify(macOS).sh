#!/bin/bash

dns_servers=("8.8.8.8" "78.157.42.100" "10.202.10.11" "178.22.122.100" "1.1.1.1" "78.157.42.101" "185.51.200.2" "10.202.10.102" "10.202.10.202" "185.228.169.175")

interface=$(networksetup -listallnetworkservices | tail -n +2 | head -n 1)

original_dns=$(networksetup -getdnsservers "$interface")
if [[ "$original_dns" == "There aren't any DNS Servers set on"* ]]; then
    echo "No original DNS servers found. Using empty list."
    original_dns=""
fi

test_dns() {
    local dns=$1
    echo "Setting DNS to $dns..."
    networksetup -setdnsservers "$interface" "$dns"
    sleep 2
    response=$(curl -s -m 10 -o /dev/null -w "%{http_code}" "https://www.spotify.com" || echo "timeout")
    if [[ $response == "timeout" || $response -ge 400 ]]; then
        echo "HTTP request failed. Spotify might be unreachable. Status Code: $response"
        return 1
    else
        echo "SPOTIFY IS CONNECTED with Status Code: $response"
        return 0
    fi
}

cleanup() {
    echo "Resetting DNS to default..."
    if [ -z "$original_dns" ]; then
        networksetup -setdnsservers "$interface" "empty"
    else
        networksetup -setdnsservers "$interface" $original_dns
    fi
    echo "DNS reset to default."
}

trap cleanup EXIT INT TERM

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

echo "Press Ctrl+C to stop the script and reset DNS to default."
while true; do
    if ! test_dns "${dns_servers[0]}"; then
        echo "Connection lost. Trying other DNS servers..."
        dns_found=false
        for dns in "${dns_servers[@]}"; do
            if test_dns "$dns"; then
                dns_found=true
                break
            fi
        done
        if ! $dns_found; then
            echo "No working DNS found. Exiting."
            exit 1
        fi
    fi
    sleep 30
done