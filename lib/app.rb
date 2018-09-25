require 'rack'
require 'pry'
require './lib/templates/template'
require './config/routes'

class App
  def call(env)
    route_data = Routes.new(env).data
    route = route_data[:name]
    id = route_data[:id]
    status = (route.match(/^\d+$/) || "200").to_s
    response_body = Template.new(route, id: id).render

    [status, {}, [response_body]]
  end
end
