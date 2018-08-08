### About ###
This is a project to use [Lua with Wireshark](https://wiki.wireshark.org/Lua) and [Roda](https://github.com/jeremyevans/roda) and some sort of front end interface to an application that can be used for tracking and finding information about wifi devices.  For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic.

I am currently learning about packet dissection and capture filtering using Lua and Wireshark.  Once I get some basic filtering set up, I am planning to store this data in a SQL DB and present it locally using Roda.

### Pre-requistite Hardware ###
- A network interface [card](https://www.acrylicwifi.com/en/support-webinars-wifi-wireless-network-software-tools/compatible-hardware/) capable of (monitor mode)[https://en.wikipedia.org/wiki/Monitor_mode]

### Pre-requistite Software ###
- Some version of linux/unix. (Monitoring mode for WiFi NICs is not well supported in OSX/Windows)
- Wireshark

### Getting Started ###
Identify the wireless interface you want to set to monitor mode using `ip a` or `ifconfig`.
Set the device to monitor mode using the following commands
```bash
sudo ifconfig <interface> down
sudo iwconfig <interface> mode monitor
sudo ifconfig <interface> up
```

To display only probe requests, use the following wireshark display filter:
```
wlan.fc.type_subtype == 0x08
```
To capture only probe requests, you can use the following capture filter:
```
subtype probereq
```

### Resources ###
There is a good sampling of wireshark packet captures that can be used for testing [here](ftp://ftp.bro-ids.org/enterprise-traces/hdr-traces05/).
