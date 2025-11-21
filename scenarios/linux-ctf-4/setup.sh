#!/bin/bash
set -e

echo "[*] Creating CTF working directory..."
mkdir -p /root/ctf

echo "[*] Ensuring handshake file is in /root/ctf..."
# Handshake should already be copied here by assets, but this keeps things safe
if [ ! -f /root/ctf/Handshake_02C0CA8D9944.pcap ]; then
  echo "[!] Handshake file missing in /root/ctf – something's off with assets config."
fi

echo "[*] Updating apt cache..."
apt-get update -y

echo "[*] Installing required tools (aircrack-ng, hashcat, hcxtools, wordlists)..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  aircrack-ng \
  hashcat \
  hcxtools \
  wordlists || echo "[!] Some packages failed to install (might not exist in this image)."

echo "[*] Environment ready. Change to /root/ctf to begin:"
echo "    cd /root/ctf"
