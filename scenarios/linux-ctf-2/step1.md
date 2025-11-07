# 🔐 Permissions Puzzle

Welcome to your second Linux CTF mission!

This time, your objective is to **recover a flag protected by strict permissions**.

---

## 🧭 Objectives
1. Locate the hidden directory.  
2. Investigate the permissions on the files.  
3. Adjust ownership or permissions to gain access to the flag.  

---

## 💡 Hints
- Use `ls -l` to inspect file permissions.  
- Try `chmod` or `chown` to adjust who can read files.  
- Remember that permissions use binary triplets (r=4, w=2, x=1).  

---

## 🧩 Your Task
A mysterious folder has appeared in your home directory called **secure**.  
Inside is a file named `flag.txt` — but it’s locked down by the system.

Can you retrieve the flag?

When successful, you’ll see:

flag{permissions_mastery_level_up}
---

Good luck, Agent.
