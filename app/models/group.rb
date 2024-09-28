class Group < ApplicationRecord
  belongs_to :user
  has_many :profiles, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "name"]
  end
end
