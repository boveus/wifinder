class Routes
  ROUTES = {
    "/device" => :device,
    "/devices" => :devices
  }

  def initialize(env)
    if env["REQUEST_METHOD"] == "GET"
      @name = ROUTES[env["REQUEST_PATH"]]
      @id = env["QUERY_STRING"]
    end
  end

  def data
    {name: @name,
    id: @id}
  end

  def name
    @name || "404"
  end
end
