FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "profile_#{n}" }
    sequence(:furigana) { |n| "ふりがな_#{n}" }
    sequence(:phone) { |n| "0901234#{format('%04d', n)}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    sequence(:line_name) { |n| "profile_#{n}" }
    sequence(:birthplace) { |n| "birthplace_#{n}" }
    sequence(:address) { |n| "address_#{n}" }
    sequence(:occupation) { |n| "occupation_#{n}" }
  end
end
