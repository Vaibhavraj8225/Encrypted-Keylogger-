# 🔐 Encrypted Keylogger (Proof-of-Concept)

> ⚠️ Disclaimer
This code is strictly for educational and ethical hacking lab environments such as Kali Linux in VirtualBox.
Do not use this on real systems without full authorization.
Violating privacy laws can result in severe criminal charges.
I (and contributors) take no responsibility for misuse.

> ⚠️ Educational Purposes Only — Do NOT use this on machines you don't own or without consent.

## Features
- Records keystrokes using `pynput`
- Encrypts logs using `cryptography.fernet`
- Stores logs locally with timestamps
- Simulates remote exfiltration
- Startup persistence and kill switch
- Decryption utility for viewing logs

## Usage

### 🔧 Installation
```bash
chmod +x install_keylogger.sh
./install_keylogger.sh


🛑 Uninstallation
```bash
chmod +x uninstall_keylogger.sh
./uninstall_keylogger.sh


🔓 View Logs
```bash
python3 decrypt_logs.py
