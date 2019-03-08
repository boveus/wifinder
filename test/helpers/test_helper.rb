module TestHelper
  def add_ten_ssids_to_device(id = 1)
    device = Device.find(id)
    i = 0
    ids = []

    10.times do
      i += 1
      ssid = Ssid.create(name: "test_#{i}")
      device.add_ssid(ssid)
      ids << ssid.id
    end
    return ids
  end

  def add_ten_devices_to_ssid(id = 1)
    ssid = Ssid.find(id)
    i = 0
    ids = []

    10.times do
      i += 1
      device = Device.create(name: "test_#{i}")
      ssid.add_device(device)
      ids << device.id
    end
    return ids
  end
end
