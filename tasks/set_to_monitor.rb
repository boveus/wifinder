desc 'Usage: interface=wlan1 rake set_to_monitor | set the device to monitor mode'
task :set_to_monitor do
  interface = "#{ENV["interface"]}"
  unless interface == ''
    puts 'Taking interface down...'
    `sudo ifconfig #{interface} down`
    puts 'Setting interface to monitor mode...'
    `sudo iwconfig #{interface} mode monitor`
    puts 'Bringing the interface back up...'
    `sudo ifconfig #{interface} up`
    puts "Complete - you can type 'iwconfig' to verify"
  else
    puts "ERROR: No device specified! \n"
    puts "Usage: interface=wlan1 rake set_to_monitor"
  end
end
