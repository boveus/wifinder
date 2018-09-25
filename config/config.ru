require 'rack'
load './lib/app.rb'

Rack::Handler::WEBrick.run(
  App.new,
  :Port => 9000
)
