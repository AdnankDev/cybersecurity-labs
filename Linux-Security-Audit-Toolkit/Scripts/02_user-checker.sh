#!/bin/sh

# ==========================================
#      User Account Checker Script 
#===========================================

#clear the screen 
clear
echo "======================================="
echo "            User Account Checker      "
echo "======================================="
#1 Taking username as a input
read -p "Enter user name to check: " username
if grep -q "^${username}:" /etc/passwd; then
  echo ""
  echo "Success: Username $username exists on this system "
  echo ""
  echo "====================================="
  echo "        User Details                 "
  grep "^${username}:" /etc/passwd
else
  echo ""
  echo "Error: User $username Does not exists"
  
fi
