class Player < ApplicationRecord
  belongs_to :game, counter_cache: true
  has_many :hands, dependent: :destroy
  has_many :wins, through: :hands

  validates :name, presence: true
  validates :game, presence: true
end
