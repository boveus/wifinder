require './lib/services/database_service'
require './lib/services/packet_service'
require './lib/services/packet_ingestor'

desc 'Set up database for running automated tests'
task :test_setup do
  DatabaseService.new
  PacketIngestor.new('./test/fixtures').ingest
end
