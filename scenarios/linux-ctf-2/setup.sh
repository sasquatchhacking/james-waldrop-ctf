#!/bin/bash
set -e

# Create unprivileged user 'student' and a normal home
useradd -m -s /bin/bash student || true

# Ensure student can use sudo only if you want (usually not for this puzzle)
# apt-get update && apt-get install -y sudo
# usermod -aG sudo student

# Create the protected folder and flag owned by root
mkdir -p /home/student/secure
echo "flag{permissions_mastery_level_up}" > /home/student/secure/flag.txt
chown root:root /home/student/secure/flag.txt
chmod 600 /home/student/secure/flag.txt

# extra helpful file for context
echo "Looks like you found the locked door... maybe change who owns the key?" > /home/student/secure/note.txt
chown root:root /home/student/secure/note.txt
chmod 644 /home/student/secure/note.txt

# Make sure student owns their home
chown -R student:student /home/student

