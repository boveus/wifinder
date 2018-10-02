require 'pry'
require 'pty'
require 'json'
require './lib/services/packet_stream_ingestor'

desc 'start capturing packets (device must be in monitor mode)'
task :capture do
  psi = PacketStreamIngestor.new
  interface = "#{ENV["interface"]}"
  cmd = "tshark -i #{interface} -f 'subtype probereq' -T tabs"
  begin
    PTY.spawn( cmd ) do |stdout, stdin, pid|
      begin
        stdout.each do |line|
          psi.ingest_from_stream(line)
        end
      rescue Errno::EIO
        puts "ERROR: Perhaps you didnt create the database or you \n
        didnt set your interface to monitor mode?"
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end

  #  Only the fields we care about
  # cmd = "tshark -i #{interface} -f 'subtype probereq' -e frame.time -e wlan.sa -e wlan.ssid -T fields"
