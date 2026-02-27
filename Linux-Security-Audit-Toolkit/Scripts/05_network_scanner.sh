#!/bin/bash

# ==========================================
# Network Availability Scanner Script
# ==========================================

# Clear the screen
clear

echo "=========================================="
echo "     NETWORK AVAILABILITY SCANNER       "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

# Option: Choose between hardcoded or user input
echo ""
echo "Select IP Input Method:"
echo "1 = Use Hardcoded IPs"
echo "2 = Enter Custom IPs"
read -p "Enter option (1 or 2): " choice

#Initialize an array to store IPs
declare -a ip_list

if [ "$choice" -eq 1 ]; then
	#hardcoded ip addresses 
	ip_list=("8.8.8.8" "1.1.1.1" "192.168.18.1" "192.168.18.241" "127.0.0.1")
	echo "Using Hardcoded IP Addresses..."
else 
	#user input ip addresses
	echo ""
	echo "Enter 5 IP addresses to scan:"
	for i in {1..5}; do
		read -p "IP Address $i: " ip
		ip_list+=("$ip")
	done
fi


echo ""
echo "=========================================="
echo "           SCANNING NETWORK             "
echo "=========================================="
echo ""

#Initialize counter for active hosts
active_count=0
total_count=${#ip_list[@]}

#Loop thorugh each IP address
for ip in "${ip_list[@]}"; do
	if ping -c 1 -W 1 "$ip" >/dev/null 2>&1; then
	echo "Active : ${ip}"
	((active_count++))
	else
	#host is inactive (do nothing -hide output)
	:
	fi
done



# Display summary
echo ""
echo "=========================================="
echo "                SUMMARY                   "
echo "=========================================="
echo "Total Host Scanned: ${total_count}"
echo "Acitve Hosts: ${active_count}"
echo "Inactive Hosts: $((total_count - active_count))"
echo "==============================================="

# Warning if no hosts are active
if [ ${active_count} -eq 0 ]; then
	echo "Warning: No active hosts found!"
	echo "Check your network connection or IP addresses."
fi
echo "=============================="
