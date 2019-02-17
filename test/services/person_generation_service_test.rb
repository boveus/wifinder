require 'minitest/autorun'
require './lib/services/person_generation_service'
require 'pry'

class PacketServiceTest < Minitest::Test
  def test_it_generates_people_from_devices
    assert_equal 0, Person.all.count

    PersonGenerationService.generate_people

    assert_equal 6, Person.all.count
  end
end
