class View
  def initialize(page, data = {})
    @page = page
    @data = data
    file = File.join(File.dirname(__FILE__), "#{page}.html.erb")
    @template = File.read(file)
  end

  def render
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end
end
