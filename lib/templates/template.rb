class Template
  def initialize(page, data = {})
    @data = data
    @page = page

    file = File.join(File.dirname(__FILE__), "#{page}.html.erb")

    @template = File.read(file)
  end

  def visit_count
    @data[:visit_count]
  end

  def render
    ERB.new(@template).result(binding)
  end
end
