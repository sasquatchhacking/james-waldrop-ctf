#!/bin/bash
set -euo pipefail

# Create unprivileged user 'student' if it doesn't exist
if ! id -u student >/dev/null 2>&1; then
  useradd -m -s /bin/bash student
fi

# Ensure student home exists and ownership is correct
mkdir -p /home/student/secure
chown -R student:student /home/student

# Plant the protected flag owned by root (student shouldn't be able to read it)
echo "flag{permissions_mastery_level_up}" > /home/student/secure/flag.txt
chown root:root /home/student/secure/flag.txt
chmod 600 /home/student/secure/flag.txt

# Helpful note for students
echo "Looks like you found the locked door... maybe change who owns the key?" > /home/student/secure/note.txt
chown root:root /home/student/secure/note.txt
chmod 644 /home/student/secure/note.txt

# Helper to enter the student account (useful if needed)
cat > /usr/local/bin/enter_student <<'EOF'
#!/bin/bash
exec sudo -u student -i
EOF
chmod +x /usr/local/bin/enter_student

# Add an opt-out marker file explanation (admins can create /root/.no_autoswitch to disable)
cat > /root/.autoswitch_notice <<'EOF'
Killercoda auto-switch helper installed.
To prevent the automatic switch to 'student', create /root/.no_autoswitch
(e.g., touch /root/.no_autoswitch) and restart the scenario.
EOF
chmod 644 /root/.autoswitch_notice

# Append guarded auto-switch to root's interactive startup (avoid duplicates)
bashrc="/root/.bashrc"
marker="# BEGIN: auto-switch-to-student (added by setup.sh)"
if ! grep -Fq "$marker" "$bashrc" 2>/dev/null; then
  cat >> "$bashrc" <<'BASH_SNIPPET'

$marker
# If running an interactive shell as root and opt-out file doesn't exist,
# automatically exec an interactive login shell as the 'student' user.
if [ "$(id -u)" -eq 0 ] && [ -t 0 ] && [ ! -f /root/.no_autoswitch ]; then
  # Avoid trying to re-exec if we're already the student user
  if [ "$(whoami)" = "root" ]; then
    exec sudo -u student -i
  fi
fi
# END: auto-switch-to-student
BASH_SNIPPET
fi

# Ensure permissions are normal
chmod 644 "$bashrc"

# Allow student to run sudo without a password (for lab convenience)
echo "student ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/student
chmod 440 /etc/sudoers.d/student
