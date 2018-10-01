desc 'setup the database without ingesting packets'
task :light_setup do
  ruby "./lib/light_setup_db.rb"
end
