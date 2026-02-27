#!/bin/bash

# ==========================================
# Firewall Rule Checker Script
# ==========================================

# Clear the screen
clear

echo "=========================================="
echo "       FIREWALL RULE CHECKER            "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

# Define output file
REPORT_FILE="firewall_report.txt"

echo ""
echo "Report File: $REPORT_FILE"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Error: This script must be run as root!"
    echo "   Please run with: sudo ./firewall_checker.sh"
    exit 1
fi

# Check if iptables is installed
if ! command -v iptables &> /dev/null; then
    echo "❌ Error: iptables is not installed!"
    echo "   Install with: sudo apt install iptables"
    exit 1
fi

# Initialize report file with header
echo "==========================================" > "$REPORT_FILE"
echo "       FIREWALL RULE REPORT             " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "Date: $(date)" >> "$REPORT_FILE"
echo "Hostname: $(hostname)" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. Display current iptables rules
echo "--- Current iptables Rules ---"
echo "" >> "$REPORT_FILE"
echo "--- Current iptables Rules ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Display all rules with line numbers and verbose output
iptables -L -n -v --line-numbers | tee -a "$REPORT_FILE"

echo ""

# 2. Count number of INPUT rules
echo "" >> "$REPORT_FILE"
echo "--- Rule Statistics ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "--- Counting INPUT Rules ---"

# Count INPUT chain rules (exclude header lines)
# -L INPUT: List INPUT chain
# -n: Numeric output (no DNS resolution)
# grep -c: Count matching lines
# We exclude lines that start with "Chain" or "target" (headers)
input_rules=$(iptables -L INPUT -n --line-numbers 2>/dev/null | grep -E '^[0-9]+' | wc -l)

echo "INPUT Chain Rules: $input_rules"
echo "INPUT Chain Rules: $input_rules" >> "$REPORT_FILE"

# 3. Count other chain rules
forward_rules=$(iptables -L FORWARD -n --line-numbers 2>/dev/null | grep -E '^[0-9]+' | wc -l)
output_rules=$(iptables -L OUTPUT -n --line-numbers 2>/dev/null | grep -E '^[0-9]+' | wc -l)

echo "FORWARD Chain Rules: $forward_rules"
echo "FORWARD Chain Rules: $forward_rules" >> "$REPORT_FILE"

echo "OUTPUT Chain Rules: $output_rules"
echo "OUTPUT Chain Rules: $output_rules" >> "$REPORT_FILE"

# 4. Display total count
total_rules=$((input_rules + forward_rules + output_rules))

echo ""
echo "=========================================="
echo "                SUMMARY                   "
echo "=========================================="
echo "Total Firewall Rules: $total_rules"
echo "=========================================="

# Save summary to report
echo "" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "                SUMMARY                   " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "Total Firewall Rules: $total_rules" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

# 5. Display policy information
echo ""
echo "--- Chain Policies ---"
echo "" >> "$REPORT_FILE"
echo "--- Chain Policies ---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Extract default policies
input_policy=$(iptables -L INPUT -n 2>/dev/null | head -1 | awk '{print $4}' | tr -d ')')
forward_policy=$(iptables -L FORWARD -n 2>/dev/null | head -1 | awk '{print $4}' | tr -d ')')
output_policy=$(iptables -L OUTPUT -n 2>/dev/null | head -1 | awk '{print $4}' | tr -d ')')

echo "INPUT Policy: $input_policy"
echo "FORWARD Policy: $forward_policy"
echo "OUTPUT Policy: $output_policy"

echo "INPUT Policy: $input_policy" >> "$REPORT_FILE"
echo "FORWARD Policy: $forward_policy" >> "$REPORT_FILE"
echo "OUTPUT Policy: $output_policy" >> "$REPORT_FILE"

# 6. Security warnings
echo ""
echo "=========================================="
echo "           SECURITY ANALYSIS            "
echo "=========================================="
echo "" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "           SECURITY ANALYSIS            " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check for risky configurations
if [ "$input_policy" = "ACCEPT" ]; then
    echo "⚠️  WARNING: INPUT chain policy is ACCEPT!"
    echo "   All incoming traffic is allowed by default."
    echo "   Consider setting policy to DROP for better security."
    echo ""
    echo "⚠️  WARNING: INPUT chain policy is ACCEPT!" >> "$REPORT_FILE"
    echo "   All incoming traffic is allowed by default." >> "$REPORT_FILE"
    echo "   Consider setting policy to DROP for better security." >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
else
    echo "✅ INPUT chain policy is $input_policy (More Secure)"
    echo "✅ INPUT chain policy is $input_policy (More Secure)" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
fi

if [ "$input_rules" -eq 0 ]; then
    echo "⚠️  WARNING: No INPUT rules configured!"
    echo "   Firewall may not be providing protection."
    echo ""
    echo "⚠️  WARNING: No INPUT rules configured!" >> "$REPORT_FILE"
    echo "   Firewall may not be providing protection." >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
else
    echo "✅ INPUT chain has $input_rules rule(s) configured"
    echo "✅ INPUT chain has $input_rules rule(s) configured" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
fi

# Add footer to report
echo "==========================================" >> "$REPORT_FILE"
echo "           SCAN COMPLETE                " >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

# Display final summary
echo "=========================================="
echo "                SUMMARY                   "
echo "=========================================="
echo "✅ Scan completed successfully!"
echo "📄 Report saved to: $REPORT_FILE"
echo "=========================================="

# Show file size
if [ -f "$REPORT_FILE" ]; then
    file_size=$(wc -c < "$REPORT_FILE")
    echo "📊 Report size: $file_size bytes"
fi
echo "=========================================="
