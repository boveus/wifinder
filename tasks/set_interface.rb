require 'yaml'
require 'pry'

desc 'Configure the interface to be used by the other tasks | usage rake set interface interface=<interface>'
task :set_interface do
  interface = "#{ENV["interface"]}"
  if interface
    File.write("config/config.yml", {'device' => interface}.to_yaml)
  else
    puts "ERROR: No device specified! \n"
  end
end
