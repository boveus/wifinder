require 'sqlite3'
require './lib/models/packet'
require './lib/models/ssid'

class Device
  attr_accessor :id,
                :mac_addr

  def initialize(row)
    @id = row[0]
    @mac_addr = row[1]
  end

  def ssid_count
    Device.db.execute("select COUNT(DISTINCT devicessids.ssidid) from
    devicessids where deviceid = (?)", id).first.first
  end

  def ssids
    ssid_ids = Device.db.execute("select ssidid from devicessids WHERE deviceid = (?)", id).uniq
    ssid_ids.map do |id|
      Ssid.find(id)
    end
  end

  def self.db
    SQLite3::Database.new("./db/wifinder.db")
  end

  def self.count
    all.count
  end

  def self.find(id)
    result = db.execute("select * FROM devices WHERE id = (?)", id.to_i)
    Device.new(result.first)
  end

  def self.find_by(arguments)
    column = arguments.keys.first
    value = arguments.values.first
    row = db.execute("select * from devices WHERE #{column} = (?)", value).first
    Device.new(row)
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
