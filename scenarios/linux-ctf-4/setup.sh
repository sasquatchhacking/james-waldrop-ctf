#!/bin/bash
set -e

echo "[*] Updating package lists..."
apt-get update -y

echo "[*] Installing aircrack-ng and hashcat (core tools)..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  aircrack-ng \
  hashcat

echo "[*] Trying to install optional tools (hcxtools, wordlists)..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  hcxtools \
  wordlists || echo "[!] Optional tools not available, continuing without them."

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make a CTF working dir in /root
mkdir -p /root/ctf

# Copy the pcap from the scenario folder into /root/ctf
if [ -f "$SCRIPT_DIR/Handshake_02C0CA8D9944.pcap" ]; then
  cp "$SCRIPT_DIR/Handshake_02C0CA8D9944.pcap" /root/ctf/Handshake_02C0CA8D9944.pcap
  chmod 644 /root/ctf/Handshake_02C0CA8D9944.pcap
  echo "[*] Copied handshake to /root/ctf/"
else
  echo "[!] Handshake_02C0CA8D9944.pcap not found in $SCRIPT_DIR"
fi

echo "[*] Environment ready. Start in /root/ctf."
