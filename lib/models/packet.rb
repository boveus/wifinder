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

  def self.db
    SQLite3::Database.new("./db/wifinder.db")
  end

  def to_a
    [@id, @capturetime, @source, @destination, @protocol, @info]
  end

  def self.query(sql_query)
    packets = []
    db.execute( sql_query ) do |row|
      packets << Packet.create_from_row(row)
    end
    packets
  end

  def ssid
    @info.split('=').last
  end

  def self.unique_ssids
    all.map(&:ssid).uniq
  end

  # example arguments={source: "Microsof_bd:8f:f3"}
  def self.find_by(arguments)
    column = arguments.keys.first
    value = arguments.values.first
    query("select * from packets WHERE #{column} = '#{value}'")
  end

  def self.all
    query("select * from packets" )
  end
end
