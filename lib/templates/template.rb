require './lib/models/device'
class Template
  def initialize(page, data = {})
    @data = data
    @page = page

    file = File.join(File.dirname(__FILE__), "#{page}.html.erb")

    @template = File.read(file)
  end

  def device_count
    Device.count
  end

  def ssid_count
    Ssid.count
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
