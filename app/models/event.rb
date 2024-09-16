class Event < ApplicationRecord
  belongs_to :profile

  enum notification_enabled: { off: false, on: true }

  validate :check_number_of_events, on: :create

  def ready_to_notify?
    date.present? && notification_timing.present? && notification_enabled?
  end

  def scheduled_to_notify_today?
    event_date_this_year - utc_today_to_jst.to_date == notification_timing
  end

  def event_date_this_year
    Date.new(Date.today.year, date.mon, date.mday)
  end

  def utc_today_to_jst
    DateTime.now + 9.hours
  end

  def check_number_of_events
    errors.add(:events, "大切な日は１つまでしか登録できません") if profile&.events&.count == Settings.event_count.max_count
  end
end
