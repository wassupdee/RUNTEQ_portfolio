FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com"}
    sequence(:line_user_id) { |n| "line_user_id_#{n}" }
    notification_enabled { true }
    sequence(:name) { |n| "user_#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
