require 'pry'
require 'csv'
require './lib/models/packet'

class PacketService
  def initialize(packet_csv)
    @packet_csv = packet_csv
    @packets = []
  end

  def csv
    CSV.read( @packet_csv, { headers: true,
                          converters: :numeric,
                   header_converters: :symbol } )
  end

  def parse
    csv.each do |line|
      @packets << Packet.new(line)
    end
  end
end
