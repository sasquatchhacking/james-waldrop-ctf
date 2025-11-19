# 🔐 Permissions Puzzle

Welcome to your second Linux CTF mission!

This time, your objective is to **recover a flag protected by strict permissions**.

---

## 🧭 Step 1 — Enter the Student Account
When the environment starts, you’ll be logged in as `root`.  
To complete this challenge properly, switch to the unprivileged **student** account first:

`sudo -u student -i`


Verify the switch:

`whoami`

should return: student


---

## 🧩 Step 2 — Investigate
1. Navigate to `/home/student/secure`
2. Use `ls -l` to inspect file permissions  
3. Try reading the files and notice which ones are locked  

---

## 💡 Hints
- Use `chmod` and `chown` to adjust who can read the files.  
- Remember permission bits: **r=4**, **w=2**, **x=1**.  
- The goal is to view the contents of `flag.txt`.

---

When successful, you’ll see:

flag{permissions_mastery_level_up}
