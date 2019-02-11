require './lib/services/packet_ingestion_behavior'
require './lib/services/packet_service'
require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require './lib/models/active_time'
require 'sqlite3'
require 'pry'

class PacketIngestor
  include PacketIngestionBehavior

  def initialize(csv_path = false)
    @packets = PacketService.new(csv_path).packets
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def ingest
    @packets.each do |packet|
      create_packet(packet)
      create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
      create_active_time(packet.capturetime, packet.source)
    end
  end
end
