class Record < ApplicationRecord
  belongs_to :user
  has_many :training_records, dependent: :destroy
  
  validates :user_id,  presence: true
end
