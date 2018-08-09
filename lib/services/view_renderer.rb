require './lib/services/packet_service'
require 'sqlite3'
class ViewRenderer
  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
    @home_page = File.open('./lib/views/home.html', 'w+')
  end

  def all_packets
  end

  def render
    @db.execute( "select * from packets" ) do |row|
      @home_page.write("<p> #{row} </p> <br>")
    end
  end
end
