class Event < ApplicationRecord
  belongs_to :profile

  enum notification_enabled: { off: false, on: true }

  validate :check_number_of_events, on: :create

  def ready_to_notify?
    date.present? && notification_timing.present? && notification_enabled?
  end

  def scheduled_to_notify_today?
    change_to_current_year - (change_utc_to_jst(DateTime.now)).to_date == notification_timing
  end

  def change_to_current_year
    Date.new(Date.today.year, date.mon, date.mday)
  end

  def change_utc_to_jst(datetime)
    datetime + 9.hours
  end

  def check_number_of_events
    errors.add(:events, "大切な日は１つまでしか登録できません") if profile&.events&.count == 2
  end
end
