require 'sqlite3'
require './lib/models/model_methods'
require './lib/models/packet'
require './lib/models/ssid'

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

  def active_hours(day=Time.now.day, month=Time.now.month)
    Device.db.execute("SELECT DISTINCT hour from
    activetimes where deviceid = (?) AND day = (?) AND month = (?)", [id, day, month])
  end

  def all_active_hours
    Device.db.execute("SELECT DISTINCT hour from
    activetimes where deviceid = (?)", id)
  end

  def all_active_hours_for_chart
    all_active_hours.each_with_index.map do |hour, index|
      index == 0 ? comma = '' : comma = ','
      "#{comma}['active', new Date(0,0,0,#{hour.first},0,0), new Date(0,0,0,#{hour.first + 1},0,0)]"
    end
  end

  def active_days(month=Time.now.month)
    Device.db.execute("SELECT DISTINCT day from
    activetimes where deviceid = (?) AND month = (?)", [id, month]).first
  end

  def ssid_count
    Device.db.execute("SELECT COUNT(DISTINCT devicessids.ssidid) from
    devicessids where deviceid = (?)", id).first.first
  end

  def ssids
    ssid_rows = Device.db.execute("SELECT * FROM ssids
      WHERE id IN
      (SELECT ssidid FROM devicessids WHERE deviceid = (?))", id)
    ssid_rows.map do |row|
      Ssid.new(row)
    end
  end
end
