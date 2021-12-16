class Event < ApplicationRecord
  scope :rdvs, -> { where(kind: 'appointment') }
  scope :opens, -> { where(kind: 'opening') }

  scope :range_open, ->(days) {
    opens.where(starts_at: days)
            .or(where('weekly_recurring = ? AND starts_at < ?', true, days.last.end_of_day))
  }

  scope :range_open_bis, -> (days) {
    opens.where(starts_at: days)
  }

  scope :appointments_day, ->(day) {
    rdvs
      .where(starts_at: day.beginning_of_day..day.end_of_day)
      .order(:starts_at)
  }

  def self.availabilities(date)
    availabilities = AvailableService.new(date)
    availabilities.call
  end

  #request_range_open = 'SELECT "events".* FROM "events" WHERE ("events"."kind" = ? AND "events"."starts_at" BETWEEN ? AND ? OR weekly_recurring = 1 AND starts_at < '2022-08-10 23:59:59.999999')'
end