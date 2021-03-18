class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :favorites,      dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  
  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 300 }
  
  attachment :image
  
  acts_as_taggable_on :tags
end

