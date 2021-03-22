class UserInfo < ApplicationRecord
  belongs_to :user

  validates :weight,              presence: true, numericality: { greater_than: 0 }
  validates :body_fat_percentage, presence: true, numericality: { greater_than: 0, less_than: 100 }
end
