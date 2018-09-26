require 'sqlite3'
require './lib/models/model_methods'
require './lib/models/packet'

class Device
  KLASSNAME = 'Device'
  TABLE_NAME = 'devices'
  include ModelMethods

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
    # This is gross and needs to be improved
    ssid_ids = Device.db.execute("select ssidid from devicessids WHERE deviceid = (?)", id).uniq
    ssid_ids.map do |id|
      Ssid.find(id)
    end
  end
end
