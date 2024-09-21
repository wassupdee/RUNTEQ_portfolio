FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "profile_#{n}" }
    sequence(:furigana) { |n| "ふりがな_#{n}" }
    sequence(:phone) { |n| "0901234#{format('%04d', n)}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    sequence(:line_name) { |n| "profile_#{n}" }
    sequence(:address) { |n| "address_#{n}" }
    sequence(:note) { |n| "note_#{n}" }
    last_contacted { %w[within_one_month within_one_year within_three_years more_than_three_years].sample }
  end
end
