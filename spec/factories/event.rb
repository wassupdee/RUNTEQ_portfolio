FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "event_#{n}" }
    sequence(:date) { |n| Date.today - n.days }
    sequence(:notification_timing) { |n| n }
    notification_enabled { true }
  end
end
