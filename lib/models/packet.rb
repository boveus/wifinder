require './lib/models/model_methods'
class Packet
    KLASSNAME = 'Packet'
    TABLE_NAME = 'packets'
    include ModelMethods

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
        { time: row[1],
        source: row[2],
        destination: row[3],
        protocol: row[4],
        info: row[5] })
  end

  def self.last_id
    db.execute("SELECT rowid from packets order by ROWID DESC limit 1")
  end

  # find is different for packets, because it is created from a Hash
  # instead of from an array like the other models.
  # todo: refactor this to behave like the other models and get rid of this.
  def self.find(id)
    result = db.execute("select * FROM #{table_name} WHERE id = (?)", id)
    result.first ? self.create_from_row(result.first) : false
  end

  def self.all
    db.execute("select * from packets" ).map do |row|
      Packet.create_from_row(row)
    end
  end

  def self.count
    db.execute("select COUNT(*) from packets")[0][0]
  end

  def to_a
    [@id, @capturetime, @source, @destination, @protocol, @info, @ssid]
  end

  def self.unique_ssids
    db.execute("select DISTINCT ssid FROM packets")
  end

  def self.unique_sources
    db.execute("select DISTINCT source FROM packets")
  end
end
