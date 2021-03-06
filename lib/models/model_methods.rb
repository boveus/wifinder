require 'sqlite3'
module ModelMethods
  def self.included(model)
    model.extend(ClassMethods)
  end

  module ClassMethods
    def db
      @@db ||= SQLite3::Database.new("./db/wifinder.db")
    end

    def table_name
      self.const_get(:TABLE_NAME)
    end

    def all
      db.execute("select * FROM #{table_name}").map do |row|
        self.new(row)
      end
    end

    def count
      db.execute("select COUNT(*) from #{table_name}")[0][0]
    end

    def find(id)
      result = db.execute("select * FROM #{table_name} WHERE id = (?)", id)
      result.first ? self.new(result.first) : false
    end

    def destroy(id)
      query_string = "?"
      if id.class == Array && id.count > 1
        id.count.times do
          query_string += ", ?"
        end
      end
      db.execute("DELETE FROM #{table_name} WHERE id IN (#{query_string});", id)
    end

    # example arguments={source: "Microsof_bd:8f:f3"}
    # This should be improved to account for multiple arguments
    def find_by(arguments)
      column = arguments.keys.first.to_s
      value = arguments.values.first.to_s
      row = db.execute("select * FROM #{table_name} WHERE #{column} = (?)", value).first
      row ? self.new(row) : false
    end
  end
end
