require 'pry'
require 'csv'
require './lib/models/packet'

class PacketService
  attr_reader :packets
  def initialize(packet_csv)
    @packet_csv = packet_csv
    @packets = []
    parse
  end

  def csv
    CSV.read( @packet_csv, { headers: true,
                          converters: :numeric,
                   header_converters: :symbol } )
  end

  def parse
    csv.each_with_index do |line, index|
      line[:id] = index + 1
      @packets << Packet.new(line)
    end
  end
end
