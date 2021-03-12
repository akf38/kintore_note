class UserInfo < ApplicationRecord
  belongs_to :user
  
  validates :weight,              presence: true
  validates :body_fat_percentage, presence: true
  
end
