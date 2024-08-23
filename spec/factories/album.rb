FactoryBot.define do
  factory :album do
    sequence(:date) { |n| Date.today - n.days }
    sequence(:title) { |n| "album_#{n}" }
    sequence(:diary) { |n| "diary_#{n}" }
  end
end
