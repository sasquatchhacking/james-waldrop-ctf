#!/bin/bash
set -e

# Create student environment and restricted flag
mkdir -p /home/student/secure

# Create flag (owned by root, unreadable by student)
echo "flag{permissions_mastery_level_up}" > /home/student/secure/flag.txt

# Change ownership and restrict access
chown root:root /home/student/secure/flag.txt
chmod 600 /home/student/secure/flag.txt

# Leave a helpful note
echo "Looks like you found the locked door... maybe change who owns the key?" > /home/student/secure/note.txt
chmod 644 /home/student/secure/note.txt
