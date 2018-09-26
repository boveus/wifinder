module ModelMethods
  def self.included(model)
    model.extend(ClassMethods)
  end

  module ClassMethods
    def db
      @@db ||= SQLite3::Database.new("./db/wifinder.db")
    end

    def all
      db.execute("select * FROM #{self.const_get(:TABLE_NAME)}")
    end

    def count
      all.count
    end

    # example arguments={source: "Microsof_bd:8f:f3"}
    def find_by(arguments)
      column = arguments.keys.first.to_s
      value = arguments.values.first.to_s
      row = db.execute("select * FROM #{self.const_get(:TABLE_NAME)} WHERE (?) = (?)", column, value).first
      if row
        self.new(row)
      else
        false
      end
    end
  end
end
