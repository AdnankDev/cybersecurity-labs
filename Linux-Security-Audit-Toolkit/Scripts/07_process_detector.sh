#!/bin/bash

# ==========================================
# Suspicious Process Detector Script
# ==========================================

# Clear the screen
clear

echo "=========================================="
echo "     SUSPICIOUS PROCESS DETECTOR        "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

# Define output file
REPORT_FILE="process_report.txt"
CPU_THRESHOLD=70

echo ""
echo "CPU Usage Threshold: ${CPU_THRESHOLD}%"
echo "Report File: $REPORT_FILE"
echo "=========================================="
echo ""

# Initialize report file with header
echo "==========================================" > "$REPORT_FILE"
echo "     PROCESS MONITORING REPORT          " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "Date: $(date)" >> "$REPORT_FILE"
echo "CPU Threshold: ${CPU_THRESHOLD}%" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. Display top 5 processes using highest CPU
echo "--- Top 5 Processes by CPU Usage ---"
echo "" >> "$REPORT_FILE"
echo "--- Top 5 Processes by CPU Usage ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

#Save and display top 5 processes 
ps aux --sort=-%cpu | head -6 | tee -a "$REPORT_FILE"

echo ""

#extract highest cpu usage value
top_cpu=$(ps aux --sort=-%cpu | awk 'NR==2 {print $3}' | cut -d. -f1)


#handle empty value
if [ -z "$top_cpu" ]; then
	top_cpu=0
fi
echo "" >> "$REPORT_FILE"
echo "Highest CPU Usage: ${top_cpu}%" >> "$REPORT_FILE"
echo ""  >> "$REPORT_FILE"

#Display alert if CPU usage  > 70%
echo "============================"
echo "        ALERT STATUS        "
echo "============================"

if [ "$top_cpu" -gt "$CPU_THRESHOLD" ]; then
    echo ""
    echo "🚨 CRITICAL ALERT: High CPU Usage Detected!"
    echo "   Top Process CPU: ${top_cpu}%"
    echo "   Threshold: ${CPU_THRESHOLD}%"
    echo "   Action Required: Investigate suspicious processes!"
    echo ""
    
    # Save alert to report
    echo "==========================================" >> "$REPORT_FILE"
    echo "🚨 ALERT: High CPU Usage Detected!" >> "$REPORT_FILE"
    echo "Top Process CPU: ${top_cpu}%" >> "$REPORT_FILE"
    echo "Threshold: ${CPU_THRESHOLD}%" >> "$REPORT_FILE"
    echo "Action Required: Investigate suspicious processes!" >> "$REPORT_FILE"
    echo "==========================================" >> "$REPORT_FILE"
 else
    echo ""
    echo "✅ NORMAL: CPU usage within acceptable limits"
    echo "   Top Process CPU: ${top_cpu}%"
    echo "   Threshold: ${CPU_THRESHOLD}%"
    echo ""
    
    # Save status to report
    echo "==========================================" >> "$REPORT_FILE"
    echo "✅ STATUS: Normal CPU Usage" >> "$REPORT_FILE"
    echo "Top Process CPU: ${top_cpu}%" >> "$REPORT_FILE"
    echo "Threshold: ${CPU_THRESHOLD}%" >> "$REPORT_FILE"
    echo "==========================================" >> "$REPORT_FILE"
fi

#Show File Size 
if [ -f "$REPORT_FILE" ]; then 
	file_size=$(wc -c < "$REPORT_FILE")
	echo "Report Size: $file_size bytes"
fi
