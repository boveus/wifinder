require 'sqlite3'
require './lib/models/device'
require './lib/models/packet'
require './lib/models/model_methods'

class Ssid
  KLASSNAME = 'Ssid'
  TABLE_NAME = 'ssids'
  include ModelMethods

  attr_accessor :id,
                :name

  def initialize(row)
    @id = row[0]
    @name = row[1]
  end

  def self.create(attributes)
    if find_by(name: attributes[:name])
      'A record with that nickname exists'
    else
      db.execute("INSERT INTO ssids (name) VALUES (?);", attributes[:name])
      ssid = Ssid.find(db.last_insert_row_id)
      ssid ? ssid : false
    end
  end

  def device_count
    Ssid.db.execute("SELECT COUNT(DISTINCT devicessids.deviceid) from
    devicessids where ssidid = (?)", id).first.first
  end

  def devices
    device_rows = Ssid.db.execute("SELECT * FROM devices
      WHERE id IN
      (SELECT deviceid FROM devicessids WHERE ssidid = (?))", id)
    device_rows.map do |row|
      Device.new(row)
    end
  end
end
