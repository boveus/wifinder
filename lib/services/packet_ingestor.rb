require './lib/services/packet_service'
require './lib/services/database_service'
require './lib/models/device'
require 'sqlite3'
class PacketIngestor
  def initialize
    @packets = PacketService.new.packets
    DatabaseService.new
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def ingest
    @packets.each do |packet|
      create_packet(packet)
      device = create_device(packet.source)
      create_device_ssid(device.id, packet.ssid)
    end
  end

  def create_packet(packet)
    @db.execute("INSERT INTO packets (id, capturetime, source, destination, protocol, info, ssid)
              VALUES (?, ?, ?, ?, ?, ?, ?)", packet.to_a)
  end

  def create_device_ssid(device_id, packet_ssid)
    # todo, add values to join
  end

  def create_device(packet_source)
    if device_doesnt_exist?(packet_source)
      @db.execute("INSERT INTO devices (mac_addr)
                VALUES (?)", packet_source)
    end
  end

  def device_doesnt_exist?(mac_addr)
    @db.execute("select * FROM devices WHERE mac_addr = (?)", mac_addr).length == 0
  end
end
