FactoryBot.define do
  factory :question do
    sequence(:text) { |n| "question_#{n}" }
    sequence(:number) { |n| n }
  end
end
