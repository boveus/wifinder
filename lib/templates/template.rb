require './lib/models/device'
require './lib/models/person'
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

  def ssids
    Ssid.all
  end

  def ssid
    Ssid.find(@data[:id])
  end

  def devices
    Device.all
  end

  def all_people
    Person.all_nicknames
  end

  def device
    Device.find(@data[:id])
  end

  def render
    ERB.new(@template).result(binding)
  end
end
