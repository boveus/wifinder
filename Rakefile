#!/usr/bin/env rake
task :app do
  require "./lib/app"
end
Dir[File.dirname(__FILE__) + "/tasks/*.rb"].sort.each do |path|
  require path
end
