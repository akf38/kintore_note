class Tweet < ApplicationRecord
  belongs_to :user

  has_many :favorites,      dependent: :destroy
  has_many :tweet_comments, dependent: :destroy

  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 300 }

  attachment :image

  acts_as_taggable_on :tags

  def self.get_self_and_following_tweets(user)
    Tweet.includes([:user]).where("user_id IN (?) OR user_id = ?", user.following_ids, user.id)
  end
end
