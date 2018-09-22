class Packet
    attr_accessor  :id,
                   :capturetime,
                   :source,
                   :destination,
                   :protocol,
                   :info,
                   :ssid

  def initialize(data)
    @id = data[:id]
    @capturetime = data[:time]
    @source = data[:source]
    @destination = data[:destination]
    @protocol = data[:protocol]
    @info = data[:info]
    @ssid = data[:info].split('=').last
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

  def self.last_id
    db.execute("SELECT rowid from packets order by ROWID DESC limit 1")
  end

  def to_a
    [@id, @capturetime, @source, @destination, @protocol, @info, @ssid]
  end

  def self.query(sql_query)
    packets = []
    db.execute( sql_query ) do |row|
      packets << Packet.create_from_row(row)
    end
    packets
  end

  def self.unique_ssids
    db.execute("select DISTINCT ssid FROM packets")
  end

  def self.unique_sources
    db.execute("select DISTINCT source FROM packets")
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
