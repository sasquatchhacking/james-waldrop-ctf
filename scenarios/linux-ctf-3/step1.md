# 🕵️‍♂️ Log Hunter

Welcome to your third Linux CTF mission!

A post-mission analysis produced several logs under:

/home/student/mission_logs


Somewhere in those logs is an **encoded artifact** that contains your flag.

---

## 🎯 Objectives

1. Explore the mission logs with standard Linux tools.
2. Locate the suspicious/encoded data.
3. Decode it to recover the final flag.

---

## 🧭 Suggested Approach

From your home directory:

```bash
cd ~/mission_logs
ls

Try using:

    cat or less to read files

    grep to search across multiple logs

    grep -R "base64" . or search for suspicious patterns

    base64 -d to decode any base64 strings you find

Example decoding pattern:

echo "ZmxhZ3tsb2dfYW5hbHlzaXNfcHJvfQ==" | base64 -d

💡 Hints

    Look for a log entry that explicitly mentions encoded artifact or base64.

    You do not need sudo for this challenge.

    Focus on reading and decoding, not changing permissions.

When you succeed, you'll reveal a flag in this format:

flag{log_analysis_pro}

