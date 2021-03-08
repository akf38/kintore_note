class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :image
  
  has_many :user_infos, dependent: :destroy
  has_many :records,    dependent: :destroy
  has_many :tweets,     dependent: :destroy
  
  validates :name,  presence: true 
  validates :email, presence: true, uniqueness: true
  validates :tall, presence: true
  validates :weight , presence: true
  validates :body_fat_percentage, presence: true
  
end
