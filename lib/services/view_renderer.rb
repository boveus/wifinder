require './lib/services/packet_service'
require 'sqlite3'
class ViewRenderer
  def initialize
    @db = SQLite3::Database.new("./db/wifinder.db")
    @home_page = File.open('./lib/views/home.html', 'w+')
  end

  def all_packets
  end

  def render
    @home_page.write(head)
    @home_page.write(table_header)
    @db.execute( "select * from packets" ) do |row|
      @home_page.write(pretty_print(row))
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

  def pretty_print(row)
    id = row[0]
    time = row[1]
    source = row[2]
    destination = row[3]
    protocol = row[4]
    info = row[5]
    "<tr id=#{id}>
      <td>#{time}</td>
      <td>#{source}</td>
      <td>#{destination}</td>
      <td>#{protocol}</td>
      <td>#{info}</td>
     </tr>"
  end
end
