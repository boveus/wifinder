require './lib/services/packet_ingestor'

if File.exist?('./db/wifinder.db')
  puts "DB file exists, skipping DB creation - if you intended to create a fresh DB, run rake reset"
  puts "-------------------------------------------------------------"
  puts "The DB currently contains #{Device.count} unique MAC addresses"
  puts "and #{Ssid.count} unique SSIDs"
else
  PacketIngestor.new.ingest_without_packets
  puts "ingested #{Device.count} unique MAC addresses"
  puts "and #{Ssid.count} unique SSIDs"
end
