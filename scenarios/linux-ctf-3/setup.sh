#!/bin/bash
set -euo pipefail

# --- User setup ---

# Create unprivileged user 'student' if not present
if ! id -u student >/dev/null 2>&1; then
  useradd -m -s /bin/bash student
fi

# Ensure student's home exists and is owned properly
mkdir -p /home/student
chown -R student:student /home/student

# --- Sudo convenience for lab use ---

apt-get update -y
apt-get install -y sudo

# Passwordless sudo for student in this lab environment
echo "student ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/student
chmod 440 /etc/sudoers.d/student

# --- Mission log scenario setup ---

LOG_DIR="/home/student/mission_logs"
mkdir -p "$LOG_DIR"

# Some noisy fake logs
cat > "$LOG_DIR/mission_01.log" <<'LOG1'
[2025-11-07 10:01:03] INFO  Uplink established to relay node ALPHA-1
[2025-11-07 10:01:09] INFO  Telemetry packets nominal
[2025-11-07 10:02:15] WARN  RSSI fluctuation detected; adjusting gain
[2025-11-07 10:02:48] INFO  Operator note: continue monitoring DF solution
LOG1

cat > "$LOG_DIR/mission_02.log" <<'LOG2'
[2025-11-07 11:14:23] INFO  Parsing raw capture buffer
[2025-11-07 11:15:02] INFO  Exported snapshot to /var/tmp/snapshot.bin
[2025-11-07 11:16:47] INFO  Checksum verified for 32768 frames
[2025-11-07 11:17:10] DEBUG Extra diagnostic trace enabled
LOG2

# The one with the hidden flag (encoded)
cat > "$LOG_DIR/mission_03.log" <<'LOG3'
[2025-11-07 12:30:01] INFO  Post-mission analysis started
[2025-11-07 12:31:44] INFO  Suspicious payload extracted from stream #4
[2025-11-07 12:32:12] INFO  Encoded artifact detected (base64):
ZmxhZ3tsb2dfYW5hbHlzaXNfcHJvfQ==
[2025-11-07 12:33:55] INFO  Analyst note: decode and verify integrity
LOG3

cat > "$LOG_DIR/mission_04.log" <<'LOG4'
[2025-11-07 13:05:00] INFO  Archiving results to offline storage
[2025-11-07 13:05:45] INFO  Report queued for operator review
[2025-11-07 13:06:10] INFO  Session closed, no further anomalies detected
LOG4

# Slightly more clutter
cat > "$LOG_DIR/system_diag.log" <<'LOG5'
[2025-11-07 09:00:00] INFO  System boot
[2025-11-07 09:00:03] INFO  Kernel version: 5.15.0-ubuntu
[2025-11-07 09:00:07] INFO  Filesystem check complete, no errors
[2025-11-07 09:00:12] INFO  Network interface eth0 up
LOG5

# Ensure student owns the log directory contents
chown -R student:student "$LOG_DIR"
