require './lib/models/model_methods'
require './lib/models/device'

class Person
  KLASSNAME = 'Person'
  TABLE_NAME = 'people'
  include ModelMethods

  attr_accessor :id,
                :nickname

  def initialize(data)
    @id = data[0]
    @nickname = data[1]
  end

  def self.find_or_create_by(attributes)
    Person.find_by(attributes) || Person.create(attributes)
  end

  def self.create(attributes)
    if find_by(nickname: attributes[:nickname])
      'A record with that nickname exists'
    else
      db.execute("INSERT INTO people (nickname) VALUES (?);", attributes[:nickname])
    end
    data = db.execute("SELECT * FROM people where nickname = (?);", attributes[:nickname]).first
    Person.new(data)
  end

  def self.all_nicknames
    db.execute("SELECT nickname FROM people").flatten
  end

  def add_device(device)
    return false unless device.class == Device
    Person.db.execute("INSERT INTO peopledevices (personID, deviceID) VALUES (?, ?)", [id, device.id])
    devices
  end

  def devices
    device_rows = Person.db.execute("SELECT * FROM devices
      WHERE id IN
      (SELECT deviceid FROM peopledevices WHERE personid = (?))", id)
    device_rows.map do |row|
      Device.new(row)
    end
  end
end
