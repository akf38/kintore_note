class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)

  attachment :image

  has_many :user_infos,    dependent: :destroy
  has_many :records,       dependent: :destroy
  has_many :tweets,        dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :tweet_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships,
                       source: :followed

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :followed, through: :passive_relationships,
                      source: :follower
                      
  has_many :active_notifications, class_name: "Notification",
                                  foreign_key: "visiter_id",
                                  dependent: :destroy
                                  
  has_many :passive_notifications, class_name: "Notification",
                                   foreign_key: "visited_id",
                                   dependent: :destroy
                                     

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name,                  presence: true
  validates :email,                 presence: true,
                                    uniqueness: true,
                                    format: { with: VALID_EMAIL_REGEX }
  validates :tall, numericality: {
    greater_than: 0,
    allow_blank: true,
  }
  validates :weight, numericality: {
    greater_than: 0,
    allow_blank: true,
  }
  validates :body_fat_percentage, numericality: {
    greater_than: 0,
    less_than: 100,
    allow_blank: true,
  }
  validates :profile, length: { maximum: 150 }

  # 筋トレ開始日のバリデーション（未来の日付入力を不可とする。）(user.rb内参照)
  validate :start_date_should_be_set_in_the_past

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

  # パスワードなしで更新を許可する
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # omniauthのコールバック時に呼ばれるメソッド
  # 既存ユーザーであればそのユーザーへ、新規ユーザーであれば新規作成したユーザーへ、emailとパスワードの値を追加で持たせる。（callbackメソッド内で使用)
  def self.from_omniauth(auth)
    pp auth
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # 筋トレ開始日のバリデーション（未来の日付入力を不可とする。）(&.でnilに対してでも通すようにする。)
  def start_date_should_be_set_in_the_past
    errors.add(:start_date, "は、本日より以前の日程を指定してください。") if start_date&.> DateTime.now
  end
  
  # フォロー通知作成
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
      notification.save if notification.valid?
    end
  end
  
  # ゲストユーザー作成
  def self.guest
    find_or_create_by!(email: 'guest_test@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = '筋肉ゲスト太郎'
    end
  end
end
