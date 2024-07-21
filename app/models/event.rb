class Event < ApplicationRecord
  belongs_to :profile

  enum notification_enabled: { off: false, on: true }

  def ready_to_notify?
    self.date.present? && self.notification_timing.present? && self.notification_enabled?
  end
end
