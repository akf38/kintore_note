class Tweet < ApplicationRecord
  belongs_to :user
  
  attachment :image
  
end

