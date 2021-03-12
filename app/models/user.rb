class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :image
  
  has_many :user_infos,    dependent: :destroy
  has_many :records,       dependent: :destroy
  has_many :tweets,        dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :tweetcomments, dependent: :destroy
  
  has_many :active_relationships,  class_name:   "Relationship",
                                   foreign_key:  "follower_id",
                                   dependent:    :destroy
                                   
  has_many :following,             through:      :active_relationships,
                                   source:       :followed
  
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  
  has_many :followed,              through:     :passive_relationships,
                                   source:      :follower
  
  validates :name,  presence: true 
  validates :email, presence: true, uniqueness: true
  
  # フォローする
  def follow(other_user)
    following << other_user
  end
  
  # フォローを外す
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # フォロー中か確認する。フォロー中 = true
  def following?(other_user)
    following.include?(other_user)
  end
  
end
