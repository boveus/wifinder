require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require 'sqlite3'
require 'pry'

class PacketStreamIngestor
  include PacketIngestionBehavior

  def initialize
    DatabaseService.new
    @db = SQLite3::Database.new("./db/wifinder.db")
  end


  def create_packet_from_stream(stream_row)
    Packet.new()
  end

  def ingest_from_stream(stream_row)
    create_packet(packet)
    device = create_device(packet.source)
    create_ssid(packet.ssid)
    create_device_ssid(packet.source, packet.ssid)
  end

end
