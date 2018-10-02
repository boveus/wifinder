require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require './lib/services/packet_ingestion_behavior'
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
      clean_line[2] = clean_line[2][0..-3]
      clean_line[3] = clean_line[3][0..-4]
      # This isn't a typo.  The Packet model is looking for the SSID info in
      # indice 5, rather than indice 6.  The CSV export is formatted differecntly
      # than the tshark import.
      clean_line[5] = clean_line[6].strip
      return clean_line
    else
      return false
    end
  end

  def create_packet_from_stream(stream_row)
    data_row = clean_stream_for_packet(stream_row)
    if data_row
      return Packet.create_from_row(data_row)
    else
      return false
    end
  end

  def ingest_from_stream(stream_row)
    packet = create_packet_from_stream(stream_row)
    if packet
      create_packet(packet)
      device = create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
    end
  end
end
