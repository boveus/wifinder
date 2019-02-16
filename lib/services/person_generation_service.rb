require './lib/models/device'
require './lib/models/ssid'
require './lib/models/active_time'
require 'sqlite3'
require 'pry'

class PersonGenerationService
  attr_reader :db

  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
  end

  def self.generate_people
    binding.pry
  end
end
