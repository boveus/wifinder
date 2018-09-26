require 'sqlite3'
require './lib/models/device'
require './lib/models/packet'

class Ssid
  attr_accessor :id,
                :name

  def initialize(row)
    @id = row[0]
    @name = row[1]
  end

  def self.db
    @@db ||= SQLite3::Database.new("./db/wifinder.db")
  end

  def self.count
    all.count
  end

  def self.find(id)
    result = db.execute("select * FROM ssids WHERE id = (?)", id)
    Ssid.new(result.first)
  end

  def self.find_by(arguments)
    column = arguments.keys.first
    value = arguments.values.first
    row = db.execute("select * from ssids WHERE #{column} = (?)", value).first
    Ssid.new(row)
  end

  def self.all
    query("select * FROM ssids" )
  end

  def self.query(sql_query)
    ssids = []
    db.execute( sql_query ) do |row|
      ssids << Ssid.new(row)
    end
    ssids
  end
end
