[![Waffle.io - Columns and their card count](https://badge.waffle.io/boveus/wifinder.svg?columns=all)](https://waffle.io/boveus/wifinder)

### About ###
This is a project to use ~~[Lua with Wireshark](https://wiki.wireshark.org/Lua) and [Roda](https://github.com/jeremyevans/roda)~~ Wireshark, ActiveRecord, and a simple html page hosted via rack based on this awesome [tweet](https://twitter.com/tenderlove/status/351554818579505152).  I would like to add a simple JS front end (Probably vanilla JS with Datatables) to reduce page reloads.  The basic idea of this app is to help visualize packet data and add some additional analytic capability for a large number of packets.  I want the app to be as light weight as possible so I am opting for a simple rack app rather than Sinatra or Roda and probably vanilla JS instead of jQuery or React.  For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic, but I am intending it to be agnostic as far as how the packets are actually captured.

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

### Project Organization ###
The project organization is influenced by the [MVC model](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). There is a Packet model that acts as an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) between the database and the developer.  There are various services that create the database, parse the CSV (that is generated by Wireshark for now) and render the view. 

There are several directories with various types of objects in them:
- Models: This folder contains the ORM objects (Device and Packet so far)
- Services: These objects do various tasks behind the scenes.
- Templates: These contain ERB files for how to format the views.

### Setup Instructions ###

- Clone this repo
- In the root directory create a `data` folder, and put one or more CSVs with Wireshark packet capture data (following the instructions above) in it
- If you don't have them installed already, install [ruby](https://www.ruby-lang.org/en/documentation/installation/) and [bundler](https://bundler.io/)
- In the root directory, run `bundle install` to install the dependencies of the project
- Run `rake setup` to get the database populated and the CSVs migrated.  Depending on how many/how large the files are this can take a little bit of time
- Run `rake serve` - This will launch a rack server on port 9000.
- To view the server, you can go to http://localhost:9000 or, on linux-based systems, you can run `rake view`
- To reset the database (clearing out all of the data) you can run `rake reset`

