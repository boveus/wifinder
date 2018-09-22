require 'sqlite3'
class DatabaseService
  def initialize
    drop
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

  def drop
    `rm ./db/wifinder.db`
  end
end
