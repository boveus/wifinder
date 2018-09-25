require './lib/services/view_renderer'
require './lib/services/packet_ingestor'

if File.exist?('./db/wifinder.db')
  puts "DB file exists, skipping DB creation - if you intended to create a fresh DB, run rake reset"
  puts "-------------------------------------------------------------"
  puts "The DB currently contains #{Device.count} unique MAC addresses"
  puts "#{Packet.count} total Packets and #{Packet.unique_ssids.count} unique SSIDs"
else
  PacketIngestor.new.ingest
  ViewRenderer.new.render
  puts "ingested #{Device.count} unique MAC addresses #{Packet.count} Packets"
  puts "and #{Packet.unique_ssids.count} unique SSIDs"
end
