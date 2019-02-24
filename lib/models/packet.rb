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

  def initialize(row)
    @id = row[0]
    @capturetime = row[1]
    @source = row[2]
    @destination = row[3]
    @protocol = row[4]
    @info = row[6]
    @ssid = row[6]&.split('=').last || nil
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
