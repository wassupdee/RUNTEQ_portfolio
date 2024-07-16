class Profile < ApplicationRecord
  belongs_to :user
  has_many :groups_profiles, dependent: :destroy
  has_many :groups, through :groups_profiles
  has_many :albums, dependent: :destroy
  has_one :note, dependent: :destroy
  has_many :events, dependent: :destroy
end
