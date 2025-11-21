#!/bin/bash
set -euo pipefail

# Make a CTF working dir in /root
mkdir -p /root/ctf

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy the pcap from the scenario folder into /root/ctf
cp "$SCRIPT_DIR/Handshake_02C0CA8D9944.pcap" /root/ctf/Handshake_02C0CA8D9944.pcap

# Lock in sane perms
chmod 644 /root/ctf/Handshake_02C0CA8D9944.pcap

sudo apt-get update -y

sudo apt-get install -y \
  aircrack-ng \
  hashcat \
  hcxtools \
  wordlists
