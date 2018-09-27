require 'sqlite3'
require './lib/models/device'
require './lib/models/packet'
require './lib/models/model_methods'


class Ssid
  KLASSNAME = 'Ssid'
  TABLE_NAME = 'ssids'
  include ModelMethods

  attr_accessor :id,
                :name

  def initialize(row)
    @id = row[0]
    @name = row[1]
  end
end
