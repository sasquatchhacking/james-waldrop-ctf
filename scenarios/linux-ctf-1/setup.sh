#!/bin/bash
set -e

# Create student home dir and hide the flag
mkdir -p /home/student/logs/.hidden

echo "flag{linux_file_ops_master}" > /home/student/logs/.hidden/flag.txt

# Tighten permissions a bit
chmod 700 /home/student/logs/.hidden
chmod 600 /home/student/logs/.hidden/flag.txt
