require 'minitest/autorun'
require './lib/models/device'
require './test/helpers/test_helper'
require 'pry'

class PersonTest < Minitest::Test
  include TestHelper

  def test_a_device_returns_devices_with_more_than_five_ssids
    ids = add_ten_ssids_to_device
    device = Device.find(1)

    assert_equal Device.more_than_five_ssids.first.mac_addr, device.mac_addr

    Ssid.destroy(ids)
  end

  def test_ssid_count_for_all_devices
    ids = add_ten_ssids_to_device
    devices = Device.ssid_count_for_all_devices
    device_one_entry = devices.detect { |device| device.first.id == 1}
    device = Device.find(1)

    assert_equal devices.count, 10
    assert_equal device_one_entry[0].id, device.id
    assert_equal device_one_entry[1], device.ssid_count

    Ssid.destroy(ids)
  end
end
