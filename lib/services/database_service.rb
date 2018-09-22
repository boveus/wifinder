require 'sqlite3'
class DatabaseService
  def initialize
    drop
    find_or_create
    @db = SQLite3::Database.new("./db/wifinder.db")
    migrate
  end

  def find_or_create
    return true if @db
    `mkdir db && touch ./db/wifinder.db`
  end

  def migrate
    @db.execute <<-SQL
      create table packets (
        id int,
        capturetime date,
        source varchar,
        destination varchar,
        protocol varchar,
        info varchar
      );
    SQL
  end

  def drop
    `rm ./db/wifinder.db`
  end
end
