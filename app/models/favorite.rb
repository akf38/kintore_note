class Favorite < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :user_id,  presence: true
  validates :tweet_id, presence: true
end
