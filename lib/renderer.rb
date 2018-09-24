require './lib/views/device_view'
require './lib/models/device'
class DeviceRenderer
  def device
    Device.all.first
  end

  def template
    File.read('./lib/views/test.html.erb')
  end
end
