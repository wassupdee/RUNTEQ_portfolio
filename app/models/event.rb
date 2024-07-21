class Event < ApplicationRecord
  belongs_to :profile

  enum notification_enabled: { off: false, on: true }

  def is_ready_to_notify?
    date.present? && notification_timing.present? && notification_enabled?
  end

  def is_to_be_sent_today?
    change_to_current_year - (change_utc_to_jst(DateTime.now)).to_date == notification_timing
  end

  def change_to_current_year
    Date.new(Date.today.year, date.mon, date.mday)
  end

  def change_utc_to_jst(datetime)
    datetime + 9.hours
  end
end
