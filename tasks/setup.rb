desc 'setup the database'
task :setup do
  ruby "./lib/setup_db.rb"
end
