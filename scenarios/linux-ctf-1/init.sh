#!/bin/bash
set -e

# Create directory and plant the flag
mkdir -p /home/student/logs/.hidden
echo "flag{linux_file_ops_master}" > /home/student/logs/.hidden/flag.txt

# Tighten perms
chmod 700 /home/student/logs/.hidden
chmod 600 /home/student/logs/.hidden/flag.txt

