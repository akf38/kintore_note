class Genre < ApplicationRecord
  has_many :trainings
  
  validates :name, presence: true
end
