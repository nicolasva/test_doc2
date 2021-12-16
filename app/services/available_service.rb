class AvailableService
  def initialize(date)
    Time::DATE_FORMATS[:short_time] = '%-k:%M'
    @date = date
    @days = date..(date + 6.days)
    @range_open = Event.range_open(@days)
  end

  attr_reader :date, :range_open, :days

  def slots
    slots = []
    events_query = EventsQuery.new.all_ranges_opens(days)
    dates = events_query.pluck(:starts_at, :ends_at)
    events_query.select do |opening|
      time = opening.starts_at
      arr = []
      while time < opening.ends_at
        arr << time.to_s(:short_time)
        time += 30.minutes
      end
      slots << { date: opening.starts_at.to_date, slots: arr }
    end
    slots
  end
end
