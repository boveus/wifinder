### About ###
This is a project to use ~~[Lua with Wireshark](https://wiki.wireshark.org/Lua) and [Roda](https://github.com/jeremyevans/roda)~~ Wireshark, ActiveRecord, and a simple html page hosted via rack based on this awesome [tweet](https://twitter.com/tenderlove/status/351554818579505152).  I would like to add a simple JS front end (Probably vanilla JS) to reduce page reloads.  The basic idea of this app is to help visualize packet data and add some additional analytic capability for a large number of packets.  I want the app to be as light weight as possible so I am opting for a simple rack app rather than Sinatra or Roda and probably vanilla JS instead of jQuery or React.  For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic, but I am intending it to be agnostic as far as how the packets are actually captured.

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
![wireshark](https://user-images.githubusercontent.com/20469703/43873015-c7a73290-9b52-11e8-85b9-31683bdd22e2.png)

To generate a CSV to ingest into the application, use Wireshark's built in functionality to save the packets as a CSV:

![save_as_csv](https://user-images.githubusercontent.com/20469703/43873029-dfc5e902-9b52-11e8-9913-d79c0c68f7fa.PNG)

### Resources ###
There is a good sampling of wireshark packet captures that can be used for testing [here](ftp://ftp.bro-ids.org/enterprise-traces/hdr-traces05/).
