require './lib/models/ssid'
class PersonGenerationService
  attr_reader :db

  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def self.generate_people(number = 1)
    Ssid.all.each do |ssid|
      nickname = "Person-#{number}"
      Person.create(nickname: nickname)
      person = Person.find_by(nickname: nickname)
      ssid.devices.each do |device|
        person.add_device(device)
      end
      number += 1
    end
  end
end
