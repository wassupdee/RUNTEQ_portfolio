class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :profiles, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :events, through: :profiles

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :notification_enabled, presence: true
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  enum notification_enabled: { off: false, on: true }

  def self.only_ready_to_notify
    where.not(line_user_id: nil).where(notification_enabled: :on)
  end
end
