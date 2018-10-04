module PacketIngestionBehavior
  def create_packet(packet)
    @db.execute("INSERT INTO packets (id, capturetime, source, destination, protocol, info, ssid)
              VALUES (?, ?, ?, ?, ?, ?, ?)", packet.to_a)
  end

  def create_ssid(ssid)
    @db.execute("INSERT OR IGNORE INTO ssids (name) VALUES (?)", ssid)
  end

  def create_device_ssid(source, packet_ssid)
    device_id = Device.find_by(mac_addr: source)
    ssid_id = Ssid.find_by(name: packet_ssid)
    if device_id && ssid_id
      @db.execute("INSERT INTO devicessids (deviceID, ssidID) VALUES(?, ?)", [device_id.id, ssid_id.id])
    end
  end

  def create_device(packet_source)
    if device_doesnt_exist?(packet_source)
      @db.execute("INSERT INTO devices (mac_addr)
                VALUES (?)", packet_source)
    end
  end

  def create_active_time(packet_time, source)
    data_row = ActiveTime.time_to_a(packet_time)
    device = Device.find_by(mac_addr: source)
    data_row.unshift(device.id)
    @db.execute("INSERT INTO activetimes (deviceID, year, month, day, hour, minute, second)
              VALUES (?, ?, ?, ?, ?, ?, ?)", data_row)
  end

  def device_doesnt_exist?(mac_addr)
    @db.execute("select * FROM devices WHERE mac_addr = (?)", mac_addr).length == 0
  end
end
