class Profile < ApplicationRecord
  belongs_to :user
  has_many :groups_profiles, dependent: :destroy
  has_many :groups, through :groups_profiles
end
