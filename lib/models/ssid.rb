require 'sqlite3'
require './lib/models/device'
require './lib/models/packet'
require './lib/models/base_model'

@@tablename = 'ssids'
@@klassname = 'Ssid'
class Ssid < BaseModel
  attr_accessor :id,
                :name

  @@tablename = 'ssids'
  def initialize(row)
    @id = row[0]
    @name = row[1]
  end

  def self.find(id)
    result = db.execute("select * FROM ssids WHERE id = (?)", id)
    Ssid.new(result.first)
  end

  def self.query(sql_query)
    ssids = []
    db.execute( sql_query ) do |row|
      ssids << Ssid.new(row)
    end
    ssids
  end
end
