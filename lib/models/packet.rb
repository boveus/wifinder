class Packet
    attr_accessor  :id,
                   :capturetime,
                   :source,
                   :destination,
                   :protocol,
                   :info

  def initialize(data)
    @id = data[:id]
    @capturetime = data[:time]
    @source = data[:source]
    @destination = data[:destination]
    @protocol = data[:protocol]
    @info = data[:info]
  end

  def self.create_from_row(row)
    Packet.new(
        { id: row[0],
        time: row[1],
        source: row[2],
        destination: row[3],
        protocol: row[4],
        info: row[5] })
  end

  def to_a
    [@id, @capturetime, @source, @destination, @protocol, @info]
  end

  # example arguments={source: "Microsof_bd:7f:f8"}
  def self.find_by(arguments)
    column = arguments.keys.first
    value = arguments.values.first
    db = SQLite3::Database.new("./db/wifinder.db")
    packets = []
    db.execute( "select * from packets WHERE #{column} = '#{value}'" ) do |row|
      packets << Packet.create_from_row(row)
    end
    packets
  end

  def self.all
    db = SQLite3::Database.new("./db/wifinder.db")
    packets = []
    db.execute( "select * from packets" ) do |row|
      packets << Packet.create_from_row(row)
    end
    packets
  end
end
