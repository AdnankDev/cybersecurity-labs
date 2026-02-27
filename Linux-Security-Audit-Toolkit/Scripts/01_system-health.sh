#!/bin/bash

# ==========================================
# System Health Report Script
# ==========================================

# Clear the screen for a clean look
clear

# Print a header
echo "=========================================="
echo "       SYSTEM HEALTH REPORT              "
echo "=========================================="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "=========================================="

# 1. Display CPU Info
echo ""
echo "--- CPU INFORMATION ---"
# lscpu shows CPU architecture details
# We use grep to filter just the Model Name for a cleaner look
lscpu | grep "Model name"
echo "Core(s) per processor: $(lscpu | grep 'Core(s) per socket' | awk '{print $4}')"

# 2. Display RAM Usage
echo ""
echo "--- RAM USAGE ---"
# -h flag means 'human-readable' (shows GB/MB instead of bytes)
free -h

# 3. Display Disk Usage
echo ""
echo "--- DISK USAGE ---"
# -h flag means 'human-readable'
# We filter to show only the main disk (usually mounted on '/')
df -h /

# 4. Show Logged-in Users
echo ""
echo "--- LOGGED IN USERS ---"
# 'who' command lists currently logged in users
who

echo ""
echo "=========================================="
echo "       Report Generated Successfully     "
echo "=========================================="
