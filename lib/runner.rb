require './lib/services/view_renderer'
require './lib/services/packet_ingestor'
require './lib/services/database_service'

DatabaseService.new
PacketIngestor.new.ingest
ViewRenderer.new.render

puts Packet.all.count
# puts 'Unique Sources'
# puts ' ----- '
# puts Packet.unique_sources
# puts ' ----- '
# puts 'Unique SSIDs'
# puts ' ---- '
# puts Packet.unique_ssids
# puts ' ---- '
