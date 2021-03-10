class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :favorites,      dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  
  attachment :image
  
  acts_as_taggable_on :tags
end

