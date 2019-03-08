require 'minitest/autorun'
require './lib/models/ssid'
require './test/helpers/test_helper'
require 'pry'

class SsidTest < Minitest::Test
  include TestHelper

  def test_an_ssid_returns_ssids_with_more_than_five_ssids
    ids = add_ten_devices_to_ssid
    ssid = Ssid.find(1)

    assert_equal Ssid.more_than_five_devices.first.name, ssid.name

    Ssid.destroy(ids)
  end
end
