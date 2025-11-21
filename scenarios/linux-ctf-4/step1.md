
# Step 1 – Crack the Wi-Fi of a Toxic Avengers Fanboy

Welcome to **Linux CTF 4 – WPA2 Handshake Cracking**.

You’ve been handed a captured WPA2 4-way handshake in a `.pcap` file.  
Your job: build a smart wordlist, then crack the Wi-Fi passphrase.

---

## Scenario Background

Your target is an extremely online nerd:

- Spends way too much time arguing on Reddit about **how Thor could *totally* beat Superman**
- Frequently posts in superhero subs and hangs out on **TBS Comics** social media
- Loves all things **Marvel / Avengers**
- Uses the same few fandom-related words in *everything* (usernames, emails, pet names, etc.)

You’ve managed to capture a 4-way handshake from their home Wi-Fi. 
Now it’s time to weaponize their fandom.

You’ll practice:

- Grabbing files directly from **GitHub**
- Installing common offensive tools on Linux
- Using **CUPP** (Common User Password Profiler) to generate a targeted wordlist
- Running **aircrack-ng** and **hashcat** to crack WPA2

> 🧪 **Goal:** Recover the plaintext Wi-Fi password from the provided `.pcap`.

---

## 1. Create a Working Directory

Start in a clean workspace:

`mkdir -p ~/ctf`
`cd ~/ctf`
`pwd`

You should now be in:

`/home/<your-user>/ctf`

## 2. Download the Handshake from GitHub

Download the .pcap directly from your GitHub repo:

`cd ~/ctf`

`wget https://raw.githubusercontent.com/sasquatchhacking/james-waldrop-ctf/main/scenarios/linux-ctf-4/Handshake_02C0CA8D9944.pcap`

Verify the file:

`ls -lh`
`file Handshake_02C0CA8D9944.pcap`

If wget isn’t installed, you can use curl instead:

`curl -L \
  -o Handshake_02C0CA8D9944.pcap \
  https://raw.githubusercontent.com/sasquatchhacking/james-waldrop-ctf/main/scenarios/linux-ctf-4/Handshake_02C0CA8D9944.pcap`

## 3. Install the Required Tools

We’ll use:

aircrack-ng – validate the handshake and optionally crack directly

hashcat – GPU/CPU-based password cracker

hcxtools – convert .pcap to a format hashcat understands

git + python3 – to run CUPP

Install them (on Ubuntu/Kali style systems):

`sudo apt update`

`sudo apt install -y \
  aircrack-ng \
  hashcat \
  hcxtools \
  git \
  python3`

Quick sanity checks:

`aircrack-ng --help | head -n 3`
`hashcat --version`
`hcxpcapngtool --help | head -n 3`
`python3 --version`

## 4. Inspect the Handshake

First, verify the capture actually contains a usable WPA2 handshake.

`cd ~/ctf`

`aircrack-ng Handshake_02C0CA8D9944.pcap`

Things to look for:

The ESSID (network name)

A note that a valid WPA handshake was found

💡 You don’t need to fully crack it with aircrack-ng here (unless you want to).

The main challenge is to use hashcat + a smart wordlist.

## 5. Build a Targeted Wordlist with CUPP

Now we’ll use CUPP (Common User Password Profiler) to generate custom passwords based on the target’s personality.

### 5.1 Clone CUPP

`cd ~/ctf`

`git clone https://github.com/Mebus/cupp.git`
`cd cupp`

### 5.2 Run CUPP in Interactive Mode

`python3 cupp.py -i`

Answer the prompts based on the target description:

Think about:

Favorite characters (Thor, Loki, IronMan, etc.)

Favorite team or franchise (Avengers, Marvel, MCU)

Pet names / nicknames you might infer

Birthdates or lucky numbers you want to try (e.g., 1984, 2012, 3000)

Be creative but consistent with the scenario.
At the end, CUPP will create a wordlist file in the current directory (something like target.txt).

Rename it to something obvious:

`ls`
`mv <generated-file>.txt cupp-list.txt`

(Replace <generated-file> with the actual filename CUPP creates.)

Move it back into your main CTF folder:

`mv cupp-list.txt ~/ctf/`
`cd ~/ctf`

## 6. Combine CUPP with rockyou

Most wordlists live in /usr/share/wordlists/.

If rockyou.txt.gz exists:

`ls /usr/share/wordlists`

Decompress it (once):

`sudo gzip -d /usr/share/wordlists/rockyou.txt.gz 2>/dev/null || true`

Now combine rockyou and your CUPP list into a single mega wordlist:

`cd ~/ctf`

`cat /usr/share/wordlists/rockyou.txt cupp-list.txt > combined.txt`

`wc -l combined.txt`

`head combined.txt`

You now have:

A giant generic list (rockyou)

Plus your custom Marvel-nerd-themed guesses from CUPP

## 7. Convert the Handshake for Hashcat

Hashcat doesn’t work directly with .pcap files.

We’ll convert it to 22000 format using hcxpcapngtool:

`cd ~/ctf`

`hcxpcapngtool \
  -o wifi.hc22000 \
  Handshake_02C0CA8D9944.pcap`

Check that the file was created:

`ls -lh wifi.hc22000`

## 8. Crack the Handshake with Hashcat

Now the fun part.

Run hashcat using the WPA-EAPOL hash mode (22000) and your combined wordlist:

`cd ~/ctf`

`hashcat -m 22000 wifi.hc22000 combined.txt --force`

⚠️ If hashcat complains about no compatible GPU, it may fall back to CPU.
That’s fine for this lab.

Once hashcat finds the password, you can show the cracked result with:

`hashcat -m 22000 wifi.hc22000 combined.txt --show`

Record the recovered Wi-Fi password.

You’ll need it to complete the challenge.

## 9. (Optional) Crack with aircrack-ng
If you want to see a more classic tool in action:

bash
Copy code
`cd ~/ctf`

aircrack-ng -w combined.txt Handshake_02C0CA8D9944.pcap
This may be slower, but it’s a good comparison vs. hashcat.

## 10. What You Should Have at the End
By the time you’re done, you should be able to answer:

What is the ESSID of the captured Wi-Fi network?

What is the recovered WPA2 passphrase?

Which wordlist entry actually matched the password?
(Did it come from rockyou or your CUPP-generated list?)

You’ll submit the cracked Wi-Fi password as your final answer for this CTF step.

## Quick Self-Check
Before moving on, you should be comfortable with:

Downloading files from GitHub using wget or curl

Installing packages with apt

Using CUPP to generate a social-engineering-informed wordlist

Converting WPA2 handshakes with hcxpcapngtool

Cracking WPA2 with hashcat using mode 22000

If all of that feels good and you’ve recovered the password, you’re ready to continue. 😈


