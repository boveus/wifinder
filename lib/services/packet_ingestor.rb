require './lib/services/packet_service'
require './lib/services/database_service'
require 'sqlite3'
class PacketIngestor
  def initialize(packet_csv)
    @packets = PacketService.new(packet_csv).packets
    DatabaseService.new
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def ingest
    @packets.each do |packet|
      @db.execute("INSERT INTO packets (id, capturetime, source, destination, protocol, info)
                VALUES (?, ?, ?, ?, ?, ?)", packet.to_a)
    end
  end
end
