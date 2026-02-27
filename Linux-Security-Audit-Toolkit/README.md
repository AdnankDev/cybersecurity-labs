# 🛡️ Linux Security Audit Toolkit

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?style=for-the-badge\&logo=gnubash\&logoColor=white)
![Linux](https://img.shields.io/badge/Platform-Linux-FCC624?style=for-the-badge\&logo=linux\&logoColor=black)
![Security](https://img.shields.io/badge/Focus-Cybersecurity-red?style=for-the-badge)
![License](https://img.shields.io/badge/License-Educational-blue?style=for-the-badge)

A collection of **8 professional Bash scripts** designed to automate system auditing, network reconnaissance, and security monitoring on Linux systems.

---

## 📌 About This Project

This toolkit was developed as part of a **Linux Security & Bash Scripting Lab Series**.

It demonstrates practical skills in:

* 🖥️ Linux system auditing
* 📊 Resource monitoring
* 🔍 Network reconnaissance
* 🛑 Firewall inspection
* 📂 Log analysis
* ⚙️ Process monitoring

This project reflects hands-on cybersecurity lab experience using real Linux environments such as **Kali Linux**, **Ubuntu**, and **Debian**.

---

## 🚀 Toolkit Scripts

| #   | Script                     | Description                                             |
| --- | -------------------------- | ------------------------------------------------------- |
| 1️⃣ | `01_system_health.sh`      | Displays CPU, RAM, disk usage, uptime, and active users |
| 2️⃣ | `02_user_checker.sh`       | Checks whether a user exists in `/etc/passwd`           |
| 3️⃣ | `03_log_monitor.sh`        | Detects failed login attempts from auth logs            |
| 4️⃣ | `04_permission_auditor.sh` | Finds files with suspicious or risky permissions        |
| 5️⃣ | `05_network_scanner.sh`    | Pings multiple hosts to check availability              |
| 6️⃣ | `06_port_scanner.sh`       | Automates Nmap scanning (`-F`, `-sV`)                   |
| 7️⃣ | `07_process_detector.sh`   | Detects high CPU-consuming processes                    |
| 8️⃣ | `08_firewall_checker.sh`   | Audits iptables rules and policies                      |

---

## 🛠️ Requirements

* Linux OS (Kali / Ubuntu / Debian)
* `nmap`
* `iptables`
* Bash shell
* Sudo privileges (for some scripts)

Install dependencies:

```bash
sudo apt update
sudo apt install nmap iptables
```

---

## 📥 Installation

```bash
# Clone repository
git clone https://github.com/AdnankDev/Linux-Security-Audit-Toolkit.git

# Navigate into project
cd Linux-Security-Audit-Toolkit/scripts

# Make scripts executable
chmod +x *.sh
```

---

## ▶ Usage Examples

### Run User Checker

```bash
./02_user_checker.sh
```

### Run Port Scanner (Requires Root)

```bash
sudo ./06_port_scanner.sh
```

---

## 📊 Project Structure

```
Linux-Security-Audit-Toolkit/
│
├── scripts/
│   ├── 01_system_health.sh
│   ├── 02_user_checker.sh
│   ├── 03_log_monitor.sh
│   ├── 04_permission_auditor.sh
│   ├── 05_network_scanner.sh
│   ├── 06_port_scanner.sh
│   ├── 07_process_detector.sh
│   └── 08_firewall_checker.sh
│
└── README.md
```

---

## 🔐 Ethical Use Notice

This toolkit is intended strictly for:

* ✅ Educational purposes
* ✅ Personal lab environments
* ✅ Authorized security auditing

Do **NOT**:

* 🚫 Scan networks without permission
* 🚫 Test production systems
* 🚫 Use for malicious purposes

---

## 👨‍💻 Author

**Adnan Khan**
Cybersecurity Student | Linux Enthusiast | Security Lab Practitioner

---


