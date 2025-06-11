#!/bin/bash

INSTALL_DIR="$HOME/keylogger_logs"
SCRIPT_PATH="$INSTALL_DIR/keylogger.py"
BASHRC="$HOME/.bashrc"

echo "[!] Stopping any running keylogger processes..."
pkill -f "$SCRIPT_PATH"

echo "[+] Removing startup entry from ~/.bashrc"
sed -i "\|python3 $SCRIPT_PATH &|d" "$BASHRC"

echo "[+] Deleting keylogger files and logs from $INSTALL_DIR"
rm -rf "$INSTALL_DIR"

echo "[+] Reloading .bashrc to apply changes"
source "$BASHRC"

echo "[✔] Keylogger uninstalled successfully."
