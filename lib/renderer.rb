require './lib/views/device_view'
require './lib/models/device'

def device
  Device.all.first
end

def template
  File.read('./lib/views/test.html.erb')
end

dv = DeviceView.new(device, template)
dv.save('./lib/views/test_device.html')
