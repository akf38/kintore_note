class TrainingRecord < ApplicationRecord
  belongs_to :record
  belongs_to :training
  
  validates :training_id,  presence: true 
  validates :weight, presence: true
  validates :rep, presence: true
  validates :set, presence: true
end
