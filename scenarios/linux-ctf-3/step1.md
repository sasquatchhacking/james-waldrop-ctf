# 🕵️‍♂️ Log Hunter

Welcome to your third Linux CTF mission!

This time your goal is to **analyze mission logs** and uncover a hidden, encoded flag.

---

## 🧭 Step 1 — Switch to the Student Account
When the environment starts, you may be logged in as `root`.  
To simulate a real analyst environment, switch to the unprivileged **student** account:

`sudo -u student -i`


Verify:

`whoami`

should return: student


---

## 🧩 Step 2 — Investigate the Logs
All mission logs are located in:

/home/student/mission_logs


Use the following commands to explore and search:

`cd ~/mission_logs`
`ls`
`grep -R "base64"` .


When you find a suspicious string, decode it with:

`echo "<encoded_string>" | base64 -d`


---

## 💡 Hints

- Look for lines mentioning `encoded artifact` or `base64`.
- Focus on using `grep`, `less`, and `base64` — you don’t need `sudo` for this one.
- Remember: base64 decoding is your friend!

---

When you succeed, you’ll reveal the flag:

flag{log_analysis_pro}

