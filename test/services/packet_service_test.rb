require 'minitest/autorun'
require './lib/services/packet_service'
require 'pry'

class PacketServiceTest < Minitest::Test
  def setup
    @ps = PacketService.new('./test/fixtures')
  end

  def test_it_can_parse_the_csv
    assert_equal @ps.packets.size, 15
  end
end
