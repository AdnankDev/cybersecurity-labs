# 🛡️ Linux Security Audit Toolkit

A collection of 8 Bash scripts designed to automate system auditing, network reconnaissance, and security monitoring on Linux systems.

## 📋 Project Overview
This toolkit was developed as part of a comprehensive Linux Security & Bash Scripting lab series. It demonstrates proficiency in shell scripting, system administration, and security auditing.

## 🚀 Features
| # | Script | Function |
|---|--------|----------|
| 1 | `system_health.sh` | Displays CPU, RAM, Disk, and User info |
| 2 | `user_checker.sh` | Verifies if a user exists in `/etc/passwd` |
| 3 | `log_monitor.sh` | Detects failed login attempts in auth.log |
| 4 | `permission_auditor.sh` | Finds files with restrictive permissions |
| 5 | `network_scanner.sh` | Pings multiple hosts to check availability |
| 6 | `port_scanner.sh` | Automates Nmap scans (-F, -sV) |
| 7 | `process_detector.sh` | Identifies high CPU processes & alerts |
| 8 | `firewall_checker.sh` | Audits iptables rules and policies |

## 🛠️ Prerequisites
- Linux OS (Kali, Ubuntu, Debian)
- `nmap` installed (`sudo apt install nmap`)
- `iptables` installed
- Root/Sudo privileges for certain scripts

## 📥 Installation
```bash
# Clone the repository
git clone https://github.com/AdnankDev/Linux-Security-Audit-Toolkit.git

# Navigate to directory
cd Linux-Security-Audit-Toolkit/scripts

# Make all scripts executable
chmod +x *.sh


## 📖 Usage Examples

**Run User Checker:**
```bash
cd scripts
./02_user_checker.sh



## Run Port Scanner (Requires Sudo):

**Run User Checker:**
```bash
cd scripts
sudo ./06_port_scanner.sh


## ⚠️ Ethical Disclaimer

These tools are for **educational purposes** and **authorized security auditing** only.

- 🚫 Do not scan networks you do not own.
- 🚫 Do not use on production systems without permission.
- ⚖️ The author is not responsible for misuse of these scripts.
