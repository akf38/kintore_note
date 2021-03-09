class TweetComment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  
  validates :tweet_id, presence: true
  validates :user_id,  presence: true
  validates :content,  presence: true
  
  attachment :image
end
