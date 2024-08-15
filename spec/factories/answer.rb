FactoryBot.define do
  factory :answer do
    sequence(:text) { |n| "answer_#{n}" }
    sequence(:value) { |n| "answer_#{n}" }
    sequence(:number) { |n| n }
  end
end
