FactoryBot.define do
  factory :note do
    sequence(:content) { |n| "content_#{n}" }
  end
end
