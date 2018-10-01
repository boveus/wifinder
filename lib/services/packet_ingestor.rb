require './lib/services/packet_service'
require './lib/services/database_service'
require './lib/models/device'
require './lib/models/ssid'
require 'sqlite3'
require 'pry'

class PacketIngestor
  def initialize
    @packets = PacketService.new.packets
    DatabaseService.new
    @db = SQLite3::Database.new("./db/wifinder.db")
    @total = @packets.length
  end

  def ingest
    @packets.each do |packet|
      create_packet(packet)
      device = create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
    end
  end

  def ingest_without_packets
    @packets.each do |packet|
      device = create_device(packet.source)
      create_ssid(packet.ssid)
      create_device_ssid(packet.source, packet.ssid)
    end
  end

  def create_packet(packet)
    @db.execute("INSERT INTO packets (id, capturetime, source, destination, protocol, info, ssid)
              VALUES (?, ?, ?, ?, ?, ?, ?)", packet.to_a)
  end

  def create_ssid(ssid)
    @db.execute("INSERT OR IGNORE INTO ssids (name) VALUES (?)", ssid)
  end

  def create_device_ssid(source, packet_ssid)
    device_id = Device.find_by(mac_addr: source)
    ssid_id = Ssid.find_by(name: packet_ssid)
    if device_id && ssid_id
      @db.execute("INSERT INTO devicessids (deviceID, ssidID) VALUES(?, ?)", [device_id.id, ssid_id.id])
    end
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
