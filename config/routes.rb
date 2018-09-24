class Route

  ROUTES = {
    "/garbatella" => :garbatella,
    "/testaccio" => :testaccio,
    "/eur" => :eur
  }

  def initialize(env)
    if env["REQUEST_METHOD"] == "GET"
      @name = ROUTES[env["REQUEST_PATH"]]
    end
  end

  def name
    @name || "404"
  end
end
