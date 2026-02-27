#!/bin/bash

# ==========================================
# File Permission Auditor Script
# ==========================================

# Clear the screen
clear

echo "=========================================="
echo "       FILE PERMISSION AUDITOR          "
echo "=========================================="
echo "Date: $(date)"
echo "=========================================="

#Take directory name as a input
read -p "Enter directory path to audit:  " dir_path
#check if directory exists
if [ ! -d "$dir_path" ]; then
	echo ""
	echo "Error: The directory $dir_path does not exists:"
	exit 1
fi

echo "============================"
echo "    Scanning Directory $dir_path     "
echo "============================"

#Initialize counters
no_read_count=0
no_write_count=0

#List file with no read permission
echo ""
echo "---    Files with NO READ Permissions     ---"
find "$dir_path" -type f ! -readable 2>/dev/null
no_read_count=$(find "$dir_path" -type f ! -readable 2>/dev/null | wc -l)

if [ "$no_read_count" -eq 0 ]; then
	echo ""
	echo "All Files are readable"
else 
	echo " Found $no_read_count files with no read permissions"
fi

#list file with no write permissions
echo ""
echo "---    Files with NO Write Permissions   ---"
find "$dir_path" -type -f ! -writable 2>/dev/null
no_write_count=$(find $dir_path -type f ! -writable 2>/dev/null | wc -l)

if [ "$no_write_count" -eq 0 ]; then
	echo "All Files are writable"
else 
	echo "Found $no_write_count files with no write permissions"
fi

#Display summary warning
echo ""
echo "=========================================="
echo "                SUMMARY                   "
echo "=========================================="
total_issues=$((no_read_count + no_write_count))

if [ "$total_issues" -gt 0 ]; then
    echo "⚠️  WARNING: Total permission issues found: $total_issues"
    echo "   Review the files above for potential access problems."
else
    echo "✅ No permission issues detected!"
fi
echo "=========================================="
