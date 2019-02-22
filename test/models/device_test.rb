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

    binding.pry

    Ssid.destroy(ids)
  end
end
