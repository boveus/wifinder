require 'pry'
require 'pty'
require 'json'

desc 'start capturing packets (device must be in monitor mode)'
task :capture do
  interface = "#{ENV["interface"]}"
  cmd = "tshark -i #{interface} -f 'subtype probereq' -e frame.time -e wlan.sa -e wlan.ssid -T fields"
  begin
    PTY.spawn( cmd ) do |stdout, stdin, pid|
      begin
        # Do stuff with the output here. Just printing to show it works
        stdout.each do |line|
          print line.strip.split('	').to_s + "\n"
        end
      rescue Errno::EIO
        puts "Errno:EIO error, but this probably just means " +
              "that the process has finished giving output"
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end

# -T pdml|ps|psml|json|jsonraw|ek|tabs|text|fields|?
                         # format of text output (def: text)
#
