````markdown
# 🔐 Volume Shadow Copy Service (VSS) – Hands-On Security Lab

## 📌 Lab Overview
This lab demonstrates how **Volume Shadow Copy Service (VSS)** can be abused by attackers to access historical versions of files, and how ransomware commonly deletes shadow copies to prevent recovery.

Performed in a **Windows 10 VM**, using **real-world attacker techniques** (not GUI restore points).

---

## 🎯 Learning Objectives
- Understand VSS functionality
- Create shadow copies manually
- Access previous file versions using `GLOBALROOT`
- Simulate ransomware behavior
- Map techniques to MITRE ATT&CK

---

## 🧱 Lab Environment
- OS: Windows 10 (VM)  
- Access: Local Administrator  
- Tools: `wmic`, `vssadmin`, `mklink`, `cmd.exe`

> ⚠️ Conducted in an isolated virtual environment.

---

## 🧠 Key Concept
> **Restore Points ≠ VSS**  
> Attackers bypass GUI restore points and access **Volume Shadow Copies directly**.

---

## 🧪 Lab Steps

### 1️⃣ Create a Test File
```cmd
echo ORIGINAL-DATA > C:\vss_lab.txt
type C:\vss_lab.txt
````

![Create file](images/create-file.png)

---

### 2️⃣ Create a Shadow Copy

```cmd
wmic shadowcopy call create Volume='C:\'
```

Expected output:

```
Method execution successful.
ShadowID = "{GUID}"
```

![Shadow created](images/step2-shadow-created.png)

---

### 3️⃣ Verify Shadow Copy Exists

```cmd
vssadmin list shadows
```

Look for:

```
\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopyX
```

![Shadow listed](images/step3-list-shadows.jpg)

---

### 4️⃣ Modify the Original File

```cmd
echo MODIFIED-DATA > C:\vss_lab.txt
type C:\vss_lab.txt
```

![File modified](images/step4-file-modified.png)

---

### 5️⃣ Mount the Shadow Copy

> ⚠️ Must be run in **CMD**, not PowerShell

```cmd
mklink /d C:\shadow \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopyX\
```

Expected output:

```
symbolic link created
```

![Shadow mounted](images/step5-shadow-mounted.png)

---

### 6️⃣ Access the Old Version

```cmd
type C:\shadow\vss_lab.txt
```

Expected output:

```
ORIGINAL-DATA
```

✅ Confirms recovery from shadow copy.
![Old file recovered](images/step6-old-file-recovered.png)

---

### 7️⃣ Attacker Cleanup

```cmd
vssadmin delete shadows /all /quiet
vssadmin list shadows
```

Expected output:

```
No shadow copies present
```

![Shadows deleted](images/step7-shadows-deleted.png)

---

## 🧨 Attacker Perspective

* Access locked system files (SAM, SYSTEM)
* Extract sensitive or historical data
* Delete backups to prevent recovery

Common commands:

```cmd
vssadmin delete shadows /all /quiet
wmic shadowcopy delete
```

---

## 🛡️ Defender Perspective

Monitor:

* `vssadmin.exe`
* `wmic.exe`
* `mklink.exe`
* Use of `GLOBALROOT`

Relevant Event: **Event ID 4688 – Process Creation**

---

## 🧭 MITRE ATT&CK Mapping

* Inhibit System Recovery – T1490
* Defense Evasion – TA0005
* Impact – TA0040

> ⚠️ Tables replaced with lists for mobile readability

---

## 🧠 Key Takeaways

* VSS is both a recovery feature and high-value attack target
* GUI restore points are unreliable for security analysis
* Direct shadow copy access is how attackers really work
* Shadow copy deletion signals ransomware activity

---

## 📂 Project Structure

```
vss-lab/
├── README.md
└── images/
    ├── step1-file-created.png
    ├── step2-shadow-created.png
    ├── step3-list-shadows.png
    ├── step4-file-modified.png
    ├── step5-shadow-mounted.png
    ├── step6-old-file-recovered.png
    └── step7-shadows-deleted.png
```

---

## 📚 References

* Microsoft VSS Documentation
* TryHackMe – Windows Internals & Ransomware Labs
* MITRE ATT&CK Framework

---

## ⚠️ Disclaimer

For **educational purposes only** in a controlled VM environment.

```

