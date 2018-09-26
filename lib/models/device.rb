require 'sqlite3'
require './lib/models/base_model'
require './lib/models/packet'

class Device < BaseModel
  attr_accessor :id,
                :mac_addr

  @@tablename = 'devices'
  @@klassname = 'Device'
  def initialize(row)
    @id = row[0]
    @mac_addr = row[1]
  end

  def ssids
    Packet.find_by(source: mac_addr).map(&:ssid).uniq
  end

  def self.find(id)
    result = db.execute("select * FROM devices WHERE id = (?)", id)
    Device.new(result.first)
  end
end
