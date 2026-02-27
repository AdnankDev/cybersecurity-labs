#!/bin/bash

# Clear the screen
clear

echo "=========================================="
echo "       LOG MONITORING SCRIPT            "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

# Define the log file path
LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="failed_logins.txt"

# FIXED: Removed the check for OUTPUT_FILE (since tee will create it)
# FIXED: Standardized the brackets
if [ ! -f "$LOG_FILE" ]; then
    echo "❌ Error: Log File $LOG_FILE not found!"
    echo "   (This script works on Debian/Ubuntu/Kali systems)"
    exit 1    
fi

echo ""
echo "=========== Searching For Failed Login Attempts ============="
echo ""


grep "Failed password" "$LOG_FILE" | tail -n 5 | tee "$OUTPUT_FILE"

echo ""
echo "============================="
echo "Result Saved to $OUTPUT_FILE"
echo "============================="

