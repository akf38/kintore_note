class Training < ApplicationRecord
  belongs_to :genre
  belongs_to :part

  has_many :training_records

  validates :part_id, presence: true
  validates :genre_id, presence: true
end
