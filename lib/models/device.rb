require 'sqlite3'
require './lib/models/model_methods'

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

  def self.create(attributes)
    if find_by(mac_addr: attributes[:mac_addr])
      'A record with that nickname exists'
    else
      db.execute("INSERT INTO devices (mac_addr) VALUES (?);", [attributes[:mac_addr]])
      device = Device.find(db.last_insert_row_id)
      device ? device : false
    end
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

  def self.more_than_five_ssids
    Device.db.execute("SELECT deviceid, devices.mac_addr, COUNT(deviceid) as ssidcount FROM devicessids
    INNER JOIN devices ON devices.id = devicessids.deviceID
    GROUP by deviceid HAVING ssidcount > 5").map do |result|
      Device.new([result[0], result[1]])
    end
  end

  def self.ssid_count_for_all_devices
    Device.db.execute("SELECT deviceid, devices.mac_addr, COUNT(deviceid) as ssidcount FROM devicessids
    INNER JOIN devices ON devices.id = devicessids.deviceID
    GROUP by deviceid").map do |result|
      [Device.new([result[0], result[1]]), result[2]]
    end
  end

  def add_ssid(ssid)
    return false unless ssid.class == Ssid
    Device.db.execute("INSERT INTO devicessids (deviceID, ssidID) VALUES (?, ?)", [id, ssid.id])
    ssids
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
