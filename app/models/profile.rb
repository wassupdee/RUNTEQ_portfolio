class Profile < ApplicationRecord
  belongs_to :user
  has_many :groups_profiles, dependent: :destroy
  has_many :groups, through: :groups_profiles
  has_many :albums, dependent: :destroy
  has_one :note, dependent: :destroy
  has_many :events, dependent: :destroy

  accepts_nested_attributes_for :events

  has_one_attached :avatar

  validates :avatar, processable_image: true,
                     content_type: %i[png jpeg],
                     size: { less_than: 1.megabytes , message: 'is too large' },
                     limit: { max: 1 }
end
