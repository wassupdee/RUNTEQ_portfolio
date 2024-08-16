FactoryBot.define do
  factory :authentication do
    sequence(:provider) { |n| "provider_#{n}" }
    sequence(:uid) { |n| "uid_#{n}" }
  end
end
