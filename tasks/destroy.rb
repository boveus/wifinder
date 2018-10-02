desc 'Delete the DB'
task :destroy do
  `rm db/wifinder.db`
end
