require 'sqlite3'
require './lib/models/packet'

class Device
  attr_accessor :id,
                :mac_addr

  def initialize(row)
    @id = row[0]
    @mac_addr = row[1]
  end

  def ssids
    Packet.find_by(source: mac_addr).map(&:ssid).uniq
  end

  def self.db
    SQLite3::Database.new("./db/wifinder.db")
  end

  def self.count
    all.count
  end

  def self.find(id)
    result = db.execute("select * FROM devices WHERE id = (?)", id)
    Device.new(result.first)
  end

  def self.all
    query("select * FROM devices" )
  end

  def self.query(sql_query)
    devices = []
    db.execute( sql_query ) do |row|
      devices << Device.new(row)
    end
    devices
  end
end
