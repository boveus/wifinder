require 'erb'

class DeviceView
  include ERB::Util
  attr_accessor :device, :template, :date

  def initialize(device, template)
    @device = device
    @template = template
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
