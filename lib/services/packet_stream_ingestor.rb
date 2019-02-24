require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require './lib/services/packet_ingestion_behavior'
require './lib/models/active_time'
require 'sqlite3'
require 'pry'

class PacketStreamIngestor
  attr_reader :db
  include PacketIngestionBehavior

  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def clean_stream_for_packet(stream_row)
    clean_line = stream_row.split("\t")
    if clean_line.length > 4
      clean_line[0] = clean_line[0].to_i
      clean_line.delete_at(3)
      return clean_line
    else
      return false
    end
  end

  def create_packet_from_stream(stream_row)
    data_row = clean_stream_for_packet(stream_row)
    if data_row
      return Packet.new(data_row)
    else
      return false
    end
  end

  def ingest_from_stream(stream_row)
    packet = create_packet_from_stream(stream_row)
    if packet
      # Skip this for now
      # create_packet(packet)
      device = create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
      create_active_time(packet.capturetime, packet.source)
    end
  end
end
