### Pre-requistite Hardware ###
- A network interface [card](https://www.acrylicwifi.com/en/support-webinars-wifi-wireless-network-software-tools/compatible-hardware/) capable of (monitor mode)[https://en.wikipedia.org/wiki/Monitor_mode]

### Pre-requistite Software ###
- Some version of linux/unix. (Monitoring mode for WiFi NICs is not well supported in OSX/Windows)
- Aircrack-ng
 ```
 sudo apt-get install aircrack-ng
 ```
 - Wireshark
 Download [here](https://www.wireshark.org/download.html).

### Getting Started ###
Identify the wireless interface you want to set to monitor mode using `ip a` or `ifconfig`. 
Set the device to monitor mode using the following command: `sudo airmon-ng start <interface name>` then run Wireshark and capture some packets.

### Resources ###
There is a good sampling of wireshark packet captures that can be used for testing (here)[ftp://ftp.bro-ids.org/enterprise-traces/hdr-traces05/].
