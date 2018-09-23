require 'sqlite3'
class Device
  attr_accessor :mac_addr

  def initialize(row)
    @id = row[0]
    @mac_addr = row[1]
  end

  def self.db
    SQLite3::Database.new("./db/wifinder.db")
  end

  def self.count
    all.count
  end

  def self.all
    query("select * from devices" )
  end

  def self.query(sql_query)
    devices = []
    db.execute( sql_query ) do |row|
      devices << Device.new(row)
    end
    devices
  end
end
