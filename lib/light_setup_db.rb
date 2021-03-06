require './lib/services/packet_ingestor'

if File.exist?('./db/wifinder.db')
  PacketIngestor.new.ingest_without_packets
  puts "There are now #{Device.count} unique MAC addresses #{Packet.count} Packets"
  puts "and #{Ssid.count} unique SSIDs in the database"
else
  "ERROR: There is no database!"
end
