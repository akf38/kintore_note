class TrainingRecord < ApplicationRecord
  belongs_to :record
  belongs_to :training
  
  validates :training_id,  presence: true 
  validates :record_id,    presence: true
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rep, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :set, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
