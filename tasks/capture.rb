require 'pry'
require 'pty'
require 'json'
<<<<<<< HEAD

desc 'start capturing packets (device must be in monitor mode)'
task :capture do
=======
require './lib/services/packet_stream_ingestor'

desc 'start capturing packets (device must be in monitor mode)'
task :capture do
  psi = PacketStreamIngestor.new
>>>>>>> 48532a2e2970487b4d75d69c50c9495e1d6c9e0d
  interface = "#{ENV["interface"]}"
  cmd = "tshark -i #{interface} -f 'subtype probereq' -T tabs"
  begin
    PTY.spawn( cmd ) do |stdout, stdin, pid|
      begin
<<<<<<< HEAD
        # Do stuff with the output here. Just printing to show it works
        stdout.each do |line|
          clean_line = line.split("\t")
          if clean_line.length > 3
            clean_line[2] = clean_line[2][0..-3]
            clean_line[3] = clean_line[3][0..-4]
            clean_line[6] = clean_line[6].strip
          end
          print clean_line.to_s + "\n"
          # .strip.split('	').to_s + "\n"
        end
      rescue Errno::EIO
        puts "Errno:EIO error, but this probably just means " +
              "that the process has finished giving output"
=======
        stdout.each do |line|
          psi.ingest_from_stream(line)
        end
      rescue Errno::EIO
        puts "ERROR: Perhaps you didnt create the database or you \n
        didnt set your interface to monitor mode?"
>>>>>>> 48532a2e2970487b4d75d69c50c9495e1d6c9e0d
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end

  #  Only the fields we care about
  # cmd = "tshark -i #{interface} -f 'subtype probereq' -e frame.time -e wlan.sa -e wlan.ssid -T fields"
