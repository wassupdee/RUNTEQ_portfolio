FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "event_#{n}" }
    sequence(:date) { |n| Date.today - n.days }
    notification_timing { [0,1,3,7,14,30,60].sample }
    notification_enabled { true }
  end
end
