require './lib/services/view_renderer'
require './lib/services/packet_ingestor'
require './lib/services/database_service'

DatabaseService.new
PacketIngestor.new('./data/test_data.csv').ingest
ViewRenderer.new.render

packets = Packet.find_by({source: "Apple_30:c9:f7"})
puts packets.count
