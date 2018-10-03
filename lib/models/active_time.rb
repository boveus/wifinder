class ActiveTime
  KLASSNAME = 'ActiveTime'
  TABLE_NAME = 'activetimes'
  include ModelMethods

  def initialize(row)
    @id = row[0]
    @device_id = row[1]
    @year = row[2]
    @month = row[3]
    @day = row[4]
    @hour = row[5]
    @minute = row[6]
    @second = row[7]
  end

  def self.time_to_a(time)
    dt = DateTime.strptime(time, '%Y-%m-%d %H:%M:%S')
    [dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second]
  end
end
