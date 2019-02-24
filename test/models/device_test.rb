require 'minitest/autorun'
require './lib/models/device'
require 'pry'

class PersonTest < Minitest::Test

  def create_ssids
    device = Device.find(1)
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


  def test_a_device_returns_interesting_devices
    ids = create_ssids
    device = Device.find(1)

    assert_equal Device.interesting_devices.first.mac_addr, device.mac_addr

    Ssid.destroy(ids)
  end

  def test_ssid_count_for_all_devices
    ids = create_ssids
    devices = Device.ssid_count_for_all_devices
    device_one_entry = devices.detect { |device| device.first.id == 1}
    device = Device.find(1)

    assert_equal devices.count, 10
    assert_equal device_one_entry[0].id, device.id
    assert_equal device_one_entry[1], device.ssid_count


    Ssid.destroy(ids)
  end
end
