desc 'Usage: interface=wlan1 rake set_to_monitor | set the device to monitor mode'
task :set_to_monitor do
  interface = "#{ENV["interface"]}"
  unless interface == ''
    `sudo ifconfig #{interface} down`
    `sudo iwconfig #{interface} mode monitor`
    `sudo ifconfig #{interface} up`
  else
    puts "ERROR: No device specified! \n"
    puts "Usage: interface=wlan1 rake set_to_monitor"
  end
end
