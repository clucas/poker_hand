class Win < ApplicationRecord
  belongs_to :round
  belongs_to :hand

  validates :round, presence: true
  validates :hand, presence: true
end
