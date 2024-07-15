class Answer < ApplicationRecord
  belongs_to :question
  validates :value, uniqueness: true
end
