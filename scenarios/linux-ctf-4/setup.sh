#!/bin/bash
set -e

echo "[*] Updating package lists..."
apt-get update -y

echo "[*] Installing required tools (aircrack-ng, hashcat, hcxtools, wordlists)..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  aircrack-ng \
  hashcat \
  hcxtools \
  wordlists

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make a CTF working dir in /root
mkdir -p /root/ctf

# Copy the pcap from the scenario folder into /root/ctf
cp "$SCRIPT_DIR/Handshake_02C0CA8D9944.pcap" /root/ctf/Handshake_02C0CA8D9944.pcap

# Lock in sane perms
chmod 644 /root/ctf/Handshake_02C0CA8D9944.pcap

echo "[*] Environment ready. Start in /root/ctf."
