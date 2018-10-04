[![Waffle.io - Columns and their card count](https://badge.waffle.io/boveus/wifinder.svg?columns=all)](https://waffle.io/boveus/wifinder)

# About #
This is a project to use Wireshark to capture packets and view some analysis about them in an html page.  There is currently a simple JS front end using data tables and a Rack server and will eventually have google calendar integration.

The current capabilities of this app include the following:
  - Ingest data from an exported Wireshark packet capture (CSV format is currently the only format supported)
  - Ingest data and add it to the database on the fly using a rake task that runs [tshark](https://www.wireshark.org/docs/man-pages/tshark.html)
  - View and search a list of all of the devices in a datatables view:
    ![capture](https://user-images.githubusercontent.com/20469703/46324369-2bdc0680-c5c1-11e8-8488-c38638cda6f2.PNG)
  - View and search a list of all of the SSIDs in a datatables view:
  ![image](https://user-images.githubusercontent.com/20469703/46448418-bdc84880-c754-11e8-8fe5-ce48317c9915.png)
  - View details about an individual device:
   ![image](https://user-images.githubusercontent.com/20469703/46448389-940f2180-c754-11e8-8cca-b15d5a7f6d3e.png)
  - View details about a particular SSID:
  
  ![image](https://user-images.githubusercontent.com/20469703/46448430-cb7dce00-c754-11e8-983d-de3de2f9e187.png)

The SSID and Devices views reference one another, so you can view details about the SSIDs associated with a particular device and vice versa.

For the time being this is intended to passively monitor traffic rather than use packet injection to generate additional traffic.  I am also challenging myself to limit the number of dependencies as much as possible.

## Pre-requistite Hardware ##
- A network interface [card](https://www.acrylicwifi.com/en/support-webinars-wifi-wireless-network-software-tools/compatible-hardware/) capable of [monitor mode](https://en.wikipedia.org/wiki/Monitor_mode)

## Pre-requistite Software ##
- Some version of linux/unix. (Monitoring mode for WiFi NICs is not well supported in OSX/Windows) 
- I tested this in Ubuntu 16.04
- Wireshark (Available at https://www.wireshark.org/)

# Getting Started #
Identify the wireless interface you want to set to monitor mode using `ip a` or `ifconfig`.
Set the device to monitor mode using the following commands
```bash
sudo ifconfig <interface> down
sudo iwconfig <interface> mode monitor
sudo ifconfig <interface> up
```
Alternatively, there is a rake task built into the project to do so
```bash
interface=wlan1 rake set_to_monitor
```
## Start capturing
To display only probe requests, use the following wireshark display filter:
```
wlan.fc.type_subtype == 0x08
```
To capture only probe requests, you can use the following capture filter:
```
subtype probereq
```
![wireshark](https://user-images.githubusercontent.com/20469703/43873015-c7a73290-9b52-11e8-85b9-31683bdd22e2.png)

Start capturing on the device (above) that you had set to monitor mode.  Run it for as long as you want, but I recommend 3-6 hours or so at a minimum to get a large amount of data.

## Export a CSV to import into the application

To generate a CSV to ingest into the application, use Wireshark's built in functionality to save the packets as a CSV:

![save_as_csv](https://user-images.githubusercontent.com/20469703/43873029-dfc5e902-9b52-11e8-9913-d79c0c68f7fa.PNG)

Once you have gathered the CSV, you can ingest them into the application by doing the following:

- Clone this repo
- In the root directory create a `data` folder, and put one or more CSVs with Wireshark packet capture data (following the instructions above) in it
- If you don't have them installed already, install [ruby](https://www.ruby-lang.org/en/documentation/installation/) and [bundler](https://bundler.io/)
- In the root directory, run `bundle install` to install the dependencies of the project
- Run `rake setup` to get the database created.
- To populate the DB, run `rake csv_ingest`. Depending on how many/how large the files are this can take a little bit of time
- Alternatively, you can run `rake monitor interface=wlan1(or your interface)` to capture packets and ingest them into the DB on the fly.  If your device is not in monitoring mode, see above.

# To view the data
- Run `rake serve` - This will launch a rack server on port 9000.
- To view the server, you can go to http://localhost:9000/devices
- This will list all of the devices that have been recognized by the capture.  This may take a little while to load if you have a large amount of data.  You can then click on a device to view more details about it.

## Project Organization ##
The project organization is influenced by the [MVC model](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). There is a Packet model that acts as an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) between the database and the developer.  There are various services that create the database, parse the CSV (that is generated by Wireshark for now) and render the views through ERB and a few Rack server objects.

There are several directories with various types of objects in them:
- Models: This folder contains the ORM objects (Device, Packet, Ssid, ActiveTime so far)
- Services: These objects do various tasks behind the scenes.
- Templates: These contain ERB files for how to format the views for the index / show pages for the models. 

## Rake Tasks ##

The current rake tasks for the application are the following:

```shell
rake capture         # start capturing packets (device must be in monitor mode)
rake csv_ingest      # Populate the DB with CSVs from the data directory
rake destroy         # Delete the DB
rake light_setup     # setup the database without ingesting packets
rake serve           # serve the viewer folder
rake set_to_monitor  # Usage: interface=wlan1 rake set_to_monitor | set the device to monitor mode
rake setup           # Setup the database
rake view            # view home page in the default browser
```
