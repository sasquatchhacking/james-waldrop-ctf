# Linux CTF 4 – Break the Avengers Wi-Fi Password

You’ve captured traffic from a suspicious access point broadcasting near your collection van.  
Intelligence believes the AP is using a **superhero-themed password**.

You are given a captured WPA2 handshake:

```bash
/root/ctf/Handshake_02C0CA8D9944.pcap

Your mission:

    Verify the WPA2 4-way handshake is present.

    Convert it into a format usable by hashcat.

    Use a common wordlist to crack the Wi-Fi password.

    Submit the password in flag format: flag{password_here}.

Step 1 – Verify the Handshake

From the terminal:

`cd /root/ctf`
`ls`
`aircrack-ng Handshake_02C0CA8D9944.pcap`

You should see something like:

WPA handshake: <BSSID>

If you do not see WPA handshake, check that you are in /root/ctf and that the file name is correct.

    ✅ Checkpoint: You’ve confirmed the capture contains a valid WPA2 handshake.

Step 2 – Convert the Capture for Hashcat

hashcat does not crack .pcap directly.
We first convert the capture into the special hccapx format.

Run:

`cd /root/ctf`

`hcxpcapngtool -o avengers.hccapx Handshake_02C0CA8D9944.pcap`

You should see output indicating an hccapx file was created, for example:

output file: avengers.hccapx

Check:

`ls`
# Handshake_02C0CA8D9944.pcap  avengers.hccapx

    ✅ Checkpoint: You’ve successfully converted the handshake into a hashcat-ready format.

Step 3 – Prepare the Wordlist

A common wordlist is already installed at:

/usr/share/wordlists/rockyou.txt

If you ever need to decompress it manually in another environment, you can use:

`sudo gzip -d /usr/share/wordlists/rockyou.txt.gz`

    ✅ Checkpoint: You have a large password list ready for an offline attack.

Step 4 – Crack the Wi-Fi Password with Hashcat

Now run hashcat in WPA/WPA2 mode using the hccapx file and the rockyou.txt list:

`cd /root/ctf`

`hashcat -m 2500 avengers.hccapx /usr/share/wordlists/rockyou.txt`

Let hashcat run until it finishes.
When it finds the password, it will print a line with the recovered key.

You can also re-print results with:

`hashcat -m 2500 avengers.hccapx /usr/share/wordlists/rockyou.txt --show`

    💡 Hint: The password is superhero-related.

    ✅ Checkpoint: You’ve successfully recovered the Wi-Fi password.

Step 5 – Submit the Flag

Once you have the password, submit it in this format:

flag{password_goes_here}


