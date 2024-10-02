class Album < ApplicationRecord
  belongs_to :profile

  has_many_attached :images

  validates :images, processable_image: true,
                     content_type: %i[png jpeg],
                     size: { less_than: 3.megabytes, message: "is too large" },
                     limit: { max: 2 }
end
