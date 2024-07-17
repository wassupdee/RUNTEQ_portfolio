class Event < ApplicationRecord
  belongs_to :profile

  enum notification_enabled: { off: false, on: true }
end
