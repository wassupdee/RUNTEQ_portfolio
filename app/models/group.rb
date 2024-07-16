class Group < ApplicationRecord
  belongs_to :user
  has_many :groups_profiles, dependent: :destroy
  has_many :profiles, through :groups_profiles
end
