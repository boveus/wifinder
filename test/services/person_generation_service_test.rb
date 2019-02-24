require 'minitest/autorun'
require './lib/services/person_generation_service'
require './test/helpers/test_helper'
require 'pry'

class PacketServiceTest < Minitest::Test
  include TestHelper

  def test_it_generates_people_from_devices
    ids = add_ten_ssids_to_device

    assert_equal 0, Person.all.count

    PersonGenerationService.generate_people

    assert_equal 1, Person.all.count

    Ssid.destroy(ids)
  end
end
