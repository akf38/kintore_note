class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  
  attachment :image
  
end

