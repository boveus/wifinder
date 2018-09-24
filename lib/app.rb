require 'rack'
require './lib/templates/template'
require './config/routes'

class App
  def call(env)
    route = Route.new(env).name
    status = (route.match(/^\d+$/) || "200").to_s
    response_body = Template.new(route, visit_count: parse_session_count_cookie(env)).render

    [status, {}, [response_body]]
  end

  def parse_session_count_cookie(env)
    Rack::Utils.parse_cookies(env)["session_count"]
  end
end
