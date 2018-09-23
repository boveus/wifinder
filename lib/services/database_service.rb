require 'sqlite3'
class DatabaseService
  def initialize
    create_folder
    create
    @db = SQLite3::Database.new("./db/wifinder.db")
    migrate
  end

  def create_folder
    return if Dir.exist?('./db/')
    `mkdir db `
  end

  def create
    `touch ./db/wifinder.db`
  end

  def migrate
    create_packets_table
    create_devices_table
  end

  def create_devices_table
    @db.execute <<-SQL
      create table devices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mac_addr varchar
      );
    SQL
  end

  def create_packets_table
    @db.execute <<-SQL
      create table packets (
        id INTEGER PRIMARY KEY,
        capturetime date,
        source varchar,
        destination varchar,
        protocol varchar,
        info varchar,
        ssid varchar
      );
    SQL
  end
end
