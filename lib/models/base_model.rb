class BaseModel
  attr_accessor :id
  
  @@tablename = 'base'
  @@klassname = 'BaseModel'
  @@klass = Object.const_get(@@klassname)
  def initialize(data)
    @id = 'test'
  end

  def self.db
    @db ||= SQLite3::Database.new("./db/wifinder.db")
  end

  def self.all
    db.execute("select * FROM #{@@tablename}")
  end

  def self.count
    all.count
  end

  # example arguments={source: "Microsof_bd:8f:f3"}
  def self.find_by(arguments)
    column = arguments.keys.first.to_s
    value = arguments.values.first.to_s
    row = db.execute("select * FROM #{@@tablename} WHERE (?) = (?)", column, value).first
    @@klass.new(row)
  end
end
