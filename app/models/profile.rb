class Profile < ApplicationRecord
  belongs_to :user
  has_many :groups_profiles, dependent: :destroy
  has_many :groups, through: :groups_profiles
  has_many :albums, dependent: :destroy
  has_many :events, dependent: :destroy

  accepts_nested_attributes_for :events

  has_one_attached :avatar

  enum last_contacted: { within_one_month: 0, within_one_year: 1, within_three_years: 2, more_than_three_years: 3 }

  validates :avatar, processable_image: true,
                     content_type: %i[png jpeg],
                     size: { less_than: 1.megabytes, message: "is too large" },
                     limit: { max: 1 }

  def birthdays_this_month
    events.first.date&.month == Date.today.month
  end

  def special_days_this_month
    events.last.date&.month == Date.today.month
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name furigana line_name last_contacted]
  end
end
