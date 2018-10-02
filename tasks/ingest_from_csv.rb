desc 'Populate the DB with CSVs from the data directory'
task :csv_ingest do
  ruby "./lib/ingest_from_csv.rb"
end
