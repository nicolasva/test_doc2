class EventsQuery
  attr_reader :relation

  def initialize(relation = Event.all)
    @relation = relation
  end

  def all_ranges_opens(date)
    relation.select('*')
            .from(range_open(date))
            .where("events_range_open.day IN ('#{get_days(date).join("','")}') AND events_range_open.weekly_recurring = 1")
  end

  private
  def range_open(date)
    "(#{request_open(date)}) as events_range_open"
  end

  def request_open(date)
    "SELECT 'events'.*, strftime('%d', events.starts_at) as day FROM 'events' 
    WHERE 'events'.'kind' = ? AND 'events'.'starts_at' BETWEEN ? AND ? OR weekly_recurring = 1 AND 
    starts_at < '#{date.last.end_of_day}'"
  end

  def get_days(date)
    date.map{|d|d.strftime("%d")}
  end
end