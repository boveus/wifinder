require 'minitest/autorun'
require './lib/services/packet_service'
require './lib/models/person'
require 'pry'

class PersonTest < Minitest::Test
  def test_a_person_can_have_devices
    Person.create(nickname: 'test_person')
    person = Person.all.first
    person.add_device(Device.all.first)

    assert_equal Device.all.first.id, person.devices.first.id
    Person.destroy(person.id)
  end
end
