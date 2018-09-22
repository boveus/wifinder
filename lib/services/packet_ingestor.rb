require './lib/services/packet_service'
require './lib/services/database_service'
require 'sqlite3'
class PacketIngestor
  def initialize
    @packets = PacketService.new.packets
    DatabaseService.new
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def ingest
    @packets.each do |packet|
      @db.execute("INSERT INTO packets (id, capturetime, source, destination, protocol, info, ssid)
                VALUES (?, ?, ?, ?, ?, ?, ?)", packet.to_a)
    end
  end
end
