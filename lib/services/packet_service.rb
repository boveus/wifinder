require 'pry'
require 'csv'
require './lib/models/packet'

class PacketService
  attr_reader :packets
  def initialize
    @path = './data'
    @packets = []
    @count = 0
    parse_packet_csvs
  end

  def parse_packet_csvs
    Dir.foreach(@path) do |filename|
      next if filename == '.' || filename == '..'
      csv = read("#{@path}/#{filename}")
      parse(csv)
    end
  end

  def read(csv)
    CSV.read(csv, { headers: true,
                          converters: :numeric,
                   header_converters: :symbol } )
  end

  def parse(csv)
    csv.each do |line|
      line[:id] = (@count += 1)
      @packets << Packet.new(line)
    end
  end
end
