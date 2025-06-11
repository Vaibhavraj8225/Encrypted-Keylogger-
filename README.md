# 🔐 Encrypted Keylogger (Proof-of-Concept)

> ⚠️ **For Educational Use Only** — This project is intended strictly for ethical hacking, research, and academic environments like Kali Linux in VirtualBox.

## 📌 Features

- ✅ Captures keystrokes using `pynput`
- ✅ Encrypts logs with `cryptography.fernet`
- ✅ Stores encrypted logs locally with timestamps
- ✅ Simulates remote exfiltration (can be extended)
- ✅ Auto-starts on terminal session via `.bashrc`
- ✅ Kill switch to stop keylogger gracefully
- ✅ Decryption utility to view logs

---

## 🛠 Installation

```bash
chmod +x install_keylogger.sh
./install_keylogger.sh
This will:

Install dependencies (pynput, cryptography)

Create ~/keylogger_logs directory

Generate a secure encryption key (secret.key)

Add the following auto-start command to your .bashrc:

bash
Copy
Edit
# Keylogger auto-start
python3 /home/kali/keylogger_logs/keylogger.py &
🚀 Auto-Startup Behavior
Every time a new terminal session starts, the keylogger will launch in the background via .bashrc.

📍 Ensure you don't duplicate this line in .bashrc.

🛑 Kill Switch
To safely stop the keylogger without killing the process manually:

bash
Copy
Edit
touch ~/keylogger_logs/kill.txt
The keylogger checks for this file periodically and will exit if found.

🔓 Decrypt and View Logs
bash
Copy
Edit
cd ~/keylogger_logs
python3 decrypt_logs.py
This will use the secret.key to decrypt and print all recorded keystrokes from encrypted_log.txt.

Example output:

yaml
Copy
Edit
2025-06-11 11:15:43.123456 - a
2025-06-11 11:15:44.456789 - Key.space
🧼 Uninstallation
To completely remove the keylogger:

bash
Copy
Edit
chmod +x uninstall_keylogger.sh
./uninstall_keylogger.sh
This will:

Remove .bashrc startup entry

Delete the logs, encryption key, and kill switch

Optionally remove Python virtual environment (if used)

📁 Project Structure
csharp
Copy
Edit
keylogger-new/
├── install_keylogger.sh        # Installer
├── uninstall_keylogger.sh      # Uninstaller
├── keylogger.py                # Main logger
├── decrypt_logs.py             # Decryption viewer
├── .gitignore                  # Ignores logs/key files
└── README.md                   # This file
⚖️ License
This project uses a modified MIT License.

See LICENSE for details.

Summary:

✅ You may use, modify, and distribute

❌ You may NOT use it for unauthorized surveillance or malicious intent

🧠 Intended only for educational and ethical use

⚠️ Disclaimer
This keylogger is for ethical hacking labs, academic research, and proof-of-concept learning only.
Unauthorized deployment on systems without explicit consent is illegal and unethical.
The author is not responsible for any misuse or damages caused by this software.

🧠 Inspired by:
Python Security Labs

Ethical Hacking Coursework (e.g., CEH, OSCP)

Red Team Simulations
