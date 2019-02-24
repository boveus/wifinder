require 'pry'
require 'pty'
require 'json'
require './lib/services/packet_stream_ingestor'

desc 'start capturing packets (device must be in monitor mode)'
task :capture do
  psi = PacketStreamIngestor.new
  interface = "#{ENV["interface"]}"
  cmd = "tshark -i #{interface} -f 'subtype probereq' -t ad -T tabs -o nameres.mac_name:FALSE"
  # -f specifies it to only capture using the specified filter (probe requests)
  # -t ad specifies to use the absolute time with a date added
  # -T tabs specifies the format of the output
  # -o nameres.mac_name:FALSE is to disable the vendor OUI lookup, so we receive a valid MAC
  # https://www.wireshark.org/docs/wsug_html_chunked/ChCustCommandLine.html
  begin
    PTY.spawn( cmd ) do |stdout, stdin, pid|
      begin
        stdout.each do |line|
          psi.ingest_from_stream(line)
        end
      rescue Errno::EIO
        puts "ERROR: Perhaps you didnt create the database or you didnt set your interface to monitor mode?"
        puts "You may need to allow non-sudo users to capture packets using tshark. See: https://osqa-ask.wireshark.org/questions/7976/wireshark-setup-linux-for-nonroot-user"
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end
