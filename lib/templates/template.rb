require './lib/models/device'
require './lib/models/ssid'
class Template
  def initialize(page, data = {})
    @data = data
    @page = page

    file = File.join(File.dirname(__FILE__), "#{page}.html.erb")

    @template = File.read(file)
  end

  def ssids
    Ssid.all
  end

  def ssid
    Ssid.find(@data[:id])
  end

  def devices
    Device.all
  end

  def device
    Device.find(@data[:id])
  end

  def render
    ERB.new(@template).result(binding)
  end
end
