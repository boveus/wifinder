require './lib/services/packet_service'
require 'sqlite3'
class ViewRenderer
  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
    @home_page = File.open('./lib/views/home.html', 'w+')
  end

  def render
    @home_page.write(head)
    @home_page.write(table_header)
    Packet.all.each do |packet|
      @home_page.write(pretty_print(packet))
    end
    @home_page.write("</table")
  end

  def head
    "<head>
    <title>Analysis</title>
    <link rel='stylesheet' type='text/css' href='style.css' />
    </head>"
  end

  def table_header
    "<table>
      <tr>
        <th>time</th>
        <th>source</th>
        <th>destination</th>
        <th>protocol</th>
        <th>info</th>
      </tr>"
  end

  def pretty_print(packet)
    "<tr id=#{packet.id}>
      <td>#{packet.capturetime}</td>
      <td>#{packet.source}</td>
      <td>#{packet.destination}</td>
      <td>#{packet.protocol}</td>
      <td>#{packet.info}</td>
     </tr>"
  end
end
