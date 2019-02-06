require './lib/models/model_methods'

class Person
  KLASSNAME = 'Person'
  TABLE_NAME = 'people'
  include ModelMethods

  def initialize(data)
    @id = data[0]
    @nickname = data[1]
  end

  def self.create(attributes)
    if find_by(nickname: attributes[:nickname])
      'A record with that nickname exists'
    else
      db.execute("INSERT INTO people (nickname) VALUES (?);", attributes[:nickname])
    end
  end
end
