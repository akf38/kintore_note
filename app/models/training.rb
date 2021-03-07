class Training < ApplicationRecord
  belongs_to :genre
  belongs_to :part
  
  has_many :training_records
end
