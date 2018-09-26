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
    create_ssids_table
    create_device_ssids_table
  end

  def create_devices_table
    @db.execute <<-SQL
      create table devices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mac_addr varchar
      );
    SQL
  end

  def create_device_ssids_table
    @db.execute <<-SQL
      create table devicessids (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        deviceID INTEGER REFERENCES devices,
        ssidID INTEGER REFERENCES ssids
      );
    SQL
  end

  def create_ssids_table
    @db.execute <<-SQL
      create table ssids (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name varchar,
        UNIQUE(name)
      );
    SQL
  end

  def create_packets_table
    @db.execute <<-SQL
      create table packets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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
