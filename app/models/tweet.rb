class Tweet < ApplicationRecord
  belongs_to :user

  has_many :favorites,      dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :notifications,  dependent: :destroy

  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 300 }

  attachment :image

  acts_as_taggable_on :tags

  def self.get_self_and_following_tweets(user)
    Tweet.includes([:user]).where("user_id IN (?) OR user_id = ?", user.following_ids, user.id)
  end
  
  # いいね の通知作成を実行するメソッド
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(item_id: id, visited_id: user_id, action: 'like')
    notification.save if notification.valid?
  end
  
  # コメントの通知作成を実行するメソッド
  def create_notification_comment!(current_user, comment_id)
    # 自分以外のコメント済みユーザーを取得。その後、全員に通知を作成。
    tmp_ids = TweetComment.where(tweet_id: id).where.not(user_id: current_user.id).pluck(:user_id).push(self.user_id)
    tmp_ids.each do |tmp_id|
      save_notification_comment!(current_user, comment_id, tmp_id)
    end
    if tmp_ids.blank?
      save_notification_comment!(current_user, comment_id, user_id)
    end
  end
  
  # コメントの通知作成メソッド
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(item_id: id, comment_id: comment_id, visited_id: visited_id, action: 'comment')
    # 自分の投稿に対する自分のコメントは通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
end
