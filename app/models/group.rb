class Group < ApplicationRecord
  belongs_to :user
  has_many :profiles, dependent: :destroy
end
