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

# Make sure rockyou is unzipped and ready
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  echo "[*] Decompressing rockyou.txt..."
  gzip -d /usr/share/wordlists/rockyou.txt.gz
fi

# Create working directory for the CTF
mkdir -p /root/ctf
cd /root/ctf

# Copy the handshake from the scenario filesystem if present
if [ -f /root/Handshake_02C0CA8D9944.pcap ]; then
  cp /root/Handshake_02C0CA8D9944.pcap .
fi

echo "[*] Environment ready. Start in /root/ctf."
