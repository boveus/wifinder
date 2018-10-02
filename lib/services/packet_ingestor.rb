require './lib/services/packet_ingestion_behavior'
require './lib/services/packet_service'
require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require 'sqlite3'
require 'pry'

class PacketIngestor
  include PacketIngestionBehavior

  def initialize
    @packets = PacketService.new.packets
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def ingest
    @packets.each do |packet|
      create_packet(packet)
      device = create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
    end
  end
end
