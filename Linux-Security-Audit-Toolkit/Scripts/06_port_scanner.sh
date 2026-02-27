#!/bin/bash

# ==========================================
# Port Scan Automation (Mini Recon Tool)
# ==========================================

# Clear the screen
clear

echo "=========================================="
echo "     PORT SCAN AUTOMATION TOOL          "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

#Take target ip from user
read -p "Enter target IP address: " target_ip
#validate ip
if [ -z "$target_ip" ]; then
	echo ""
	echo "Error: No IP Address Provided"
	exit 1
fi

#define the output file

REPORT_FILE="scan_report.txt"

echo ""
echo "=========================================="
echo "             STARTING SCAN                "
echo "=========================================="
echo "Target: $target_ip"
echo "Report File: $REPORT_FILE"
echo "=========================================="
echo ""

# Check if nmap is installed
if ! command -v nmap &> /dev/null; then
    echo "❌ Error: nmap is not installed!"
    echo "   Install with: sudo apt install nmap"
    exit 1
fi

#Initialize report file with header
echo "============================================" > "$REPORT_FILE"
echo "     NMAP SCAN REPORT                   " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "Date: $(date)" >> "$REPORT_FILE"
echo "Target: $target_ip" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

#Run nmap -F (Fast Scan)
echo "[1/2] Running Fast Scan (nmap -F)...."
echo "" >> "$REPORT_FILE"
echo "--- FAST SCAN RESULTS (nmap -F) ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

#Run scan and display progress
nmap -F "$target_ip" | tee -a "$REPORT_FILE"

echo ""

#Run nmap -sV (Version Detection)
echo "[2/2] Running Version Scan (nmap -sV)...."
echo "" >> "$REPORT_FILE"
echo "--- VERSION SCAN RESULTS (nmap -sV) ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

#Run scan and display progess
nmap -sV "$target_ip" | tee -a "$REPORT_FILE"

echo ""

# Add footer to report
echo "" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "           SCAN COMPLETE                " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

# Display summary
echo ""
echo "=========================================="
echo "                SUMMARY                   "
echo "=========================================="
echo "✅ Scan completed successfully!"
echo "📄 Report saved to: $REPORT_FILE"
echo "=========================================="

#show file size
if [ -f "$REPORT_FILE" ]; then
	file_size=$(wc -c < "$REPORT_FILE")
	echo "Report size: $file_size bytes"
fi
echo "========================================"
