class Packet
    attr_accessor  :time,
                   :source,
                   :destination,
                   :protocol,
                   :info

  def initialize(data)
    @time = data[:time]
    @source = data[:source]
    @destination = data[:destination]
    @protocol = data[:protocol]
    @info = data[:info]
  end

end
