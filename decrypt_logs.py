from cryptography.fernet import Fernet
import os

LOG_DIR = os.path.expanduser("~/keylogger_logs")
KEY_FILE = os.path.join(LOG_DIR, "secret.key")
LOG_FILE = os.path.join(LOG_DIR, "encrypted_log.txt")

def load_key():
    with open(KEY_FILE, "rb") as f:
        return f.read()

def decrypt_logs():
    key = load_key()
    fernet = Fernet(key)

    if not os.path.exists(LOG_FILE):
        print("[!] No encrypted log file found.")
        return

    with open(LOG_FILE, "rb") as f:
        lines = f.readlines()

    print("[*] Decrypted Keystrokes:\n")
    for line in lines:
        try:
            decrypted = fernet.decrypt(line.strip())
            print(decrypted.decode())
        except Exception as e:
            print(f"[!] Error decrypting a line: {e}")

if __name__ == "__main__":
    decrypt_logs()
